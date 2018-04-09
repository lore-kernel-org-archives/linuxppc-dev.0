Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KPTQ2CbWzF2B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 19:02:50 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 201so9168pgg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 02:02:50 -0700 (PDT)
Date: Mon, 9 Apr 2018 19:02:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/6] powerpc/powernv: implement opal_put_chars_nonatomic
Message-ID: <20180409190238.60be5792@roar.ozlabs.ibm.com>
In-Reply-To: <1523262286.11062.16.camel@kernel.crashing.org>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-6-npiggin@gmail.com>
 <1523253475.11062.10.camel@kernel.crashing.org>
 <20180409162314.20e486c3@roar.ozlabs.ibm.com>
 <1523262286.11062.16.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 09 Apr 2018 18:24:46 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2018-04-09 at 16:23 +1000, Nicholas Piggin wrote:
> > On Mon, 09 Apr 2018 15:57:55 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >   
> > > On Mon, 2018-04-09 at 15:40 +1000, Nicholas Piggin wrote:  
> > > > The RAW console does not need writes to be atomic, so implement a
> > > > _nonatomic variant which does not take a spinlock. This API is used
> > > > in xmon, so the less locking thta's used, the better chance there is
> > > > that a crash can be debugged.    
> > > 
> > > I find the term "nonatomic" confusing...  
> > 
> > I guess it is to go with the "atomic" comment for the hvsi console
> > case -- all characters must get to the console together or not at
> > all.  
> 
> Yeah ok, it's just that in Linux "atomic" usually means something else
> :-) Why not just call it "unlocked" which is what it's about and
> matches existing practices thorough the kernel ?

Sure, I'll change it.
 
> > > don't we have a problem if we
> > > start hitting OPAL without a lock where we can't trust
> > > opal_console_write_buffer_space anymore ? I think we need to handle
> > > partial writes in that case. Maybe we should return how much was
> > > written and leave the caller to deal with it.  
> > 
> > Yes, the _nonatomic variant doesn't use opal_console_write_buffer_space
> > and it does handle partial writes by returning written bytes (although
> > callers generally tend to loop at the moment, we might do something
> > smarter with them later).
> >   
> > > I was hoping (but that isn't the case) that by nonatomic you actually
> > > meant calls that could be done in a non-atomic context, where we can do
> > > msleep instead of mdelay. That would be handy for the console coming
> > > from the hvc thread (the tty one).  
> > 
> > Ah right, no. However we no longer loop until everything is written, so
> > the hvc console driver (or the console layer) should be able to deal with
> > that with sleeping. I don't think we need to put it at this level of the
> > driver, but I don't know much about the console code.  
> 
> Ok, so hopefully we shouldn't be hitting the delay..

I *think* so. It may actually hit it once on the way out, but I don't
know if it's worth adding a new API to avoid it. Probably warrants
somebody to take a look and measure things though.

Actually I did just take a look. The bigger problem actually is because
we do the console flush here and even the "good" hvc path holds an irq
lock in this case:

   dmesg-8334   12d...    0us : _raw_spin_lock_irqsave
   dmesg-8334   12d...    0us : hvc_push <-hvc_write
   dmesg-8334   12d...    1us : opal_put_chars_nonatomic <-hvc_push
   dmesg-8334   12d...    1us : __opal_put_chars <-hvc_push
   dmesg-8334   12d...    2us : opal_flush_console <-__opal_put_chars
   dmesg-8334   12d...    4us!: udelay <-opal_flush_console
   dmesg-8334   12d...  787us : soft_nmi_interrupt <-soft_nmi_common
   dmesg-8334   12d...  787us : printk_nmi_enter <-soft_nmi_interrupt
   dmesg-8334   12d.Z.  788us : rcu_nmi_enter <-soft_nmi_interrupt
   dmesg-8334   12d.Z.  788us : rcu_nmi_exit <-soft_nmi_interrupt
   dmesg-8334   12d...  788us#: printk_nmi_exit <-soft_nmi_interrupt
   dmesg-8334   12d... 10005us*: udelay <-opal_flush_console
   dmesg-8334   12d... 20007us*: udelay <-opal_flush_console
   dmesg-8334   12d... 30020us*: udelay <-opal_flush_console
   dmesg-8334   12d... 40022us*: udelay <-opal_flush_console
   dmesg-8334   12d... 50023us*: udelay <-opal_flush_console
   dmesg-8334   12d... 60024us : opal_error_code <-opal_flush_console
   dmesg-8334   12d... 60025us : _raw_spin_unlock_irqrestore <-hvc_write
   dmesg-8334   12d... 60025us : _raw_spin_unlock_irqrestore
   dmesg-8334   12d... 60025us : trace_hardirqs_on <-_raw_spin_unlock_irqrestore
   dmesg-8334   12d... 60027us : <stack trace>

60ms interrupt off latency waiting for the console to flush (just
running `dmesg` from OpenBMC console).

That requires some reworking of the hvc code, we can't fix it in
the OPAL driver alone.

Thanks,
Nick

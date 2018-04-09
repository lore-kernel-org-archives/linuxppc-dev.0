Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KNdl3F7TzDrSD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 18:24:59 +1000 (AEST)
Message-ID: <1523262286.11062.16.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/powernv: implement opal_put_chars_nonatomic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Apr 2018 18:24:46 +1000
In-Reply-To: <20180409162314.20e486c3@roar.ozlabs.ibm.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
 <20180409054056.27292-6-npiggin@gmail.com>
 <1523253475.11062.10.camel@kernel.crashing.org>
 <20180409162314.20e486c3@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-09 at 16:23 +1000, Nicholas Piggin wrote:
> On Mon, 09 Apr 2018 15:57:55 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2018-04-09 at 15:40 +1000, Nicholas Piggin wrote:
> > > The RAW console does not need writes to be atomic, so implement a
> > > _nonatomic variant which does not take a spinlock. This API is used
> > > in xmon, so the less locking thta's used, the better chance there is
> > > that a crash can be debugged.  
> > 
> > I find the term "nonatomic" confusing...
> 
> I guess it is to go with the "atomic" comment for the hvsi console
> case -- all characters must get to the console together or not at
> all.

Yeah ok, it's just that in Linux "atomic" usually means something else
:-) Why not just call it "unlocked" which is what it's about and
matches existing practices thorough the kernel ?

> > don't we have a problem if we
> > start hitting OPAL without a lock where we can't trust
> > opal_console_write_buffer_space anymore ? I think we need to handle
> > partial writes in that case. Maybe we should return how much was
> > written and leave the caller to deal with it.
> 
> Yes, the _nonatomic variant doesn't use opal_console_write_buffer_space
> and it does handle partial writes by returning written bytes (although
> callers generally tend to loop at the moment, we might do something
> smarter with them later).
> 
> > I was hoping (but that isn't the case) that by nonatomic you actually
> > meant calls that could be done in a non-atomic context, where we can do
> > msleep instead of mdelay. That would be handy for the console coming
> > from the hvc thread (the tty one).
> 
> Ah right, no. However we no longer loop until everything is written, so
> the hvc console driver (or the console layer) should be able to deal with
> that with sleeping. I don't think we need to put it at this level of the
> driver, but I don't know much about the console code.

Ok, so hopefully we shouldn't be hitting the delay..

Cheers,
Ben.

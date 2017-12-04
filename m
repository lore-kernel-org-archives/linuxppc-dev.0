Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqvfr322SzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 17:12:20 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id v26so7795431pfl.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 22:12:20 -0800 (PST)
Date: Mon, 4 Dec 2017 16:12:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171204161206.3ee101db@roar.ozlabs.ibm.com>
In-Reply-To: <20171204054914.GP2130@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
 <20171130051126.GE3023@umbus.fritz.box>
 <87mv32bt3d.fsf@concordia.ellerman.id.au>
 <20171201214038.2bf70cba@roar.ozlabs.ibm.com>
 <20171204054914.GP2130@umbus.fritz.box>
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

On Mon, 4 Dec 2017 16:49:14 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 01, 2017 at 09:40:38PM +1000, Nicholas Piggin wrote:
> > On Fri, 01 Dec 2017 22:11:50 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >   
> > > David Gibson <david@gibson.dropbear.id.au> writes:
> > >   
> > > > On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote:    
> > > >> On Wed, 29 Nov 2017 15:06:52 +1100
> > > >> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >>     
> > > >> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
> > > >> > purports to fix a problem when the kernel panics with fadump not
> > > >> > registered, but it breaks something else instead.  I _think_ it was
> > > >> > working on the incorrect assumption that ppc_md.panic was (or should
> > > >> > be) only used with fadump, but I'm not really sure.
> > > >> > 
> > > >> > Panic works with kdump enabled, and (I think) with fadump enabled).
> > > >> > However, with neither of these enabled, we always go to the generic
> > > >> > panic logic.    
> > > >> 
> > > >> Yeah thanks, I can't remember what assumption I was working on tbh.
> > > >>      
> > > >> > That's incorrect for PAPR guests - they should call ibm,os-term via
> > > >> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
> > > >> > which higher-level management pays attention to.  Since a3b2cb30 we
> > > >> > now reboot instead of reporting that.
> > > >> > 
> > > >> > I believe it will also break panic for PS3 machines, but since that
> > > >> > platform basically no longer exists, we probably don't care.    
> > > >> 
> > > >> I (hope) it should just go down to the normal panic path and not do
> > > >> much worse than it already does -- although it won't print out that
> > > >> message.
> > > >>     
> > > >> > I'm not entirely sure how to fix this.  I _think_ what we want is to
> > > >> > call ppc_md.panic from a late panic notifier, the way this patch does
> > > >> > for fadump_panic_event() if fadump is registered.    
> > > >> 
> > > >> The problem I had there is that some of the printk and console stuff
> > > >> wasn't getting flushed out, so I was getting a blank screen. This was
> > > >> probably in conjunction with panicing from NMI context that we're now
> > > >> starting to introduce.
> > > >> 
> > > >> So it's a bit annoying. There's other ugliness we have for being unable
> > > >> to control panic code well enough from arch code
> > > >> (arch/powerpc/platforms/powernv/opal.c)
> > > >> 
> > > >> I guess a really minimal fix is to put an #ifdef powerpc down the bottom
> > > >> there (/me *cries*).    
> > > >
> > > > Um.. right.  I'm not really sure from that how to go forward from
> > > > here.  We want to fix this for RHEL7.5, which doesn't give us a lot of
> > > > time.
> > > >
> > > > Adding the #ifdef at the bottom of the generic panic code is gross,
> > > > but there's already a bunch of that, so maybe adequate until a better
> > > > solution can be found?    
> > > 
> > > I think you mean put an #ifdef at the bottom of panic(). If so that
> > > won't work. Our default panic_timeout is 180 so we never get to the
> > > bottom of panic(), we call emergency_restart().
> > > 
> > > You *could* put an #ifdef powerpc before that, but that's even more
> > > gross because it's in a different place to the sparc/s390 #ifdefs.
> > > 
> > > I notice we don't implement machine_emergency_restart(), it just
> > > becomes machine_restart(NULL).
> > > 
> > > So it seems like that's the place we should be hooking,
> > > machine_emergency_restart(). That's what x86 does.
> > > 
> > > But panic() is not the only caller of emergency_restart(), so it's not
> > > an entirely straight forward conversion.
> > > 
> > > So I think for 4.15 and 4.14 I'm inclined to revert. Then we can do a
> > > bigger rework for 4.16.
> > > 
> > > Nick that shouldn't break your original aim too badly I think? ie. worst
> > > case is we panic() but don't see the output if we came from NMI?  
> > 
> > If the fix is not pretty obvious, then I guess revert. We actually
> > do have a bit of a regression though, since we've started marking
> > system reset interrupts as NMI. Previously a system reset would have
> > a better chance of printing something there.
> > 
> > So I wonder is an ifdef really all that much worse just because it's not
> > in the same exact place as the others? We do get bug reports that were
> > triggered by a system reset from hypervisor console. Hopefully they would
> > be running with crash dumps usually.  
> 
> I don't think an ifdef there is really correct though.  Sounds like we
> might instead need to move some console flushes before calling of all
> the notifiers, so that things like platforms/pseries or pvpanic can
> insert non-returning notifiers.

Well, I don't necessarily think that's the right thing to do either.
If we have a crash dump handler, we should get the console memory
and rather do that immediately than try to flush it, no?

I think a helper function that would do all the necessary generic
panic flushing might be better, than handlers can decide for
themselves.

But a pseries rtas hcall at the end of panic should be okay for a
backport, no? Revert would be easy, but if distros and things pick it
up then we might get a bunch of bugs without console data then
just have to backport something anway. That's my worry.

Thanks,
Nick

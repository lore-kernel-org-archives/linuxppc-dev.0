Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypBRx1WptzDrvM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 22:11:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
In-Reply-To: <20171130051126.GE3023@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
 <20171130051126.GE3023@umbus.fritz.box>
Date: Fri, 01 Dec 2017 22:11:50 +1100
Message-ID: <87mv32bt3d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote:
>> On Wed, 29 Nov 2017 15:06:52 +1100
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>> 
>> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
>> > purports to fix a problem when the kernel panics with fadump not
>> > registered, but it breaks something else instead.  I _think_ it was
>> > working on the incorrect assumption that ppc_md.panic was (or should
>> > be) only used with fadump, but I'm not really sure.
>> > 
>> > Panic works with kdump enabled, and (I think) with fadump enabled).
>> > However, with neither of these enabled, we always go to the generic
>> > panic logic.
>> 
>> Yeah thanks, I can't remember what assumption I was working on tbh.
>>  
>> > That's incorrect for PAPR guests - they should call ibm,os-term via
>> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
>> > which higher-level management pays attention to.  Since a3b2cb30 we
>> > now reboot instead of reporting that.
>> > 
>> > I believe it will also break panic for PS3 machines, but since that
>> > platform basically no longer exists, we probably don't care.
>> 
>> I (hope) it should just go down to the normal panic path and not do
>> much worse than it already does -- although it won't print out that
>> message.
>> 
>> > I'm not entirely sure how to fix this.  I _think_ what we want is to
>> > call ppc_md.panic from a late panic notifier, the way this patch does
>> > for fadump_panic_event() if fadump is registered.
>> 
>> The problem I had there is that some of the printk and console stuff
>> wasn't getting flushed out, so I was getting a blank screen. This was
>> probably in conjunction with panicing from NMI context that we're now
>> starting to introduce.
>> 
>> So it's a bit annoying. There's other ugliness we have for being unable
>> to control panic code well enough from arch code
>> (arch/powerpc/platforms/powernv/opal.c)
>> 
>> I guess a really minimal fix is to put an #ifdef powerpc down the bottom
>> there (/me *cries*).
>
> Um.. right.  I'm not really sure from that how to go forward from
> here.  We want to fix this for RHEL7.5, which doesn't give us a lot of
> time.
>
> Adding the #ifdef at the bottom of the generic panic code is gross,
> but there's already a bunch of that, so maybe adequate until a better
> solution can be found?

I think you mean put an #ifdef at the bottom of panic(). If so that
won't work. Our default panic_timeout is 180 so we never get to the
bottom of panic(), we call emergency_restart().

You *could* put an #ifdef powerpc before that, but that's even more
gross because it's in a different place to the sparc/s390 #ifdefs.

I notice we don't implement machine_emergency_restart(), it just
becomes machine_restart(NULL).

So it seems like that's the place we should be hooking,
machine_emergency_restart(). That's what x86 does.

But panic() is not the only caller of emergency_restart(), so it's not
an entirely straight forward conversion.

So I think for 4.15 and 4.14 I'm inclined to revert. Then we can do a
bigger rework for 4.16.

Nick that shouldn't break your original aim too badly I think? ie. worst
case is we panic() but don't see the output if we came from NMI?

cheers

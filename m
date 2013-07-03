Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 359E72C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:22:24 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372871854.8183.132@snotra>
Date: Wed, 3 Jul 2013 19:22:18 +0200
Message-Id: <494FB7B1-F2B5-43C5-8EA9-60CFAB4B07BE@suse.de>
References: <1372871854.8183.132@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 19:17, Scott Wood wrote:

> On 07/03/2013 11:59:45 AM, Alexander Graf wrote:
>> On 03.07.2013, at 17:41, Caraman Mihai Claudiu-B02008 wrote:
>> >>>>> Increase FPU laziness by calling kvmppc_load_guest_fp() just =
before
>> >>>>> returning to guest instead of each sched in. Without this =
improvement
>> >>>>> an interrupt may also claim floting point corrupting guest =
state.
>> >>>>
>> >>>> Not sure I follow. Could you please describe exactly what's =
happening?
>> >>>
>> >>> This was already discussed on the list, I will forward you the =
thread.
>> >>
>> >> The only thing I've seen in that thread was some pathetic =
theoretical
>> >> case where an interrupt handler would enable fp and clobber state
>> >> carelessly. That's not something I'm worried about.
>> >
>> > Neither me though I don't find it pathetic. Please refer it to =
Scott.
>> If from Linux's point of view we look like a user space program with =
active floating point registers, we don't have to worry about this case. =
Kernel code that would clobber that fp state would clobber random user =
space's fp state too.
>=20
> This patch makes it closer to how it works with a user space program.  =
Or rather, it reduces the time window when we don't (and can't) act like =
a normal userspace program -- and ensures that we have interrupts =
disabled during that window.  An interrupt can't randomly clobber FP =
state; it has to call enable_kernel_fp() just like KVM does.  =
enable_kernel_fp() clears the userspace MSR_FP to ensure that the state =
it saves gets restored before userspace uses it again, but that won't =
have any effect on guest execution (especially in HV-mode).  Thus =
kvmppc_load_guest_fp() needs to be atomic with guest entry.  =
Conceptually it's like taking an automatic FP unavailable trap when we =
enter the guest, since we can't be lazy in HV-mode.

Yep. Once I understood that point things became clear to me :).

>=20
>> >> I really don't see where this patch improves anything tbh. It =
certainly
>> >> makes the code flow more awkward.
>> >
>> > I was pointing you to this: The idea of FPU/AltiVec laziness that =
the kernel
>> > is struggling to achieve is to reduce the number of store/restore =
operations.
>> > Without this improvement we restore the unit each time we are sched =
it. If an
>> > other process take the ownership of the unit (on SMP it's even =
worse but don't
>> > bother with this) the kernel store the unit state to qemu task. =
This can happen
>> > multiple times during handle_exit().
>> >
>> > Do you see it now?
>> Yup. Looks good. The code flow is very hard to follow though - there =
are a lot of implicit assumptions that don't get documented anywhere. =
For example the fact that we rely on giveup_fpu() to remove MSR_FP from =
our thread.
>=20
> That's not new to this patch...

Would be nice to fix nevertheless. I'm probably not going to be the last =
person forgetting how this works.


Alex

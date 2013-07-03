Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FB322C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:17:44 +1000 (EST)
Date: Wed, 3 Jul 2013 12:17:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <23C56B31-5145-481E-9877-F1878F66959D@suse.de> (from
 agraf@suse.de on Wed Jul  3 11:59:45 2013)
Message-ID: <1372871854.8183.132@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 07/03/2013 11:59:45 AM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 17:41, Caraman Mihai Claudiu-B02008 wrote:
>=20
> >>>>> Increase FPU laziness by calling kvmppc_load_guest_fp() just =20
> before
> >>>>> returning to guest instead of each sched in. Without this =20
> improvement
> >>>>> an interrupt may also claim floting point corrupting guest =20
> state.
> >>>>
> >>>> Not sure I follow. Could you please describe exactly what's =20
> happening?
> >>>
> >>> This was already discussed on the list, I will forward you the =20
> thread.
> >>
> >> The only thing I've seen in that thread was some pathetic =20
> theoretical
> >> case where an interrupt handler would enable fp and clobber state
> >> carelessly. That's not something I'm worried about.
> >
> > Neither me though I don't find it pathetic. Please refer it to =20
> Scott.
>=20
> If from Linux's point of view we look like a user space program with =20
> active floating point registers, we don't have to worry about this =20
> case. Kernel code that would clobber that fp state would clobber =20
> random user space's fp state too.

This patch makes it closer to how it works with a user space program.  =20
Or rather, it reduces the time window when we don't (and can't) act =20
like a normal userspace program -- and ensures that we have interrupts =20
disabled during that window.  An interrupt can't randomly clobber FP =20
state; it has to call enable_kernel_fp() just like KVM does.  =20
enable_kernel_fp() clears the userspace MSR_FP to ensure that the state =20
it saves gets restored before userspace uses it again, but that won't =20
have any effect on guest execution (especially in HV-mode).  Thus =20
kvmppc_load_guest_fp() needs to be atomic with guest entry.  =20
Conceptually it's like taking an automatic FP unavailable trap when we =20
enter the guest, since we can't be lazy in HV-mode.

> >> I really don't see where this patch improves anything tbh. It =20
> certainly
> >> makes the code flow more awkward.
> >
> > I was pointing you to this: The idea of FPU/AltiVec laziness that =20
> the kernel
> > is struggling to achieve is to reduce the number of store/restore =20
> operations.
> > Without this improvement we restore the unit each time we are sched =20
> it. If an
> > other process take the ownership of the unit (on SMP it's even =20
> worse but don't
> > bother with this) the kernel store the unit state to qemu task. =20
> This can happen
> > multiple times during handle_exit().
> >
> > Do you see it now?
>=20
> Yup. Looks good. The code flow is very hard to follow though - there =20
> are a lot of implicit assumptions that don't get documented anywhere. =20
> For example the fact that we rely on giveup_fpu() to remove MSR_FP =20
> from our thread.

That's not new to this patch...

-Scott=

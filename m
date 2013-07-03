Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14E6E2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 02:49:22 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Date: Wed, 3 Jul 2013 16:49:13 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3E93@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3D41@039-SN2MPN1-013.039d.mgd.msft.net>
 <FA08EF79-D31B-4998-B7FE-BB2BFE3FB65E@suse.de>
In-Reply-To: <FA08EF79-D31B-4998-B7FE-BB2BFE3FB65E@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

> >>> +
> >>> 	if (!vcpu->arch.sane) {
> >>> 		kvm_run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
> >>> 		return -EINVAL;
> >>> @@ -716,6 +750,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
> >> struct kvm_vcpu *vcpu)
> >>> 	kvmppc_load_guest_fp(vcpu);
> >>> #endif
> >>>
> >>> +#ifdef CONFIG_ALTIVEC
> >>
> >> /* Switch from user space Altivec to guest Altivec state */
> >>
> >>> +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> >>
> >> Why not use your kvmppc_supports_altivec() helper here?
> >
> > Give it a try ... because Linus guarded this members with
> CONFIG_ALTIVEC :)
>=20
> Huh? You already are in an #ifdef CONFIG_ALTIVEC here. I think it's a
> good idea to be consistent in helper usage. And the name you gave to the
> helper (kvmppc_supports_altivec) is actually quite nice and tells us
> exactly what we're asking for.

I thought you asking to replace #ifdef CONFIG_ALTIVEC.

> >> Do we need to do this even when the guest doesn't use Altivec? Can't
> we
> >> just load it on demand then once we fault? This code path really
> should
> >> only be a prefetch enable when MSR_VEC is already set in guest
> context.
> >
> > No we can't, read 6/6.
>=20
> So we have to make sure we're completely unlazy when it comes to a KVM
> guest. Are we?

Yes, because MSR[SPV] is under its control.

-Mike

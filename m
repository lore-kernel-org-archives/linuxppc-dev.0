Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F8F32C0315
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 14:38:01 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Michael Neuling <mikey@neuling.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: BOOKE KVM calling load_up_fpu from C?
Date: Tue, 12 Feb 2013 03:37:54 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EC4A@039-SN2MPN1-023.039d.mgd.msft.net>
References: <14306.1360639760@ale.ozlabs.ibm.com>
In-Reply-To: <14306.1360639760@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Mic=
hael
> Neuling
> Sent: Tuesday, February 12, 2013 8:59 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: BOOKE KVM calling load_up_fpu from C?
>=20
> Scott,
>=20
> I was looking at changing how load_up_fpu works and I found this in
> arch/powerpc/kvm/booke.h:
>=20
> static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu) { #ifdef
> CONFIG_PPC_FPU
> 	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
> 		load_up_fpu();
> 		current->thread.regs->msr |=3D MSR_FP;
> 	}
> #endif
> }
>=20
> I'm wondering how this is suppose to work since load_up_fpu is suppose to=
 have
> MSR in R12?

Is not the load_up_fpu() does mfmsr:

_GLOBAL(load_up_fpu)
        mfmsr   r5
        ori     r5,r5,MSR_FP
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
        oris    r5,r5,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
        SYNC
        MTMSRD(r5)                      /* enable use of fpu now */
        isync
<snip>

-Bharat

>=20
> Mikey
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

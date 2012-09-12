Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88CBB2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 04:56:14 +1000 (EST)
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
Date: Wed, 12 Sep 2012 20:56:08 +0200
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12.09.2012, at 15:18, Mihai Caraman <mihai.caraman@freescale.com> wrote:

> The current form of DO_KVM macro restricts its use to one call per input
> parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
> definition.
> Duplicate calls of DO_KVM are required by distinct implementations of
> exeption handlers which are delegated at runtime.

Not sure I understand what you're trying to achieve here. Please elaborate ;=
)

Alex

> Use a rare label number
> to avoid conflicts with the calling contexts.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_booke_hv_asm.h |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/in=
clude/asm/kvm_booke_hv_asm.h
> index 30a600f..a37a12a 100644
> --- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> +++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> @@ -38,9 +38,9 @@
> #ifdef CONFIG_KVM_BOOKE_HV
> BEGIN_FTR_SECTION
>    mtocrf    0x80, r11    /* check MSR[GS] without clobbering reg */
> -    bf    3, kvmppc_resume_\intno\()_\srr1
> +    bf    3, 1975f
>    b    kvmppc_handler_\intno\()_\srr1
> -kvmppc_resume_\intno\()_\srr1:
> +1975:
> END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
> #endif
> .endm
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

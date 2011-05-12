Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 1AD29B6F73
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 19:33:16 +1000 (EST)
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511103950.GD2837@brick.ozlabs.ibm.com>
In-Reply-To: <20110511103950.GD2837@brick.ozlabs.ibm.com>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <C5B8A119-56B6-467C-B3BD-01D5D7FA0773@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 03/13] kvm/powerpc: Fix the build for 32-bit Book 3S
	(classic) processors
Date: Thu, 12 May 2011 11:33:00 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 11.05.2011 um 12:39 schrieb Paul Mackerras <paulus@samba.org>:

> Commits a5d4f3ad3a ("powerpc: Base support for exceptions using
> HSRR0/1") and 673b189a2e ("powerpc: Always use SPRN_SPRG_HSCRATCH0
> when running in HV mode") cause compile and link errors for 32-bit
> classic Book 3S processors when KVM is enabled.  This fixes these
> errors.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/reg.h       |    5 +++++
> arch/powerpc/kvm/book3s_rmhandlers.S |    2 ++
> 2 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg=
.h
> index 47e3416..05658b7 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -823,6 +823,11 @@
>    FTR_SECTION_ELSE_NESTED(66);            \
>    mtspr    SPRN_SPRG_HSCRATCH0,rX;            \
>    ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
> +
> +#else /* CONFIG_PPC_BOOK3S_64 */
> +#define GET_SCRATCH0(rX)    mfspr    rX,SPRN_SPRG_SCRATCH0
> +#define SET_SCRATCH0(rX)    mtspr    SPRN_SPRG_SCRATCH0,rX
> +
> #endif
>=20
> #ifdef CONFIG_PPC_BOOK3E_64
> diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3=
s_rmhandlers.S
> index ae99af6..1a1b344 100644
> --- a/arch/powerpc/kvm/book3s_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
> @@ -112,7 +112,9 @@ INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_MACHINE_CHECK=

> INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_DATA_STORAGE
> INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_INST_STORAGE
> INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL
> +#ifdef CONFIG_PPC_BOOK3S_64
> INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL_HV

Hrm - I don't remember putting this one here. When did it get into the tree a=
nd why wasn't I CC'ed?

Alex

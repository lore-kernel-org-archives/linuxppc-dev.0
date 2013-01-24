Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D1652C00B4
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 04:43:14 +1100 (EST)
Subject: Re: [PATCH][v2] KVM: PPC: add paravirt idle loop for 64-bit book E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
Date: Thu, 24 Jan 2013 18:42:59 +0100
Message-Id: <05107669-AF12-43FA-9960-E7249E8B8C4E@suse.de>
References: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.01.2013, at 00:54, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

Ben, this one is in generic powerpc code, so I'd say it's for you :).


Alex

> ---
>=20
> -v2
>   -macro'ized loop in idle_book3e.S to avoid code=20
>    duplication, paravirt loop is now in idle_book3e.S
>=20
> arch/powerpc/kernel/epapr_hcalls.S |    2 ++
> arch/powerpc/kernel/idle_book3e.S  |   30 =
++++++++++++++++++++++++++++--
> 2 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/epapr_hcalls.S =
b/arch/powerpc/kernel/epapr_hcalls.S
> index 62c0dc2..9f1ebf7 100644
> --- a/arch/powerpc/kernel/epapr_hcalls.S
> +++ b/arch/powerpc/kernel/epapr_hcalls.S
> @@ -17,6 +17,7 @@
> #include <asm/asm-compat.h>
> #include <asm/asm-offsets.h>
>=20
> +#ifndef CONFIG_PPC64
> /* epapr_ev_idle() was derived from e500_idle() */
> _GLOBAL(epapr_ev_idle)
> 	CURRENT_THREAD_INFO(r3, r1)
> @@ -42,6 +43,7 @@ epapr_ev_idle_start:
> 	 * _TLF_NAPPING.
> 	 */
> 	b	idle_loop
> +#endif
>=20
> /* Hypercall entry point. Will be patched with device tree =
instructions. */
> .global epapr_hypercall_start
> diff --git a/arch/powerpc/kernel/idle_book3e.S =
b/arch/powerpc/kernel/idle_book3e.S
> index 4c7cb400..e1c9acd 100644
> --- a/arch/powerpc/kernel/idle_book3e.S
> +++ b/arch/powerpc/kernel/idle_book3e.S
> @@ -16,11 +16,13 @@
> #include <asm/ppc-opcode.h>
> #include <asm/processor.h>
> #include <asm/thread_info.h>
> +#include <asm/epapr_hcalls.h>
>=20
> /* 64-bit version only for now */
> #ifdef CONFIG_PPC64
>=20
> -_GLOBAL(book3e_idle)
> +.macro BOOK3E_IDLE name loop
> +_GLOBAL(\name)
> 	/* Save LR for later */
> 	mflr	r0
> 	std	r0,16(r1)
> @@ -67,7 +69,31 @@ _GLOBAL(book3e_idle)
>=20
> 	/* We can now re-enable hard interrupts and go to sleep */
> 	wrteei	1
> -1:	PPC_WAIT(0)
> +	\loop
> +
> +.endm
> +
> +.macro BOOK3E_IDLE_LOOP
> +1:
> +	PPC_WAIT(0)
> 	b	1b
> +.endm
> +
> +.macro EPAPR_EV_IDLE_LOOP
> +idle_loop:
> +       LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
> +
> +.global epapr_ev_idle_start
> +epapr_ev_idle_start:
> +       li      r3, -1
> +       nop
> +       nop
> +       nop
> +       b       idle_loop
> +.endm
> +
> +BOOK3E_IDLE epapr_ev_idle, EPAPR_EV_IDLE_LOOP
> +
> +BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP
>=20
> #endif /* CONFIG_PPC64 */
> --=20
> 1.7.9.7
>=20
>=20

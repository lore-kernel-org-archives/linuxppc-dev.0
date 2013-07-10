Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F8382C029D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 15:18:18 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [v3][PATCH 1/8] powerpc/book3e: rename interrupt_end_book3e
 with __end_interrupts
Date: Wed, 10 Jul 2013 05:17:20 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070AE11F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1373357007-30785-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Tie=
jun Chen
> Sent: Tuesday, July 09, 2013 1:33 PM
> To: benh@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: [v3][PATCH 1/8] powerpc/book3e: rename interrupt_end_book3e with
> __end_interrupts
>=20
> We can rename 'interrupt_end_book3e' with '__end_interrupts' then book3s/=
book3e
> can share this unique label to make sure we can use this conveniently.

I think we can be consistent with start and end names, no?

-Bharat

>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S
> b/arch/powerpc/kernel/exceptions-64e.S
> index 645170a..a518e48 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -309,8 +309,8 @@ interrupt_base_book3e:					/* fake
> trap */
>  	EXCEPTION_STUB(0x300, hypercall)
>  	EXCEPTION_STUB(0x320, ehpriv)
>=20
> -	.globl interrupt_end_book3e
> -interrupt_end_book3e:
> +	.globl __end_interrupts
> +__end_interrupts:
>=20
>  /* Critical Input Interrupt */
>  	START_EXCEPTION(critical_input);
> @@ -493,7 +493,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  	beq+	1f
>=20
>  	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
> -	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
> +	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
>  	cmpld	cr0,r10,r14
>  	cmpld	cr1,r10,r15
>  	blt+	cr0,1f
> @@ -559,7 +559,7 @@ kernel_dbg_exc:
>  	beq+	1f
>=20
>  	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
> -	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
> +	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
>  	cmpld	cr0,r10,r14
>  	cmpld	cr1,r10,r15
>  	blt+	cr0,1f
> --
> 1.7.9.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

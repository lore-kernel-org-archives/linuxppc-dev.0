Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id AFCB11A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 05:30:27 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 09/11] powerpc/8xx: dont save CR in SCRATCH registers
Date: Mon, 5 Jan 2015 18:30:24 +0000
Message-ID: <1420482624.25047.25.camel@transmode.se>
References: <20141216150340.108641A5E05@localhost.localdomain>
In-Reply-To: <20141216150340.108641A5E05@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 2014-12-16 at 16:03 +0100, Christophe Leroy wrote:
> CR only needs to be preserved when checking if we are handling a kernel a=
ddress.
> So we can preserve CR in a register:
> - In ITLBMiss, check is done only when CONFIG_MODULES is defined. Otherwi=
se we
> don't need to do anything at all with CR.
> - If CONFIG_8xx_CPU6 is defined, we have r3 available for saving CR
> - Otherwise, we use r10, then we reload SRR0/MD_EPN into r10 when CR is r=
estored

I think the #ifdef CPU6 code makes for too much maintenance. Can you
loose the #ifdef CPU6 and adjust code so it works for both cases?

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> ---
>  arch/powerpc/kernel/head_8xx.S | 53 +++++++++++++++++++++++++++++-------=
------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index c89aed9..a073918 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -308,14 +308,10 @@ SystemCall:
>  #endif
> =20
>  InstructionTLBMiss:
> +       EXCEPTION_PROLOG_0
>  #ifdef CONFIG_8xx_CPU6
>         mtspr   SPRN_DAR, r3
>  #endif
> -       EXCEPTION_PROLOG_0
> -       mfcr    r10
> -       mtspr   SPRN_SPRG_SCRATCH2, r10
> -       mfspr   r10, SPRN_SRR0/* Get effective address of fault */
> -       DO_8xx_CPU15(r11, r10)
> =20
>         /* If we are faulting a kernel address, we have to use the
>                 * kernel page tables.
> @@ -323,14 +319,33 @@ InstructionTLBMiss:
>  #ifdef CONFIG_MODULES
>         /* Only modules will cause ITLB Misses as we always
>                 * pin the first 8MB of kernel memory */
> +#ifdef CONFIG_8xx_CPU6
> +       mfspr   r10, SPRN_SRR0/* Get effective address of fault */
> +       DO_8xx_CPU15(r11, r10)
> +       mfcr    r3
>         andis.  r11, r10, 0x8000/* Address >=3D 0x80000000 */
> +#else
> +       mfspr   r11, SPRN_SRR0/* Get effective address of fault */
> +       DO_8xx_CPU15(r10, r11)
> +       mfcr    r10
> +       andis.  r11, r11, 0x8000/* Address >=3D 0x80000000 */
>  #endif
>         mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
> -#ifdef CONFIG_MODULES
>         beq     3f
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>  3:
> +#ifdef CONFIG_8xx_CPU6
> +       mtcr    r3
> +#else
> +       mtcr    r10
> +       mfspr   r10, SPRN_SRR0/* Get effective address of fault */
>  #endif
> +#else /* CONFIG_MODULES */
> +       mfspr   r10, SPRN_SRR0/* Get effective address of fault */
> +       DO_8xx_CPU15(r11, r10)
> +       mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
> +#endif /* CONFIG_MODULES */
> +
>         /* Insert level 1 index */
>         rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
>         lwz     r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)/* Get the level =
1 entry */
> @@ -362,29 +377,37 @@ InstructionTLBMiss:
>         mfspr   r3, SPRN_DAR
>         mtspr   SPRN_DAR, r11/* Tag DAR */
>  #endif
> -       mfspr   r10, SPRN_SPRG_SCRATCH2
> -       mtcr    r10
>         EXCEPTION_EPILOG_0
>         rfi
> =20
>         . =3D 0x1200
>  DataStoreTLBMiss:
> -#ifdef CONFIG_8xx_CPU6
> -       mtspr   SPRN_DAR, r3
> -#endif
>         EXCEPTION_PROLOG_0
> -       mfcr    r10
> -       mtspr   SPRN_SPRG_SCRATCH2, r10
> -       mfspr   r10, SPRN_MD_EPN
> =20
>         /* If we are faulting a kernel address, we have to use the
>                 * kernel page tables.
>                 */
> +#ifdef CONFIG_8xx_CPU6
> +       mtspr   SPRN_DAR, r3
> +       mfcr    r3
> +       mfspr   r10, SPRN_MD_EPN
>         andis.  r11, r10, 0x8000
> +#else
> +       mfcr    r10
> +       mfspr   r11, SPRN_MD_EPN
> +       andis.  r11, r11, 0x8000
> +#endif
>         mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
>         beq     3f
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>  3:
> +#ifdef CONFIG_8xx_CPU6
> +       mtcr    r3
> +#else
> +       mtcr    r10
> +       mfspr   r10, SPRN_MD_EPN
> +#endif
> +
>         /* Insert level 1 index */
>         rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
>         lwz     r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)/* Get the level =
1 entry */
> @@ -441,8 +464,6 @@ DataStoreTLBMiss:
>         mfspr   r3, SPRN_DAR
>  #endif
>         mtspr   SPRN_DAR, r11/* Tag DAR */
> -       mfspr   r10, SPRN_SPRG_SCRATCH2
> -       mtcr    r10
>         EXCEPTION_EPILOG_0
>         rfi
>  =

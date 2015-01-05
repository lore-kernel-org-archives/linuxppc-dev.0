Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 57A3F1A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 05:21:54 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 11/11] powerpc/8xx: Add support for TASK_SIZE greater than
 0x80000000
Date: Mon, 5 Jan 2015 18:21:51 +0000
Message-ID: <1420482111.25047.22.camel@transmode.se>
References: <20141216150340.55A031A5E07@localhost.localdomain>
In-Reply-To: <20141216150340.55A031A5E07@localhost.localdomain>
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
> By default, TASK_SIZE is set to 0x80000000 for PPC_8xx, which is most lik=
ely
> sufficient for most cases. However, kernel configuration allows to set TA=
SK_SIZE
> to another value, so the 8xx shall handle it.

On 8xx I would be just as happy with not supporting different TASK_SIZEs, b=
ut why not ..
Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> ---
>  arch/powerpc/kernel/head_8xx.S | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index dbe110e..d380658 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -48,6 +48,19 @@
>         mtspr   spr, reg
>  #endif
> =20
> +/* Macro to test if an address is a kernel address */
> +#if CONFIG_TASK_SIZE <=3D 0x80000000
> +#define IS_KERNEL(tmp, addr)           \
> +       andis.  tmp, addr, 0x8000/* Address >=3D 0x80000000 */
> +#define BRANCH_UNLESS_KERNEL(label)    beq     label
> +#else
> +#define IS_KERNEL(tmp, addr)           \
> +       rlwinm  tmp, addr, 16, 16, 31;\
> +       cmpli   cr0, tmp, PAGE_OFFSET >> 16
> +#define BRANCH_UNLESS_KERNEL(label)    blt     label
> +#endif
> +
> +
>  /*
>   * Value for the bits that have fixed value in RPN entries.
>   * Also used for tagging DAR for DTLBerror.
> @@ -323,15 +336,15 @@ InstructionTLBMiss:
>         mfspr   r10, SPRN_SRR0/* Get effective address of fault */
>         DO_8xx_CPU15(r11, r10)
>         mfcr    r3
> -       andis.  r11, r10, 0x8000/* Address >=3D 0x80000000 */
> +       IS_KERNEL(r11, r10)
>  #else
>         mfspr   r11, SPRN_SRR0/* Get effective address of fault */
>         DO_8xx_CPU15(r10, r11)
>         mfcr    r10
> -       andis.  r11, r11, 0x8000/* Address >=3D 0x80000000 */
> +       IS_KERNEL(r11, r11)
>  #endif
>         mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
> -       beq     3f
> +       BRANCH_UNLESS_KERNEL(3f)
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>  3:
>  #ifdef CONFIG_8xx_CPU6
> @@ -390,14 +403,14 @@ DataStoreTLBMiss:
>         mtspr   SPRN_SPRG_SCRATCH2, r3
>         mfcr    r3
>         mfspr   r10, SPRN_MD_EPN
> -       andis.  r11, r10, 0x8000
> +       IS_KERNEL(r11, r10)
>  #else
>         mfcr    r10
>         mfspr   r11, SPRN_MD_EPN
> -       andis.  r11, r11, 0x8000
> +       IS_KERNEL(r11, r11)
>  #endif
>         mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
> -       beq     3f
> +       BRANCH_UNLESS_KERNEL(3f)
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>  3:
>  #ifdef CONFIG_8xx_CPU6
> @@ -536,9 +549,9 @@ FixupDAR:/* Entry point for dcbx workaround. */
>         mtspr   SPRN_SPRG_SCRATCH2, r10
>         /* fetch instruction from memory. */
>         mfspr   r10, SPRN_SRR0
> -       andis.  r11, r10, 0x8000/* Address >=3D 0x80000000 */
> +       IS_KERNEL(r11, r10)
>         mfspr   r11, SPRN_M_TW/* Get level 1 table base address */
> -       beq     3f
> +       BRANCH_UNLESS_KERNEL(3f)
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@ha
>         /* Insert level 1 index */
>  3:     rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29=

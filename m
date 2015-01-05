Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 24FAD1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 05:19:16 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 04/11] powerpc/8xx: Take benefit of aligned PGDIR
Date: Mon, 5 Jan 2015 18:19:13 +0000
Message-ID: <1420481953.25047.19.camel@transmode.se>
References: <20141216150338.978F71A5E04@localhost.localdomain>
In-Reply-To: <20141216150338.978F71A5E04@localhost.localdomain>
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
> L1 base address is now aligned so we can insert L1 index into r11 directl=
y and
> then preserve r10
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>

>=20
> ---
>  arch/powerpc/kernel/head_8xx.S | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index 2c329f1..ae05f28 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -326,16 +326,15 @@ InstructionTLBMiss:
>         ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
>  3:
>  #endif
> -       /* Extract level 1 index */
> -       rlwinm  r10, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> -       lwzx    r11, r10, r11/* Get the level 1 entry */
> -       rlwinm  r10, r11,0,0,19/* Extract page descriptor page address */
> +       /* Insert level 1 index */
> +       rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> +       lwz     r11, 0(r11)/* Get the level 1 entry */
> =20
>         /* Load the MI_TWC with the attributes for this "segment." */
>         MTSPR_CPU6(SPRN_MI_TWC, r11, r3)/* Set segment attributes */
> -       mfspr   r11, SPRN_SRR0/* Get effective address of fault */
> +       rlwinm  r11, r11,0,0,19/* Extract page descriptor page address */
>         /* Extract level 2 index */
> -       rlwinm  r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
> +       rlwinm  r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
>         lwzx    r10, r10, r11/* Get the pte */
> =20
>  #ifdef CONFIG_SWAP
> @@ -380,13 +379,12 @@ DataStoreTLBMiss:
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@h
>         ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
>  3:
> -       /* Extract level 1 index */
> -       rlwinm  r10, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> -       lwzx    r11, r10, r11/* Get the level 1 entry */
> +       /* Insert level 1 index */
> +       rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> +       lwz     r11, 0(r11)/* Get the level 1 entry */
> =20
>         /* We have a pte table, so load fetch the pte from the table.
>                 */
> -       mfspr   r10, SPRN_MD_EPN/* Get address of fault */
>         /* Extract level 2 index */
>         rlwinm  r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
>         rlwimi  r10, r11, 0, 0, 32 - PAGE_SHIFT - 1/* Add level 2 base */
> @@ -515,16 +513,14 @@ FixupDAR:/* Entry point for dcbx workaround. */
>         beq-    3f      /* Branch if user space */
>         lis     r11, (swapper_pg_dir-PAGE_OFFSET)@h
>         ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
> -       /* Extract level 1 index */
> -3:     rlwinm  r10, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> -       lwzx    r11, r10, r11/* Get the level 1 entry */
> -       rlwinm  r10, r11,0,0,19/* Extract page descriptor page address */
> -       mfspr   r11, SPRN_SRR0/* Get effective address of fault */
> -       /* Extract level 2 index */
> -       rlwinm  r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
> -       lwzx    r11, r10, r11/* Get the pte */
> +       /* Insert level 1 index */
> +3:     rlwimi  r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) =
<< 1, 29
> +       lwz     r11, 0(r11)/* Get the level 1 entry */
> +       rlwinm  r11, r11,0,0,19/* Extract page descriptor page address */
> +       /* Insert level 2 index */
> +       rlwimi  r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
> +       lwz     r11, 0(r11)/* Get the pte */
>         /* concat physical page address(r11) and page offset(r10) */
> -       mfspr   r10, SPRN_SRR0
>         rlwimi  r11, r10, 0, 32 - PAGE_SHIFT, 31
>         lwz     r11,0(r11)
>  /* Check if it really is a dcbx instruction. */=

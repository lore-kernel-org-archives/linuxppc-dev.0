Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id DE6FBB70A7
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 17:03:20 +1000 (EST)
Received: by ywi6 with SMTP id 6so1199650ywi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 00:03:19 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279893639-24333-2-git-send-email-agust@denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Jul 2010 01:02:59 -0600
Message-ID: <AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
	descriptor
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 23, 2010 at 8:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On MPC5121e Rev 2.0 re-configuring the DIU area descriptor
> by writing new descriptor address doesn't always work.
> As a result, DIU continues to display using old area descriptor
> even if the new one has been written to the descriptor register of
> the plane.
>
> Add the code from Freescale MPC5121EADS BSP for writing descriptor
> addresses properly. This fixes the problem for Rev 2.0 silicon.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> v4:
> =A0- use workaround code as suggested by FSL technical support.
>
> v3:
> =A0- no changes since v1
>
> =A0drivers/video/fsl-diu-fb.c | =A0 38 +++++++++++++++++++++++-----------=
----
> =A01 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 27455ce..9b8c991 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -317,6 +317,17 @@ static void fsl_diu_free(void *virt, size_t size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_pages_exact(virt, size);
> =A0}
>
> +/*
> + * Workaround for failed writing desc register of planes.
> + * Needed with MPC5121 DIU rev 2.0 silicon.
> + */
> +void wr_reg_wa(u32 *reg, u32 val)
> +{
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(reg, val);
> + =A0 =A0 =A0 } while (in_be32(reg) !=3D val);
> +}

I'll apply this one, but it looks like a potential problem.  What
happens if the write never succeeds?  The kernel then gets stuck in a
forever busy loop.  You should look at reworking it.

g.

> +
> =A0static int fsl_diu_enable_panel(struct fb_info *info)
> =A0{
> =A0 =A0 =A0 =A0struct mfb_info *pmfbi, *cmfbi, *mfbi =3D info->par;
> @@ -330,7 +341,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (mfbi->index) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hw->desc[0] !=3D ad->p=
addr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&h=
w->desc[0], ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&=
hw->desc[0], ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 1: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 1 AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmfbi =3D machine_data->fs=
l_diu_info[2]->par;
> @@ -340,7 +351,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0cpu_to_le32(cmfbi->ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0ad->next_ad =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&h=
w->desc[1], ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&=
hw->desc[1], ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 3: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 2 AOI 0 */
> @@ -351,14 +362,14 @@ static int fsl_diu_enable_panel(struct fb_info *inf=
o)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0cpu_to_le32(cmfbi->ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0ad->next_ad =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&h=
w->desc[2], ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&=
hw->desc[2], ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 1 AOI 1 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi =3D machine_data->fs=
l_diu_info[1]->par;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ad->next_ad =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hw->desc[1] =3D=3D mac=
hine_data->dummy_ad->paddr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&h=
w->desc[1], ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&=
hw->desc[1], ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* AOI0 open */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi->ad-=
>next_ad =3D cpu_to_le32(ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -366,7 +377,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi =3D machine_data->fs=
l_diu_info[3]->par;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ad->next_ad =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hw->desc[2] =3D=3D mac=
hine_data->dummy_ad->paddr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&h=
w->desc[2], ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&=
hw->desc[2], ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* AOI0 was open */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi->ad-=
>next_ad =3D cpu_to_le32(ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -390,27 +401,24 @@ static int fsl_diu_disable_panel(struct fb_info *in=
fo)
> =A0 =A0 =A0 =A0switch (mfbi->index) {
> =A0 =A0 =A0 =A0case 0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hw->desc[0] !=3D machine_data->dummy_a=
d->paddr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[0],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_dat=
a->dummy_ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[0], mac=
hine_data->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 1: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 1 AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmfbi =3D machine_data->fsl_diu_info[2]->p=
ar;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cmfbi->count > 0) =A0 /* AOI1 is open =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[1], cmfb=
i->ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[1], cmf=
bi->ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* move AOI1 to the first */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* AOI1 was closed */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[1],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_dat=
a->dummy_ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[1], mac=
hine_data->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* close AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 3: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 2 AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmfbi =3D machine_data->fsl_diu_info[4]->p=
ar;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cmfbi->count > 0) =A0 /* AOI1 is open =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[2], cmfb=
i->ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[2], cmf=
bi->ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* move AOI1 to the first */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* AOI1 was closed */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[2],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machine_dat=
a->dummy_ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[2], mac=
hine_data->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* close AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 1 AOI 1 */
> @@ -421,7 +429,7 @@ static int fsl_diu_disable_panel(struct fb_info *info=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* AOI0 is open, must be the first */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi->ad-=
>next_ad =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* AOI1 is the first in the chain */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[1], mach=
ine_data->dummy_ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[1], mac=
hine_data->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* close AOI 1 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 4: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 2 AOI 1 */
> @@ -432,7 +440,7 @@ static int fsl_diu_disable_panel(struct fb_info *info=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* AOI0 is=
 open, must be the first */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmfbi->ad-=
>next_ad =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else =A0 =A0 =A0 =A0 =A0/* AOI1 is the f=
irst in the chain */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&hw->desc[2], mach=
ine_data->dummy_ad->paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_reg_wa(&hw->desc[2], mac=
hine_data->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* close A=
OI 1 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

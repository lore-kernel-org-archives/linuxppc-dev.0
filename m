Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C83D2B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 06:17:45 +1000 (EST)
Date: Tue, 5 Jul 2011 15:15:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: [PATCH] mtd: eLBC NAND: remove bogus ECC read-back
Message-ID: <20110705151525.438e87dc@schlenkerla.am.freescale.net>
In-Reply-To: <1309895997-29969-1-git-send-email-mlcreech@gmail.com>
References: <CAPBSBxqRywJjCfk_iuDLxn1HbuqPjJRJS=SkRQ3-Ge7SinbSBg@mail.gmail.com>
	<1309895997-29969-1-git-send-email-mlcreech@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
	mhench@elutions.com, rick22@wi.rr.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Jul 2011 15:59:57 -0400
"Matthew L. Creech" <mlcreech@gmail.com> wrote:

> From: Mike Hench <mhench@elutions.com>
> 
> The eLBC NAND driver currently follows up each program/write operation with a
> read-back of the page, in order to [ostensibly] fill in ECC data for the
> caller. However, the page address used for this read is always -1, so the read
> will never work correctly.  Remove this useless (and potentially problematic)
> block of code.
> 
> Signed-off-by: Matthew L. Creech <mlcreech@gmail.com>
> ---
>  drivers/mtd/nand/fsl_elbc_nand.c |   17 -----------------
>  1 files changed, 0 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> index 0bb254c..050a2fc 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -455,23 +455,6 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  
>  		fsl_elbc_run_command(mtd);
>  
> -		/* Read back the page in order to fill in the ECC for the
> -		 * caller.  Is this really needed?
> -		 */
> -		if (full_page && elbc_fcm_ctrl->oob_poi) {
> -			out_be32(&lbc->fbcr, 3);
> -			set_addr(mtd, 6, page_addr, 1);
> -
> -			elbc_fcm_ctrl->read_bytes = mtd->writesize + 9;
> -
> -			fsl_elbc_do_read(chip, 1);
> -			fsl_elbc_run_command(mtd);
> -
> -			memcpy_fromio(elbc_fcm_ctrl->oob_poi + 6,
> -				&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index], 3);
> -			elbc_fcm_ctrl->index += 3;
> -		}
> -
>  		elbc_fcm_ctrl->oob_poi = NULL;
>  		return;
>  	}

All references to elbc_fcm_ctrl->oob_poi (not chip->oob_poi) can be removed
now.

-Scott

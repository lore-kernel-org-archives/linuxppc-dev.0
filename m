Return-Path: <dedekind1@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5511EB6F72
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 01:57:34 +1000 (EST)
Received: by gwb17 with SMTP id 17so3127698gwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2011 08:57:31 -0700 (PDT)
Subject: Re: [PATCH v2] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Mon, 15 Aug 2011 18:59:09 +0300
In-Reply-To: <1310446122-18050-1-git-send-email-b35362@freescale.com>
References: <1310446122-18050-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313423954.8691.17.camel@sauron>
Mime-Version: 1.0
Cc: scottwood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-12 at 12:48 +0800, b35362@freescale.com wrote:
> +	/*
> +	 * Hack for supporting the flash chip whose writesize is
> +	 * larger than 2K bytes.
> +	 */
> +	if (mtd->writesize > 2048) {
> +		elbc_fcm_ctrl->subpage_shift = ffs(mtd->writesize >> 11) - 1;
> +		elbc_fcm_ctrl->subpage_mask =
> +			(1 << elbc_fcm_ctrl->subpage_shift) - 1;
> +		/*
> +		 * Rewrite mtd->writesize, mtd->oobsize, chip->page_shift
> +		 * and chip->pagemask.
> +		 */
> +		mtd->writesize = 2048;
> +		mtd->oobsize = 64;
> +		chip->page_shift = ffs(mtd->writesize) - 1;
> +		chip->pagemask = (chip->chipsize >> chip->page_shift) - 1;
> +	}

So basically if the flash has 4KiB NAND pages, you are considering it as
a flash with 2KiB NAND pages. But surely this will work only if the
underlying flash has NOP 2 at least. Or even, if you consider that JFFS2
and YAFFS want to write to OOB, you need NOP 4 (2 ECC writes and 2
writes from YAFFS/JFFS2) ? So this won't work for NOP1 flashes? Isn't it
an ugly hack?

-- 
Best Regards,
Artem Bityutskiy

Return-Path: <dedekind1@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E004B1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 17:47:15 +1100 (EST)
Received: by lahe6 with SMTP id e6so1565889lah.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Dec 2011 22:47:09 -0800 (PST)
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: shuo.liu@freescale.com
Date: Mon, 05 Dec 2011 08:47:03 +0200
In-Reply-To: <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1323067628.2316.29.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 scottwood@freescale.com, akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-12-04 at 12:31 +0800, shuo.liu@freescale.com wrote:
> +		/*
> +		 * Freescale FCM controller has a 2K size limitation of buffer
> +		 * RAM, so elbc_fcm_ctrl->buffer have to be used if writesize
> +		 * of chip is greater than 2048.
> +		 * We malloc a large enough buffer (maximum page size is 16K).
> +		 */
> +		elbc_fcm_ctrl->buffer = kmalloc(1024 * 16 + 1024, GFP_KERNEL);
> +		if (!elbc_fcm_ctrl->buffer) {
> +			dev_err(dev, "failed to allocate memory\n");
> +			mutex_unlock(&fsl_elbc_nand_mutex);
> +			ret = -ENOMEM;
> +			goto err;
> +		}

Sorry for returning to this again and agian - I do not have time to dig
suggest you the right solutions on the one hand, you do not provide me a
good answer on the other hand (or I forgot?).

16KiB pages do not even exist I believe. And you kmalloc 33KiB or RAM
although in most cases you need only 5KiB. I think this is wrong - what
is the very strong reason of wasting RAM you have?

Why you cannot allocate exactly the required amount of RAM after
'nand_scan_ident()' finishes and you know the page size?

Artem.

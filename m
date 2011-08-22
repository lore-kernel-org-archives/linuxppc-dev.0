Return-Path: <dedekind1@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 427E7B6F00
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2011 20:51:26 +1000 (EST)
Received: by ywb3 with SMTP id 3so3504492ywb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2011 03:51:20 -0700 (PDT)
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Mon, 22 Aug 2011 13:53:08 +0300
In-Reply-To: <1313634783-8855-1-git-send-email-b35362@freescale.com>
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314010393.2644.110.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-08-18 at 10:33 +0800, b35362@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
> to support the Nand flash chip whose page size is larger than 2K bytes,
> we divide a page into multi-2K pages for MTD layer driver. In that case,
> we force to set the page size to 2K bytes. We convert the page address of
> MTD layer driver to a real page address in flash chips and a column index
> in fsl_elbc driver. We can issue any column address by UA instruction of
> elbc controller.
> 
> NOTE: Due to there is a limitation of 'Number of Partial Program Cycles in
> the Same Page (NOP)', the flash chip which is supported by this workaround 
> have to meet below conditions.
> 	1. page size is not greater than 4KB 
> 	2.	1) if main area and spare area have independent NOPs:
> 			  main  area NOP    :    >=3
> 			  spare area NOP    :    >=2
> 		2) if main area and spare area have a common NOP: 
> 			  NOP               :    >=4

Could you please also add this kind of info to the driver code comments?

Does it also make sense to print a message if you do the emulation,
like:

	pr_info("attention! emulating 2KiB NAND pages!");

-- 
Best Regards,
Artem Bityutskiy

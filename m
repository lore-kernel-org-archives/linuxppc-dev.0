Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EEECB6FA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 02:25:13 +1000 (EST)
Message-ID: <4E4D3CE0.7020602@freescale.com>
Date: Thu, 18 Aug 2011 11:25:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
In-Reply-To: <1313634783-8855-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/17/2011 09:33 PM, b35362@freescale.com wrote:
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
> 			  spare area NOP    :    >=2?

How often are the NOPs split like this?

> 		2) if main area and spare area have a common NOP: 
> 			  NOP               :    >=4

This depends on how the flash is used.  If you treat it as a NOP1 flash
(e.g. run ubifs rather than jffs2), then you need NOP2 for a 4K chip and
NOP4 for an 8K chip.  OTOH, if you would be making full use of NOP4 on a
real 2K chip, you'll need NOP8 for a 4K chip.

The NOP restrictions should be documented in the code itself, not just
in the git changelog.  Maybe print it to the console when this hack is
used, along with the NOP value read from the ID.  If it's less than 4
for 4K or 8 for 8K, also print a message saying not to use jffs2 (does
yaffs2 do similar things?).  If it's less than 2 for 4K or 4 for 8K, the
probe should fail.

-Scott

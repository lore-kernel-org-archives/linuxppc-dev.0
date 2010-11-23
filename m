Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB612B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 03:50:40 +1100 (EST)
Received: from mail34-db3 (localhost.localdomain [127.0.0.1])	by
	mail34-db3-R.bigfish.com (Postfix) with ESMTP id A44EC3C8430	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 23 Nov 2010 16:50:33 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.249])	by
	mail34-db3.bigfish.com (Postfix) with ESMTP id 684A41B4804F	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 23 Nov 2010 16:50:33 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oANGqCdc002162	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 23 Nov 2010 09:52:12 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oANH719m027969	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 11:07:02 -0600 (CST)
Date: Tue, 23 Nov 2010 10:50:27 -0600
From: Scott Wood <scottwood@freescale.com>
To: <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] Fixing the garbage collector problem after NAND-flash
	image record in u-boot
Message-ID: <20101123105027.13d0a80d@udp111988uds.am.freescale.net>
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A106A0AA938@HERMES2>
References: <4206182445660643B9AEB8D4E55BBD0A106A0AA938@HERMES2>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 23 Nov 2010 16:10:54 +0100
<Sergej.Stepanov@ids.de> wrote:

> This patch should fix the following problem:
>  1. the  jffs2-image update in the u-boot was ok 
>  2. first restart and first mount of the NAND-flash-partition was also ok
>  3. before the restart of controller there are no any activity on NAND-flash except of the jffs2_gcd_mtdX-process ...
>  4. BUT after the second restart the NAND-flash-partition could not be really used after the second mount,
>     dmesg filled with messages:
> ...
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03ce0000: 0xc0ff instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03d00000: 0xc0ff instead
> ....
> Just for for info: the behaviour observed on mpc8313-based board.
> The only activity on NAND-flash was the garbage collector process, that looks for CLEANMARKER-nodes
> 
> Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
> Cc: Rolf Riehle <Rolf.Riehle@ids.de>
> --

Acked-by: Scott Wood <scottwood@freescale.com>

> 
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> index c141b07..775c2f5 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -388,6 +388,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  		         "page_addr: 0x%x, column: 0x%x.\n",
>  		         page_addr, column);
>  
> +		elbc_fcm_ctrl->column = column;
>  		elbc_fcm_ctrl->use_mdr = 1;

This was broken by commit 3ab8f2a2e7011c5e83363b42950757e46ef06824

That commit also removed the setting of ctrl->oob to 0, which should
also be restored.

-Scott

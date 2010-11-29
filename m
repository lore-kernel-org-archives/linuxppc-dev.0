Return-Path: <dedekind1@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 210411007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 01:53:33 +1100 (EST)
Received: by fxm15 with SMTP id 15so2753984fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 06:53:30 -0800 (PST)
Subject: Re: [PATCH][v2] Fixing the garbage collector problem after
	NAND-flash image record in u-boot
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Sergej.Stepanov@ids.de
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A106A0AA93A@HERMES2>
References: <4206182445660643B9AEB8D4E55BBD0A106A0AA93A@HERMES2>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 16:53:26 +0200
Message-ID: <1291042406.2141.14.camel@koala>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, dwmw2@infradead.org, Rolf.Riehle@ids.de
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-23 at 18:38 +0100, Sergej.Stepanov@ids.de wrote:
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
> Just for for info:
> the behaviour observed on mpc8313-based board with the large-page NAND.
> The only activity on NAND-flash was the garbage collector process, that looks for CLEANMARKER-nodes
> 
> As Scott said it was broken by commit 3ab8f2a2e7011c5e83363b42950757e46ef06824
> 
> Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
> Cc: Rolf Riehle <Rolf.Riehle@ids.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: David Woodhouse <dwmw2@infradead.org>

Pusehd to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy (Битюцкий Артём)

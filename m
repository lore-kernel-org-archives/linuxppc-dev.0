Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A5331007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2010 04:28:33 +1100 (EST)
Received: from mail62-am1 (localhost.localdomain [127.0.0.1])	by
	mail62-am1-R.bigfish.com (Postfix) with ESMTP id 7627B37019C	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 17:28:29 +0000 (UTC)
Received: from AM1EHSMHS001.bigfish.com (unknown [10.3.201.244])	by
	mail62-am1.bigfish.com (Postfix) with ESMTP id 3C86413F804C	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 17:28:29 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oBGHSPm1017249	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 10:28:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oBGHkvxA000877	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Dec 2010 11:46:57 -0600 (CST)
Message-ID: <4D0A4C38.3010105@freescale.com>
Date: Thu, 16 Dec 2010 11:28:24 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
	<4D0A446E.5020600@freescale.com>
	<AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
In-Reply-To: <AANLkTinOf__X0p3_5G90KkYS9PXpB2j0_06MFhFcZzqO@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> No.  It is a static property of the board/machine.  It is expected it
> to be encoded into the board's .dts file.

Ok, but that only makes sense if the monitor is hard-wired to the board itself.
 If a user can attach any monitor he wants, then the EDID data can't be known at
compile time.

I guess it's no different than using hard-coded memory controller programming
instead of SPD.  You can safely avoid SPD only if the DDR chips are soldered on
the board.

It looks like I need to add board-specific EDID reading to the DIU driver.

-- 
Timur Tabi
Linux kernel developer at Freescale

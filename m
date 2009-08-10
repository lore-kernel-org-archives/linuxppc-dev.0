Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2A3C2B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 17:49:05 +1000 (EST)
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B2039DDDA2
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 17:49:04 +1000 (EST)
Date: Mon, 10 Aug 2009 09:49:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Wolfgang Denk <wd@denx.de>
Subject: Re: sequoia: The final kernel image would overwrite the device
 tree
In-Reply-To: <20090808073807.18C4B832E416@gemini.denx.de>
Message-ID: <alpine.LRH.2.00.0908100948280.787@vixen.sonytel.be>
References: <alpine.LRH.2.00.0907281524510.29006@vixen.sonytel.be>
	<alpine.LRH.2.00.0908071740410.22357@vixen.sonytel.be>
	<1249678991.10143.1.camel@pasglop>
	<20090808073807.18C4B832E416@gemini.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 8 Aug 2009, Wolfgang Denk wrote:
> In message <1249678991.10143.1.camel@pasglop> you wrote:
> > My experience, however, with a Canyonlands board, is that uBoot has
> > a bug that makes it always allocate the device-tree below 8M and clash
> > with the kernel when it gets too big.
> > 
> > I think Stefan fixed that recently, you may need to rebuild your uboot,
> > I'll let him tell you the details about the fix.
> 
> Right. These are the relevant commits; they went into mainline some
> time ago:
> 
> commit 27dd5f8e1062684f1ba685760409d9b2ab6691bf
> Author: Stefan Roese <sr@denx.de>
> Date:   Tue Jul 28 10:56:03 2009 +0200
> 
>     ppc4xx: amcc: Move "kernel_addr_r" etc to higher locations (> 16MB)
>     
>     This patch moves the load addresses for kernel, fdt and ramdisk to higher
>     addresses (>= 16MB). This enables booting of bigger kernel images (e.g.
>     lockdep enabled).

Ah, thanks, that explains it.

I'll make sure my kernel images get smaller again ;-)

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

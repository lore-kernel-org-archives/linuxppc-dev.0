Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3BDAB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 17:38:14 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 30AB8DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 17:38:12 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: sequoia: The final kernel image would overwrite the device tree
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1249678991.10143.1.camel@pasglop>
References: <alpine.LRH.2.00.0907281524510.29006@vixen.sonytel.be>
	<alpine.LRH.2.00.0908071740410.22357@vixen.sonytel.be>
	<1249678991.10143.1.camel@pasglop>
Date: Sat, 08 Aug 2009 09:38:07 +0200
Message-Id: <20090808073807.18C4B832E416@gemini.denx.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ben,

In message <1249678991.10143.1.camel@pasglop> you wrote:
> 
> My experience, however, with a Canyonlands board, is that uBoot has
> a bug that makes it always allocate the device-tree below 8M and clash
> with the kernel when it gets too big.
> 
> I think Stefan fixed that recently, you may need to rebuild your uboot,
> I'll let him tell you the details about the fix.

Right. These are the relevant commits; they went into mainline some
time ago:

commit 27dd5f8e1062684f1ba685760409d9b2ab6691bf
Author: Stefan Roese <sr@denx.de>
Date:   Tue Jul 28 10:56:03 2009 +0200

    ppc4xx: amcc: Move "kernel_addr_r" etc to higher locations (> 16MB)
    
    This patch moves the load addresses for kernel, fdt and ramdisk to higher
    addresses (>= 16MB). This enables booting of bigger kernel images (e.g.
    lockdep enabled).
    
    Signed-off-by: Stefan Roese <sr@denx.de>

commit 6942efc2be1b90054fa4afa5cda7023469fe08b9
Author: Stefan Roese <sr@denx.de>
Date:   Tue Jul 28 10:50:32 2009 +0200

    ppc4xx: amcc: Set CONFIG_SYS_BOOTMAPSZ to 16MB for big kernels
    
    This patch changes CONFIG_SYS_BOOTMAPSZ from 8MB to 16MB which is the
    initial TLB on 40x PPC's in the Linux kernel. With this change even bigger
    Linux kernels (> 8MB) can be booted.
    
    This patch also sets CONFIG_SYS_BOOTM_LEN to 16MB (default 8MB) to enable
    decompression of bigger images.
    
    Signed-off-by: Stefan Roese <sr@denx.de>


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every solution breeds new problems.

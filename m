Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3944BB722F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 09:12:09 +1100 (EST)
Received: from mail121-tx2 (localhost.localdomain [127.0.0.1])	by
 mail121-tx2-R.bigfish.com (Postfix) with ESMTP id 09E46590094	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:11:53 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.246])	by
 mail121-tx2.bigfish.com (Postfix) with ESMTP id AA0E3190059	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:11:51 +0000 (UTC)
Message-ID: <4EC586B2.5060604@freescale.com>
Date: Thu, 17 Nov 2011 16:12:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
In-Reply-To: <20111117213733.GC14736@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> This has the side-effect of no longer requiring U-Boot to enable the DIU.
>> Now Linux can enable the DIU all by itself.
> 
> Under what circumstances does Linux do this?  

p1022ds_set_monitor_port() is called by the DIU driver when it enables the DIU.  This happens on boot, for example, if you enable the framebuffer console.

> How does Linux prevent the
> NOR flash driver from binding to the device when this mode has been or
> will be used?

It doesn't.  This isn't a simple problem to solve.  On the P1022, NOR flash and the DIU are incompatible, and yet that's exactly what we ship on the P1022DS board.  We could just remove the NOR flash node from the DTS.

-- 
Timur Tabi
Linux kernel developer at Freescale

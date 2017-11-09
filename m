Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXp872K1dzDrKD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 03:11:49 +1100 (AEDT)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: controlfb: Add missing modes to fix out of
 bounds access
Date: Thu, 09 Nov 2017 17:11:42 +0100
Message-id: <3213289.UpBeyY0aCM@amdc3058>
In-reply-to: <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <CGME20171107140514epcas4p2988fc367b675dd8facef2f2dba0908db@epcas4p2.samsung.com>
 <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, November 07, 2017 03:05:05 PM Geert Uytterhoeven wrote:
> Dan's static analysis says:
> 
>     drivers/video/fbdev/controlfb.c:560 control_setup()
>     error: buffer overflow 'control_mac_modes' 20 <= 21
> 
> Indeed, control_mac_modes[] has only 20 elements, while VMODE_MAX is 22,
> which may lead to an out of bounds read when parsing vmode commandline
> options.
> 
> The bug was introduced in v2.4.5.6, when 2 new modes were added to
> macmodes.h, but control_mac_modes[] wasn't updated:
> 
> https://kernel.opensuse.org/cgit/kernel/diff/include/video/macmodes.h?h=v2.5.2&id=29f279c764808560eaceb88fef36cbc35c529aad
> 
> Augment control_mac_modes[] with the two new video modes to fix this.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

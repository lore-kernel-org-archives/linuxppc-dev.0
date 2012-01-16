Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4DCB6EFF
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 03:12:33 +1100 (EST)
Message-ID: <4F144C6B.4020706@freescale.com>
Date: Mon, 16 Jan 2012 10:12:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org>
In-Reply-To: <21370.1326683320@neuling.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> drivers/video/fsl-diu-fb.c: In function 'fsl_diu_suspend':
> drivers/video/fsl-diu-fb.c:1435: error: incompatible type for argument 1 of 'disable_lcdc'
> drivers/video/fsl-diu-fb.c:592: note: expected 'struct fb_info *' but argument is of type 'struct fb_info'
> drivers/video/fsl-diu-fb.c: In function 'fsl_diu_resume':
> drivers/video/fsl-diu-fb.c:1445: error: incompatible type for argument 1 of 'enable_lcdc'
> drivers/video/fsl-diu-fb.c:583: note: expected 'struct fb_info *' but argument is of type 'struct fb_info'

I figured out what the problem is.  I never compiled a configuration with
CONFIG_PM enabled.  For some reason, CONFIG_PM is disabled when SMP is
enabled, and I only tested with mpc85xx_smp_defconfig.

-- 
Timur Tabi
Linux kernel developer at Freescale

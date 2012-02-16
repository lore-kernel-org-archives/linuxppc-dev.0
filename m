Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6132DB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 09:59:01 +1100 (EST)
Message-ID: <1329433132.2892.30.camel@pasglop>
Subject: Re: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 17 Feb 2012 09:58:52 +1100
In-Reply-To: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-16 at 18:02 +0800, Shengzhou Liu wrote:
> If USB UTMI PHY is not enable, writing to portsc register will lead to
> kernel hang during boot up.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> Apply for master branch of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> Tested on P5020DS, the issue was reported by Benjamin Herrenschmidt. 

This fixes the hang, but sadly doesn't make USB work. I now get:

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
/soc@ffe000000/usb@210000: Invalid 'dr_mode' property, fallback to host mode
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 44, io mem 0xffe210000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
fsl-ehci fsl-ehci.1: irq 45, io mem 0xffe211000
fsl-ehci fsl-ehci.1: USB 2.0 started, EHCI 1.00

 .../...

usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110

<remove device, re-plug it>

usb 1-1: new full-speed USB device number 3 using fsl-ehci
hub 1-0:1.0: unable to enumerate USB device on port 1

<remove again, re-plug it>

usb 1-1: new full-speed USB device number 4 using fsl-ehci
usb 1-1: device descriptor read/64, error -110

The blurb about "invalid dr_mode property" makes me think there's some
kind of disagreement between the device-tree coming with the machine and
what upstream expects. Basically the DT doesn't contain a dr_mode
property at all (which should be fine, host mode is what I want, but I
suspect some stuff aren't being configured properly by u-boot either...)

Cheers,
Ben.

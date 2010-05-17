Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A1A2B7DB5
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:56:06 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix P1020RDB boot hang due USB2
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100422154447.GA30785@oksana.dev.rtsoft.ru>
Date: Mon, 17 May 2010 10:55:47 -0500
Message-Id: <99DC6B8E-585B-4ABE-AD4A-7AA8FB57846D@kernel.crashing.org>
References: <20100422154447.GA30785@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 22, 2010, at 10:44 AM, Anton Vorontsov wrote:

> Since USB2 is shared with local bus, either local bus or USB2
> should be disabled. By default U-Boot enables local bus, so we
> have to disable USB2, otherwise kernel hangs:
> 
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
> fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
> fsl-ehci fsl-ehci.0: irq 28, io base 0xffe22000
> fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
> fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
> <hangs here>
> 
> Note that U-Boot doesn't clear 'status' property when it enables
> USB2, so we have to comment out the whole node.
> 
> To enable USB2, one can issue
> 'setenv hwconfig usb2:dr_mode=<host|peripheral>' command at the
> U-Boot prompt.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/boot/dts/p1020rdb.dts |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

applied to next

- k

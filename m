Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJwgb0RtPzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 00:22:51 +1000 (AEST)
Date: Tue, 31 May 2016 15:21:42 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Tobias Klauser <tklauser@distanz.ch>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Sonic Zhang <sonic.zhang@analog.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Barry Song <baohua@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Tony Prisk <linux@prisktech.co.nz>, Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 nios2-dev@lists.rocketboards.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Message-ID: <20160531142142.GX19428@n2100.arm.linux.org.uk>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2016 at 04:19:31PM +0200, Krzysztof Kozlowski wrote:
> Remove __init annotation from all of console->setup implementations
> because:
> 1. The pointer to it is stored in a struct console which is not
>    marked with __initdata.
> 2. It is referenced by register_console() from kernel which is not
>    marked with __init.

However, many of these drivers, the console can only be used when the
driver is built-in, and register_console() is only called early in
initialisation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

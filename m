Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 1B8942BDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2004 23:21:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
Date: Tue, 7 Dec 2004 07:02:15 -0500
Message-ID: <1102421377.6162.8.camel@jmcmullan>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Second Attempt: Driver model usage on embedded processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-12-06 at 23:03 -0600, Kumar Gala wrote:
> The intent was that I would use the platform_data pointer to pass =
board=20
> specific information to the driver.  We would have board specific code =

> which would fill in the information.  The question I have is how to=20
> handle the device variant information which is really static?

I use a 'struct device_ethernet_data' in my MPC85xx platform-device
patches at http://www.evillabs.net/~gus/patches

That seems to work well, and we could move it from
include/asm-ppc/device-ethernet.h to include/linux/device-ethernet.h to
make it more arch-independant. That covers MAC addrs and phy locations.

As for PHY IRQ, that's a thornier issue. For now, I put that in the
ethernet device's resource list.

--=20
Jason McMullan <jason.mcmullan@timesys.com>

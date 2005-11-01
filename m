Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17255.13444.672360.996441@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 20:25:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20051031190524.GE5055@mag.az.mvista.com>
References: <20051025075159.GA10316@localhost.localdomain>
	<17251.265.196352.234376@cargo.ozlabs.ibm.com>
	<20051031190524.GE5055@mag.az.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Sven Luther <sl@bplan-gmbh.de>
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements
	hotplug for the marvell gige functionality by probing the
	northbridge pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> It does have a PIC, DMA engine, and SRAM that Sven mentioned but there
> are also a serial controller (MPSC), an i2c controller, and a watchdog
> timer.  I would guess that the MPSC and i2c drivers, at least, should
> use MODULE_DEVICE_TABLE.  If you agree, I'll add it to the list.

But the point is that if one driver has claimed the device (because
its ID is in its module device table), the other drivers won't be able
to.  You need something like the macio driver that BenH did, which
claims the macio device and creates a macio bus structure and allows
individual macio device drivers to claim the pieces of it.

Paul.

Return-Path: <shannon.nelson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
Date: Mon, 17 Mar 2008 13:34:05 -0700
Message-ID: <BAE9DCEF64577A439B3A37F36F9B691C043E6716@orsmsx418.amr.corp.intel.com>
In-Reply-To: <20080316213002.GA2589@lixom.net>
References: <20080306233900.GA3969@lixom.net> <20080316213002.GA2589@lixom.net>
From: "Nelson, Shannon" <shannon.nelson@intel.com>
To: "Olof Johansson" <olof@lixom.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Sosnowski, Maciej" <maciej.sosnowski@intel.com>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org,
	linux-kernel@vger.kernel.org, hskinnemoen@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Olof Johansson [mailto:olof@lixom.net]=20
>Sent: Sunday, March 16, 2008 2:30 PM
>
>pasemi_dma: Driver for PA Semi PWRficient on-chip DMA engine
>
>DMA copy offload driver for PA Semi PWRficient. It uses the
>platform-specific functions to allocate channels, etc.
>
>Signed-off-by: Olof Johansson <olof@lixom.net>
>
>---
>
>Changes since last post:
>
>* Add DMA_INTERRUPT support and handling of the interrupt flag
>* Fix interrupt handler for above and add tasklet
>* Switch to spin_lock_bh() where possible
>* Remove empty dependency_added() function since it's no longer
>  used in the framework.
>* Fix bug in "ring full" estimation.
>
>Note that this still needs to go on top of the powerpc.git=20
>tree due to the
>pasemi_dma.h updates that this driver depends on. I suggest=20
>merging this
>through pasemi.git->powerpc.git->linus with an Acked-by from=20
>the DMA guys.

Hi Olof,

In the future please copy Maciej as one of "the DMA guys" as he has
taken over ioatdma for me.  Beyond that, one little picky comment
below...


>
>
>-Olof
>
> [...]
>=20
>+
>+static unsigned int channels =3D 4;
>+module_param(channels, uint, S_IRUGO);
>+MODULE_PARM_DESC(channels, "Number of channels for copy=20
>(default: 2)");

Is the number of channels defaulting to 2 or 4?

sln

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 6A5AFDE172
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 01:19:06 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Sat, 7 Jul 2007 17:12:44 +0200
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707094900.9473.48577.stgit@localhost.localdomain>
	<20070707150708.GA5387@lixom.net>
In-Reply-To: <20070707150708.GA5387@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071712.45173.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Olof Johansson wrote:
> On Sat, Jul 07, 2007 at 01:49:00PM +0400, Vitaly Bordug wrote:
> > 
> > This updates relevant platform code
> > (freescale mpc8349itx target) to make the CompactFlash
> > work in TrueIDE mode.
> 
> Shouldn't you be writing a PCMCIA driver instead for the CF, so it
> handles other devices as well? Then you get storage "for free", as
> well as hotplug, etc.

CF memory cards can be in either TrueIDE mode or PCMCIA mode. If you
only need to support memory cards, you should always use True-IDE
mode, because that offers a _much_ higher throughput with PIO mode
6 (25 MB/s) or UDMA mode 6 (133MB/s), compared to the PIO mode 0
(3.3 MB/s) in PCMCIA mode.

Of course, if the bus can only sustain PIO mode 0 anyway, you can
just as well do a PCMCIA driver, and get the ability to plug in
other cards, e.g. wlan or modem cards.

	Arnd <><

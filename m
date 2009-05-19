Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 8F93CDE0A6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 02:12:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Musings on PCI busses
Date: Tue, 19 May 2009 18:12:02 +0200
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
In-Reply-To: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905191812.03347.arnd@arndb.de>
Cc: Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 May 2009, Grant Likely wrote:
> 1) Probe the host controller in an of_platform driver. =A0This has the
> advantage of simplicity. =A0The probe routine will get automatically
> called when the PCI host controller device tree node is registered
> with the of_platform bus. =A0The bus parenthood also gets reflected in
> the device model and sysfs. =A0The disadvantage is that it defers PCI
> bus probing until after the of_platform bus is probed (maybe this is
> okay; maybe this already happens anyway).

This is also what we do on 64-bit systems (well, Cell at this time).
There are no fundamental problems with this, just some slightly
unexpected interactions e.g. when you have use a PCI serial port
as your console before probing PCI.

Making CONFIG_PPC_OF_PLATFORM_PCI probably requires some more
consolidation between pci_32.c and pci_64.c, but I'd consider
this a good thing.

	Arnd <><

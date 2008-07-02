Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E1587DEA57
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:04:35 +1000 (EST)
Date: Wed, 2 Jul 2008 17:04:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH v2] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080702150432.GA5910@aepfle.de>
References: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
	<4ca08ab3df251d90440c962ef15ead1a72d75f05.1214276944.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4ca08ab3df251d90440c962ef15ead1a72d75f05.1214276944.git.tony@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 24, Tony Breeds wrote:

> Currently we set the start of the .text section to be 4Mb for pSeries.
> In situations where the zImage is > 8Mb we'll fail to boot (due to
> overlapping with OF).  Move .text in a zImage from 4MB to 64MB (well past OF).
> 
> We still will not be able to load large zImage unless we also move OF,
> to that end, add a note to the zImage ELF to move OF to 32Mb.  If this
> is the very first kernel booted then we'll need to move OF manually by
> setting real-base.

Setting real-base to what?

What currently happens with a large boot file is:
Firmware loads the zImage at load-base, finds that the ELF file is too
large to fit into the memory window and stops.

With your patch, firmware loads 12566528 bytes, and starts the zImage.
The result is a truncated file, the initrd will be corrupted, kernel
panic in populate_rootfs().

The only system where firmware relocates itself from 12MB to 32MB is a
p640 with firmware version NAN04194.
All other systems seem to ignore the NOTE section, real-base remains at
0xc00000

So I do not think your patch is a real improvement,
clear error vs. silent corruption.

Do you happen to know how to automate the changing the value of
real-base? The addnote change has appearently no effect on recent
systems.

Olaf

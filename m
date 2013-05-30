Return-Path: <arno@natisbad.org>
Received: from smtp.natisbad.org (unknown
 [IPv6:2a01:e35:139b:9f90:221:70ff:fe55:8f78])
 by ozlabs.org (Postfix) with ESMTP id B909C2C0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 19:10:52 +1000 (EST)
From: arno@natisbad.org (Arnaud Ebalard)
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 12/13] ARM: kirkwood: remove redundant DT board files
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-13-git-send-email-sebastian.hesselbarth@gmail.com>
Date: Thu, 30 May 2013 11:06:08 +0200
Message-ID: <8738t4q1kv.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Lennert Buytenhek <buytenh@wantstofly.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jason and Sebastian,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

> With DT support for mv643xx_eth board specific init for some boards now
> is unneccessary. Remove those board files, Kconfig entries, and
> corresponding entries in kirkwood_defconfig.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Note: board-km_kirkwood.c is also removed, as Valentin Longchamp confirmed
> the lock-up is not caused by accessing clock gating registers but rather
> non-existent device registers. This will be addressed by dtsi separation
> for kirkwood and bobcat SoC variants.
>
> Changelog:
> v3->v4:
> - remove more boards that don't require board specific setup
>
> Cc: David Miller <davem@davemloft.net>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/configs/kirkwood_defconfig           |   16 ----
>  arch/arm/mach-kirkwood/Kconfig                |  117 -------------------------
>  arch/arm/mach-kirkwood/Makefile               |   16 ----
>  arch/arm/mach-kirkwood/board-dnskw.c          |    7 --
>  arch/arm/mach-kirkwood/board-dockstar.c       |   32 -------
>  arch/arm/mach-kirkwood/board-dreamplug.c      |   35 --------
>  arch/arm/mach-kirkwood/board-dt.c             |   62 +------------
>  arch/arm/mach-kirkwood/board-goflexnet.c      |   34 -------
>  arch/arm/mach-kirkwood/board-guruplug.c       |   33 -------
>  arch/arm/mach-kirkwood/board-ib62x0.c         |   29 ------
>  arch/arm/mach-kirkwood/board-iconnect.c       |   10 ---
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   34 -------
>  arch/arm/mach-kirkwood/board-km_kirkwood.c    |   44 ----------
>  arch/arm/mach-kirkwood/board-lsxl.c           |   16 ----
>  arch/arm/mach-kirkwood/board-mplcec4.c        |   14 ---
>  arch/arm/mach-kirkwood/board-ns2.c            |   35 --------
>  arch/arm/mach-kirkwood/board-openblocks_a6.c  |   26 ------
>  arch/arm/mach-kirkwood/board-readynas.c       |    6 --

Just a stupid note: With Thomas ongoing work to get mvebu-pcie driver in
place and enabled for kirkwood, some boards setup files will also lose
their pcie init routines, which may allow you to kill those additonal
files soon.

For instance 6bd98481ab34 (arm: kirkwood: NETGEAR ReadyNAS Duo v2 init
PCIe via DT) currently sitting in jcooper/mvebu/pcie_kirkwood removes
the PCIE init routine in board-readynas.c, and yours remove ge00
init. With both applied, the whole file can go away.

AFAICT, this may be the case soon for:

 arch/arm/mach-kirkwood/board-iconnect.c   (36e5722089)
 arch/arm/mach-kirkwood/board-mplcec4.c    (9470fbfb8d)
 arch/arm/mach-kirkwood/board-nsa310.c     (40fa8e5da2)
 arch/arm/mach-kirkwood/board-readynas.c   (6bd98481ab)
 arch/arm/mach-kirkwood/board-ts219.c      (259e234608)

Anyway, thanks for this work Sebastian.

Cheers,

a+

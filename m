Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 62603DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 04:32:31 +1100 (EST)
Date: Fri, 20 Feb 2009 20:32:28 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 0/13] FSL eSDHC support
Message-ID: <20090220173228.GA5091@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Some updates for the eSDHC support:

Changes since the third RFC:
- Use uninitialized_var() (suggested by Laurent Pinchart);
- Fixed a bug in eSDHC SDCLK prescaler calculations because of which
  we were over-clocking the SDCLK, and that caused CRC errors using some
  SD cards;
- Not a change, but some status: SDHS (50 MHz) cards were tested to
  NOT work (at least on MPC837x boards) -- this is to be investigated
  further. SDHC (> 4 GB) cards were not tested, yet.

Changes since the second RFC:
- Addressed all comments that were raised by Pierre Ossman.
  There were too many to mention them all, so here is the link:
  http://lkml.org/lkml/2009/2/6/320

Changes since the first RFC:
- Use of_iomap() in sdhci-of.c (suggested by Arnd Bergmann). Also added
  Arnd's Acked-by: line for the sdhci-of patch.
- Kconfig help text improved (thanks to Matt Sealey and M. Warner Losh).
- In "sdhci: Add quirk to suppress PIO interrupts during DMA transfers"
  patch: sdhci_init() now clears SDHCI_PIO_DISABLED flag, otherwise we
  won't disable PIO interrupts after suspend.
- New patch: "sdhci: Add type checking for IO memory accessors"

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

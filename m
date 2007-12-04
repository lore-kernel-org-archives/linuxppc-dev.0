Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1418CDDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 11:04:22 +1100 (EST)
Date: Mon, 3 Dec 2007 18:07:44 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Re: Please pull pasemi.git for-2.6.25 branch
Message-ID: <20071204000744.GC7041@lixom.net>
References: <20071203050446.GC24492@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071203050446.GC24492@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 02, 2007 at 11:04:47PM -0600, Olof Johansson wrote:
> Paul,
> 
> Please do:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.25
> 
> For the following patches queued up for 2.6.25. All but one are PA
> Semi-specific (the i2c boardinfo consolidation that's a pre-req for the
> platform-specific one).

Sorry for the churn here, I hope you haven't pulled yet.

Based on today's i2c patches from Jon Smirl, it makes more sense for me
to hold off on my i2c changes and make them on top of his work once that
has been merged.

I've backed out and rebased the patch set, new shortlog and diffstat:

 arch/powerpc/platforms/pasemi/Kconfig     |    2 
 arch/powerpc/platforms/pasemi/cpufreq.c   |   19 +++++-
 arch/powerpc/platforms/pasemi/gpio_mdio.c |   94 ++++++++++++++++++------------
 arch/powerpc/platforms/pasemi/pasemi.h    |    6 +
 arch/powerpc/platforms/pasemi/powersave.S |   11 +++
 arch/powerpc/platforms/pasemi/setup.c     |   16 ++++-
 drivers/char/hw_random/Kconfig            |    2 
 drivers/char/hw_random/pasemi-rng.c       |    7 --
 drivers/edac/pasemi_edac.c                |    4 -
 9 files changed, 111 insertions(+), 50 deletions(-)

Olof Johansson (5):
      [POWERPC] pasemi: clean up mdio_gpio a bit
      [POWERPC] pasemi: Broaden specific references to 1682M
      [POWERPC] pasemi: Don't enter powersaving states from elevated astates
      [POWERPC] pasemi: Move cpus to hold loop before restart
      [POWERPC] pasemi: Fix module information for gpio-mdio


-Olof

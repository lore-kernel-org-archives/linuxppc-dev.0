Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E023AB6FEE
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 13:06:04 +1000 (EST)
Message-ID: <1333249549.6298.22.camel@clam>
Subject: [RFC] PS3 updates for the highmem region
From: Geoff Levand <geoff@infradead.org>
To: Andre Heider <a.heider@gmail.com>, Hector Martin
 <hector@marcansoft.com>,  Nathan Whitehorn <nwhitehorn@freebsd.org>
Date: Sat, 31 Mar 2012 20:05:49 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I've rebased and reworked the PS3 highmem patches that Hector and Andre have
submitted.  They are now against Linux-3.3, and I plan for them to go upstream
for Linux-3.5.  I'll rebase them again once a few 3.4-rc's are out.

This work needs to be tested more, especially needed is testing of the passing of
data in the highmem region.  Please test and report.

Nathan, these patches fix the well known node names, so it would be best
if you could add support to test for pre-allocated highmem regions in
your FreeBSD port.

-Geoff

The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

  Linux 3.3 (2012-03-18 16:15:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

for you to fetch changes up to aab56ec9e2989fc9960cae3927534cb81173dff5:

  powerpc/ps3: Refresh ps3_defconfig (2012-03-31 18:25:20 -0700)

----------------------------------------------------------------
Andre Heider (3):
      powerpc/ps3: Add highmem repository read routines
      powerpc/ps3: Use highmem region from repository
      powerpc/ps3: Remove MEMORY_HOTPLUG requirement

Geoff Levand (5):
      powerpc/ps3: Correct lv1 repository routine names
      powerpc/ps3: Add PS3 repository write support
      powerpc/ps3: Add highmem repository write routines
      powerpc/ps3: Minor Kconfig cleanup
      powerpc/ps3: Refresh ps3_defconfig

Hector Martin (1):
      powerpc/ps3: Add highmem region memory early

 arch/powerpc/configs/ps3_defconfig      |    8 +-
 arch/powerpc/include/asm/lv1call.h      |    4 +-
 arch/powerpc/platforms/ps3/Kconfig      |   22 +++-
 arch/powerpc/platforms/ps3/mm.c         |   77 ++++++------
 arch/powerpc/platforms/ps3/platform.h   |   16 +++
 arch/powerpc/platforms/ps3/repository.c |  198 +++++++++++++++++++++++++++++++
 6 files changed, 277 insertions(+), 48 deletions(-)

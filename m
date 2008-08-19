Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 586FCDE2BE
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:35 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:33 -0700 (PDT)
Message-Id: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:36:28 -0400
Subject: [PATCH 0/9] Rework PowerPC 44x board support
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series reworks the board support code for PowerPC 44x
platforms.  It eliminates a number of redundant <board>.c files and add a
ppc44x_simple.c file that has an explicit list of boards that are supported
by it.  This is the same mechanism that Grant Likely has used for MPC 5200
boards.

It also adds some more explicit support for Glacier and Yosemite boards, as
those boards were using a board level compatible property in their DTS files
that was a bit confusing.

Review would be appreciated.  Tested on Sequoia, and I plan on testing on as
many boards as I can before committing to my tree.

josh

Josh Boyer (9):
  powerpc/44x: Add PowerPC 44x simple platform support
  powerpc/44x: Migrate Bamboo support to ppc44x_simple
  powerpc/44x: Migrate Canyonlands support to ppc44x_simple
  powerpc/44x: Migrate Katmai support to ppc44x_simple
  powerpc/44x: Migrate Rainier support to ppc44x_simple
  powerpc/44x: Migrate Sequoia support to ppc44x_simple
  powerpc/44x: Migrate Taishan support to ppc44x_simple
  powerpc/44x: Add explicit support for AMCC Glacier
  powerpc/44x: Add explicit Yosemite support

 arch/powerpc/boot/dts/glacier.dts          |    2 +-
 arch/powerpc/boot/dts/yosemite.dts         |    2 +-
 arch/powerpc/platforms/44x/Kconfig         |   25 ++++++++
 arch/powerpc/platforms/44x/Makefile        |    8 +--
 arch/powerpc/platforms/44x/bamboo.c        |   62 ---------------------
 arch/powerpc/platforms/44x/canyonlands.c   |   63 ---------------------
 arch/powerpc/platforms/44x/katmai.c        |   62 ---------------------
 arch/powerpc/platforms/44x/ppc44x_simple.c |   83 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/rainier.c       |   62 ---------------------
 arch/powerpc/platforms/44x/sequoia.c       |   63 ---------------------
 arch/powerpc/platforms/44x/taishan.c       |   72 ------------------------
 11 files changed, 111 insertions(+), 393 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/bamboo.c
 delete mode 100644 arch/powerpc/platforms/44x/canyonlands.c
 delete mode 100644 arch/powerpc/platforms/44x/katmai.c
 create mode 100644 arch/powerpc/platforms/44x/ppc44x_simple.c
 delete mode 100644 arch/powerpc/platforms/44x/rainier.c
 delete mode 100644 arch/powerpc/platforms/44x/sequoia.c
 delete mode 100644 arch/powerpc/platforms/44x/taishan.c

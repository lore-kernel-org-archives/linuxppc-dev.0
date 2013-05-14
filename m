Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8AFB02C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:41:34 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/2] powerpc/mpc512x: improve common platform code
Date: Tue, 14 May 2013 16:40:52 +0200
Message-Id: <1368542454-11003-1-git-send-email-gsi@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the first change concentrates specific details in the shared routines,
and passes all board support for the ADS, PDM, and generic boards
through the common MPC512x code (specifically the init, init early, and
setup arch routines)

the second change slightly modifies behaviour in that it moves the
restart initialization to an earlier stage in the boot process, to
prevent hangs and allow boards to reboot upon early failure


Gerhard Sittig (2):
  powerpc/mpc512x: move common code to the shared.c file
  powerpc/mpc512x: initialize board restart earlier

 arch/powerpc/include/asm/mpc5121.h            |    1 -
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    6 ++----
 arch/powerpc/platforms/512x/mpc512x.h         |   11 ++---------
 arch/powerpc/platforms/512x/mpc512x_generic.c |    4 ++--
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   16 ++++++++++++++--
 arch/powerpc/platforms/512x/pdm360ng.c        |    4 ++--
 6 files changed, 22 insertions(+), 20 deletions(-)

-- 
1.7.10.4

Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CB3AFB7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Mar 2011 07:52:14 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] RapidIO: configuration and initialization changes 
Date: Mon, 28 Feb 2011 15:51:00 -0500
Message-Id: <1298926265-5381-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This set of patches eliminates RapidIO dependency on PowerPC architecture and
makes it available to other architectures (x86 and MIPS).
It also enables support of new platform independent RapidIO controllers such
as PCI-to-SRIO and PCI Express-to-SRIO.

Alexandre Bounine (5):
  RapidIO: Add architecture specific callbacks
  RapidIO: Modify configuration to support PCI-SRIO controller
  RapidIO: Modify subsystem and driver initialization sequence
  RapidIO: Modify mport ID assignment
  RapidIO: remove mport resource reservation from common RIO code

 arch/mips/Kconfig             |   10 ++++
 arch/powerpc/Kconfig          |   10 ++++-
 arch/powerpc/sysdev/Makefile  |    2 +-
 arch/powerpc/sysdev/fsl_rio.c |   96 ++++++++++++++++-------------------------
 arch/x86/Kconfig              |   10 ++++
 drivers/net/rionet.c          |    6 +-
 drivers/rapidio/rio-sysfs.c   |    1 +
 drivers/rapidio/rio.c         |   84 ++++++++++++++++++++++++-----------
 include/linux/rio.h           |   25 ++++++++---
 include/linux/rio_drv.h       |    7 ++-
 10 files changed, 151 insertions(+), 100 deletions(-)

-- 
1.7.3.1

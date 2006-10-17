Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41D4467BF2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 06:15:33 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	k9HGmrHA017610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 11:48:53 -0500
Date: Tue, 17 Oct 2006 09:50:03 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] viocons: make powerpc allmodconfig build
Message-Id: <20061017095003.c447d88a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

Make allmodconfig .config build successfully by making VIOCONS
available only if VT=n.
Using PPC_ISERIES in VT prevents kconfig "recursive" warning.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/powerpc/platforms/iseries/Kconfig |    2 +-
 drivers/char/Kconfig                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2619-rc2-ppc.orig/drivers/char/Kconfig
+++ linux-2619-rc2-ppc/drivers/char/Kconfig
@@ -7,7 +7,7 @@ menu "Character devices"
 config VT
 	bool "Virtual terminal" if EMBEDDED
 	select INPUT
-	default y if !VIOCONS
+	default y if !PPC_ISERIES
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
--- linux-2619-rc2-ppc.orig/arch/powerpc/platforms/iseries/Kconfig
+++ linux-2619-rc2-ppc/arch/powerpc/platforms/iseries/Kconfig
@@ -3,7 +3,7 @@ menu "iSeries device drivers"
 	depends on PPC_ISERIES
 
 config VIOCONS
-	tristate "iSeries Virtual Console Support (Obsolete)"
+	tristate "iSeries Virtual Console Support (Obsolete)" if !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console


---

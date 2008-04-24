Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id E1A07DE579
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 03:34:48 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JZU00EZKBGAGX60@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 24 Apr 2008 11:33:46 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JZU0008SBGA7H40@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 24 Apr 2008 11:33:47 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JZU003QABG9C000@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 24 Apr 2008 11:33:46 -0600 (MDT)
Date: Thu, 24 Apr 2008 11:33:44 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] bootwrapper: fix build error on virtex405-head.S
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, paulus@samba.org
Message-id: <20080424173246.17691.73308.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

virtex405-head.S is an assembler file, not a C file; therefore BOOTAFLAGS
is the correct place to set the needed -mcpu=405 flag.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
Paul, Josh;

This is a bug fix required in .26 ASAP.

Cheers,
g.

 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 5ba50c6..7822d25 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -40,7 +40,7 @@ $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
-$(obj)/virtex405-head.o: BOOTCFLAGS += -mcpu=405
+$(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
 zlib       := inffast.c inflate.c inftrees.c

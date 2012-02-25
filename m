Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A61A8B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 11:23:52 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 19:23:48 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EB2FB6E804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 19:23:44 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1P0NjAO3035138
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 19:23:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1P0Ni2K020965
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 22:23:45 -0200
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/prom: bump up maximum size of properties
Date: Fri, 24 Feb 2012 16:23:42 -0800
Message-Id: <1330129422-2648-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Robert Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a 16TB system (using AMS/CMO), I get:

WARNING: ignoring large property [/ibm,dynamic-reconfiguration-memory] ibm,dynamic-memory length 0x000000000017ffec

and significantly less memory is thus shown to the partition. As far as
I can tell, the constant used is arbitrary, but bump it up to 2MB, which
covers the above property (approximately 1.5MB).

With this patch, the kernel does see all of the system memory on the
16TB system.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eca626e..0bf0ccc 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -53,7 +53,7 @@
  * ensure that we don't lose things like the interrupt-map property
  * on a PCI-PCI bridge.
  */
-#define MAX_PROPERTY_LENGTH	(1UL * 1024 * 1024)
+#define MAX_PROPERTY_LENGTH	(2UL * 1024 * 1024)
 
 /*
  * Eventually bump that one up
-- 
1.7.5.4

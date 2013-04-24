Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E0762C0717
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:08:31 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 10:08:27 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 098B819D806A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:06:30 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OG6TOb120610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:06:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OG6NqQ002025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:06:23 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OG6LeY001656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:06:22 -0600
Message-ID: <517802F9.8000408@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:06:17 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 12/13] Enable PRRN handling
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Linux kernel and platform firmware negotiate their mutual support
of the PRRN option via the ibm,client-architecture-support interface.
This patch simply sets the appropriate fields in the client architecture
vector to indicate Linux support for PRRN and will allow the firmware to
report PRRN events via the RTAS event-scan mechanism.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-04-23 14:46:23.000000000 -0500
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-04-23 15:30:36.000000000 -0500
@@ -698,7 +698,7 @@
 #else
 	0,
 #endif
-	OV5_FEAT(OV5_TYPE1_AFFINITY),
+	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
 	0,
 	0,
 	0,

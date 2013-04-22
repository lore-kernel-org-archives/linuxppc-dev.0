Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35CF92C0112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:47:15 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:47:13 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A9E3638C8029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:47:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIl9Lo60162056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:47:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIl9OA017807
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:47:09 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIl90e017793
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:47:09 -0300
Message-ID: <517585AD.2030400@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:47:09 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 11/12] Enable PRRN Event handling
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
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
vector to indicate Linux support and will cause the firmware to begin
sending PRRN events via the RTAS event-scan mechanism.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-04-18 09:09:22.000000000 -0500
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-04-22 09:49:28.000000000 -0500
@@ -698,7 +698,7 @@
 #else
 	0,
 #endif
-	OV5_FEAT(OV5_TYPE1_AFFINITY),
+	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
 	0,
 	0,
 	0,

Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8C9D2C038C
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:08:51 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:08:49 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 257591FF0026
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:03:53 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2948kNd176914
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2948kAT027166
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:46 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2948j2I027099
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:45 -0700
Message-ID: <513AB5CC.1060006@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:08:44 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/11] Enable PRRN
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-03-08 19:57:14.000000000 -0600
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-03-08 19:58:18.000000000 -0600
@@ -689,7 +689,7 @@
 	OV5_FEAT(OV5_MSI),
 	0,
 	OV5_FEAT(OV5_CMO) | OV5_FEAT(OV5_XCMO),
-	OV5_FEAT(OV5_TYPE1_AFFINITY),
+	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
 	0,
 	0,
 	0,

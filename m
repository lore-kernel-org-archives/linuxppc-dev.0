Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1671E2C05BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 06:02:52 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 13:02:50 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5E60B19D804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:41 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PJ2gha164338
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:02:42 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PJ1XT0009233
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:01:33 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PJ1WPU009179
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 13:01:32 -0600
Message-ID: <51509F03.6040501@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 14:01:23 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/11] Enable PRRN
References: <51509AE8.8070803@linux.vnet.ibm.com>
In-Reply-To: <51509AE8.8070803@linux.vnet.ibm.com>
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
--- powerpc.orig/arch/powerpc/kernel/prom_init.c	2013-03-20 12:25:38.000000000 -0500
+++ powerpc/arch/powerpc/kernel/prom_init.c	2013-03-20 12:27:50.000000000 -0500
@@ -698,7 +698,7 @@
 #else
 	0,
 #endif
-	OV5_FEAT(OV5_TYPE1_AFFINITY),
+	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
 	0,
 	0,
 	0,

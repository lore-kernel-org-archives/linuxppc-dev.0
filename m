Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10F9C2C013D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 12:52:29 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 20 Aug 2013 08:16:00 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8C8E7E004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:22:51 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7K2roOV45219916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:23:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7K2qN9D032700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:22:23 +0530
Received: from [9.65.233.1] (sig-9-65-233-1.mts.ibm.com [9.65.233.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 r7K2qLm0032668
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:22:22 +0530
Message-ID: <5212D9E4.40500@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 21:52:20 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] Mark Memory Resources as busy
References: <5212D989.8090103@linux.vnet.ibm.com>
In-Reply-To: <5212D989.8090103@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory I/O resources need to be marked as busy or else we cannot remove
them when doing memory hot remove.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/powerpc/mm/mem.c
===================================================================
--- linux.orig/arch/powerpc/mm/mem.c
+++ linux/arch/powerpc/mm/mem.c
@@ -514,7 +514,7 @@ static int add_system_ram_resources(void
 			res->name = "System RAM";
 			res->start = base;
 			res->end = base + size - 1;
-			res->flags = IORESOURCE_MEM;
+			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 			WARN_ON(request_resource(&iomem_resource, res) < 0);
 		}
 	}

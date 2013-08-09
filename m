Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79DDD2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 01:30:37 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 20:50:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E92C43940053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 21:00:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r79FViGv46006524
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:01:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r79FUUJN004371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:00:30 +0530
Received: from [9.41.105.123] ([9.41.105.123])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 r79FUSJN004194
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:00:29 +0530
Message-ID: <52050B14.4030304@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 10:30:28 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] Mark memory resources as busy
References: <52050ACE.4090001@linux.vnet.ibm.com>
In-Reply-To: <52050ACE.4090001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory resources should be marked as busy.

If memory resources are not marked as busy they do not get released during
hotplug memory remove. This seems a bit counter intuitive but the core
kernel resource code checks for the IORESOURCE_BUSY flag before releasing
the resource.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c
+++ powerpc/arch/powerpc/mm/mem.c
@@ -514,7 +514,7 @@ static int add_system_ram_resources(void
 			res->name = "System RAM";
 			res->start = base;
 			res->end = base + size - 1;
-			res->flags = IORESOURCE_MEM;
+			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 			WARN_ON(request_resource(&iomem_resource, res) < 0);
 		}
 	}

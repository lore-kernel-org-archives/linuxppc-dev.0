Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1DD62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:36:39 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 15:31:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 712142CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:36:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OIL4lx66453746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:21:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OIaaT0029809
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:36:37 +1000
Message-ID: <51F01EB2.9060802@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 13:36:34 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] Mark powerpc memory resources as busy
References: <51F01E06.6090800@linux.vnet.ibm.com>
In-Reply-To: <51F01E06.6090800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 isimatu.yasuaki@jp.fujitsu.com
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
@@ -523,7 +523,7 @@ static int add_system_ram_resources(void
 			res->name = "System RAM";
 			res->start = base;
 			res->end = base + size - 1;
-			res->flags = IORESOURCE_MEM;
+			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 			WARN_ON(request_resource(&iomem_resource, res) < 0);
 		}
 	}

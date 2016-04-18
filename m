Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpGQ61Sc9zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:08:46 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 18 Apr 2016 15:08:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BEDA2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:08:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I58Wgu6816162
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:08:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3I588nh030457
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:08:08 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com
Subject: [PATCH] cxl: static-ify variables to fix sparse warnings
Date: Mon, 18 Apr 2016 15:03:50 +1000
Message-Id: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make a couple more variables static. Found by sparse.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 68dd0b7..c63d61e 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -24,8 +24,8 @@ struct ai_header {
 };
 
 static struct semaphore sem;
-unsigned long *buffer[CXL_AI_MAX_ENTRIES];
-struct sg_list *le;
+static unsigned long *buffer[CXL_AI_MAX_ENTRIES];
+static struct sg_list *le;
 static u64 continue_token;
 static unsigned int transfer;
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

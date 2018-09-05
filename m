Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424nGk2V3GzF37V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 12:10:22 +1000 (AEST)
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so2500688plb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 19:10:22 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, joel@jms.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 2/2] powerpc/pseries: Remove VLA from lparcfg_write()
Date: Wed,  5 Sep 2018 12:09:51 +1000
Message-Id: <20180905020951.10372-3-sjitindarsingh@gmail.com>
In-Reply-To: <20180905020951.10372-1-sjitindarsingh@gmail.com>
References: <20180905020951.10372-1-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In lparcfg_write we hard code kbuf_sz and then use this as the variable
length of kbuf creating a variable length array. Since we're hard coding
the length anyway just define the array using this as the length and
remove the need for kbuf_sz, thus removing the variable length array.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 7c872dc01bdb..8bd590af488a 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -585,8 +585,7 @@ static ssize_t update_mpp(u64 *entitlement, u8 *weight)
 static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 			     size_t count, loff_t * off)
 {
-	int kbuf_sz = 64;
-	char kbuf[kbuf_sz];
+	char kbuf[64];
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr = &new_entitled;
 	u8 new_weight, *new_weight_ptr = &new_weight;
@@ -595,7 +594,7 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count > kbuf_sz)
+	if (count > sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
-- 
2.13.6

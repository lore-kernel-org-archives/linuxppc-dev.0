Return-Path: <prarit@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4B1B22C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 23:00:42 +1100 (EST)
From: Prarit Bhargava <prarit@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [PATCH] powerpc/vio: use strcpy in modalias_show
Date: Thu, 17 Oct 2013 08:00:11 -0400
Message-Id: <1382011211-15272-1-git-send-email-prarit@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, ben@decadent.org.uk,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 used strcat instead of
strcpy which can result in an overflow of newlines on the buffer.

Signed-off-by: Prarit Bhargava
Cc: benh@kernel.crashing.org
Cc: ben@decadent.org.uk
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/vio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index d38cc08..cb92d82 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1531,12 +1531,12 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 	dn = dev->of_node;
 	if (!dn) {
-		strcat(buf, "\n");
+		strcpy(buf, "\n");
 		return strlen(buf);
 	}
 	cp = of_get_property(dn, "compatible", NULL);
 	if (!cp) {
-		strcat(buf, "\n");
+		strcpy(buf, "\n");
 		return strlen(buf);
 	}
 
-- 
1.7.9.3

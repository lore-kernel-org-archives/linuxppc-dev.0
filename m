Return-Path: <prarit@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id F3F402C009A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 23:16:33 +1000 (EST)
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8NDGVXv020124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 09:16:31 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc, vio fix modalias_show return values
Date: Mon, 23 Sep 2013 09:16:10 -0400
Message-Id: <1379942170-22458-1-git-send-email-prarit@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

modalias_show() should return an empty string on error, not -ENODEV.

This causes the following false and annoying error:

> find /sys/devices -name modalias -print0 | xargs -0 cat >/dev/null
cat: /sys/devices/vio/4000/modalias: No such device
cat: /sys/devices/vio/4001/modalias: No such device
cat: /sys/devices/vio/4002/modalias: No such device
cat: /sys/devices/vio/4004/modalias: No such device
cat: /sys/devices/vio/modalias: No such device

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 arch/powerpc/kernel/vio.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 78a3506..d38cc08 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1530,11 +1530,15 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	const char *cp;
 
 	dn = dev->of_node;
-	if (!dn)
-		return -ENODEV;
+	if (!dn) {
+		strcat(buf, "\n");
+		return strlen(buf);
+	}
 	cp = of_get_property(dn, "compatible", NULL);
-	if (!cp)
-		return -ENODEV;
+	if (!cp) {
+		strcat(buf, "\n");
+		return strlen(buf);
+	}
 
 	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
 }
-- 
1.7.9.3

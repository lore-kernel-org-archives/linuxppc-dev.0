Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 9A89E1A01C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:41 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] powerpc/pseries: replace sscanf by kstrtoul
Date: Sat, 12 Jul 2014 13:36:20 +0200
Message-Id: <1405164980-9525-8-git-send-email-fabf@skynet.be>
In-Reply-To: <1405164980-9525-1-git-send-email-fabf@skynet.be>
References: <1405164980-9525-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See checkpatch warning
"Prefer kstrto<type> to single variable sscanf"

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/powerpc/platforms/pseries/power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/power.c b/arch/powerpc/platforms/pseries/power.c
index 6d62662..27a3e9c 100644
--- a/arch/powerpc/platforms/pseries/power.c
+++ b/arch/powerpc/platforms/pseries/power.c
@@ -38,11 +38,10 @@ static ssize_t auto_poweron_store(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  const char *buf, size_t n)
 {
-	int ret;
 	unsigned long ups_restart;
-	ret = sscanf(buf, "%lu", &ups_restart);
+	int ret = kstrtoul(buf, 0, &ups_restart);
 
-	if ((ret == 1) && ((ups_restart == 1) || (ups_restart == 0))){
+	if ((!ret) && ((ups_restart == 1) || (ups_restart == 0))) {
 		rtas_poweron_auto = ups_restart;
 		return n;
 	}
-- 
1.9.1

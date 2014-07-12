Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 3384A1A01C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:39 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] powerpc/sysfs: replace sscanf by kstrtol
Date: Sat, 12 Jul 2014 13:36:17 +0200
Message-Id: <1405164980-9525-5-git-send-email-fabf@skynet.be>
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
 arch/powerpc/kernel/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 67fd2fd..4293e4f 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -43,12 +43,11 @@ static ssize_t store_smt_snooze_delay(struct device *dev,
 				      size_t count)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	ssize_t ret;
 	long snooze;
+	int rc = kstrtol(buf, 0, &snooze);
 
-	ret = sscanf(buf, "%ld", &snooze);
-	if (ret != 1)
-		return -EINVAL;
+	if (rc)
+		return rc;
 
 	per_cpu(smt_snooze_delay, cpu->dev.id) = snooze;
 	return count;
-- 
1.9.1

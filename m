Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 5C1471A01C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:38 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] powerpc/powernv: replace sscanf %lx by kstrtoul 16
Date: Sat, 12 Jul 2014 13:36:16 +0200
Message-Id: <1405164980-9525-4-git-send-email-fabf@skynet.be>
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
 arch/powerpc/platforms/powernv/subcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 894ecb3..79721b2 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -337,9 +337,9 @@ static ssize_t __used store_subcores_per_core(struct device *dev,
 
 	/* We are serialised by the attribute lock */
 
-	rc = sscanf(buf, "%lx", &val);
-	if (rc != 1)
-		return -EINVAL;
+	rc = kstrtoul(buf, 16, &val);
+	if (rc)
+		return rc;
 
 	switch (val) {
 	case 1:
-- 
1.9.1

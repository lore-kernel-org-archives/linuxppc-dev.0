Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 92C2C1A01C7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:41 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7]  powerpc/cell: replace sscanf by kstrtouint
Date: Sat, 12 Jul 2014 13:36:19 +0200
Message-Id: <1405164980-9525-7-git-send-email-fabf@skynet.be>
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
 arch/powerpc/platforms/cell/cbe_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cbe_thermal.c b/arch/powerpc/platforms/cell/cbe_thermal.c
index 2c15ff0..d71c3c4 100644
--- a/arch/powerpc/platforms/cell/cbe_thermal.c
+++ b/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -129,9 +129,9 @@ static ssize_t store_throttle(struct cbe_pmd_regs __iomem *pmd_regs, const char
 	u64 new_value;
 	int ret;
 
-	ret = sscanf(buf, "%u", &temp);
+	ret = kstrtouint(buf, 0, &temp);
 
-	if (ret != 1 || temp < TEMP_MIN || temp > TEMP_MAX)
+	if (ret || temp < TEMP_MIN || temp > TEMP_MAX)
 		return -EINVAL;
 
 	new_value = temp_to_reg(temp);
-- 
1.9.1

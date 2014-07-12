Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id DFEAA1A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:36 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] powerpc: fadump: replace sscanf by kstrtoint
Date: Sat, 12 Jul 2014 13:36:14 +0200
Message-Id: <1405164980-9525-2-git-send-email-fabf@skynet.be>
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
 arch/powerpc/kernel/fadump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 742694c..3c40b5f 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -426,6 +426,7 @@ static inline int fadump_gpr_index(u64 id)
 {
 	int i = -1;
 	char str[3];
+	int rc;
 
 	if ((id & GPR_MASK) == REG_ID("GPR")) {
 		/* get the digits at the end */
@@ -434,8 +435,8 @@ static inline int fadump_gpr_index(u64 id)
 		str[2] = '\0';
 		str[1] = id & 0xff;
 		str[0] = (id >> 8) & 0xff;
-		sscanf(str, "%d", &i);
-		if (i > 31)
+		rc = kstrtoint(str, 0, &i);
+		if (rc || i > 31)
 			i = -1;
 	}
 	return i;
-- 
1.9.1

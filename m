Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 17/63] powerpc: Add some endian annotations to time and xics
 code
Date: Wed,  7 Aug 2013 02:01:34 +1000
Message-Id: <1375804940-22050-18-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a couple of sparse warnings.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/time.c            | 2 +-
 arch/powerpc/sysdev/xics/icp-native.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 65ab9e9..c863aa1 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -612,7 +612,7 @@ unsigned long long sched_clock(void)
 static int __init get_freq(char *name, int cells, unsigned long *val)
 {
 	struct device_node *cpu;
-	const unsigned int *fp;
+	const __be32 *fp;
 	int found = 0;
 
 	/* The cpu node should have timebase and clock frequency properties */
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 7cd728b..9dee470 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -216,7 +216,7 @@ static int __init icp_native_init_one_node(struct device_node *np,
 					   unsigned int *indx)
 {
 	unsigned int ilen;
-	const u32 *ireg;
+	const __be32 *ireg;
 	int i;
 	int reg_tuple_size;
 	int num_servers = 0;
-- 
1.8.1.2

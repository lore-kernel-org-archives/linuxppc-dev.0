Return-Path: <geoff@infradead.org>
Message-Id: <9e1456da4e841f30b5fb35005ebf5c27281cccc9.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 7/8] powerpc/ps3: Add __init to ps3_smp_probe
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:50 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an __init annotation to the ps3_smp_probe() routine.
Fixes build warnings like these when
CONFIG_DEBUG_SECTION_MISMATCH=y:

 WARNING: Section mismatch in reference from the function .ps3_smp_probe()

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index efc1cd8..4b35166 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -57,7 +57,7 @@ static void ps3_smp_message_pass(int cpu, int msg)
 			" (%d)\n", __func__, __LINE__, cpu, msg, result);
 }
 
-static int ps3_smp_probe(void)
+static int __init ps3_smp_probe(void)
 {
 	int cpu;
 
-- 
1.7.0.4

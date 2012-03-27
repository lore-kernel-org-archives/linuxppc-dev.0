Return-Path: <B16395@freescale.com>
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <Linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL
 MPIC.
Date: Tue, 27 Mar 2012 17:45:57 +0530
Message-ID: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL MPIC supports 16 bit vectors so our vector number space isn't
restricted to 256 vectors. We should use the MPIC_LARG_VECTORS flag
while intializing the MPIC. This also prevents us from eating in to 
hardware vector number space (MSIs) while setting up internal sources.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8be1ea2..33520dd 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1191,7 +1191,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	if (of_get_property(node, "single-cpu-affinity", NULL))
 		flags |= MPIC_SINGLE_DEST_CPU;
 	if (of_device_is_compatible(node, "fsl,mpic"))
-		flags |= MPIC_FSL;
+		flags |= MPIC_FSL | MPIC_LARGE_VECTORS;
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
-- 
1.7.2.2

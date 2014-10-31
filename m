Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19B211A05FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 14:47:32 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ulrich.weigand@de.ibm.com
Subject: [PATCH 3/3] powerpc: LLVM complains about forward declaration of
 struct rtas_sensors
Date: Fri, 31 Oct 2014 14:47:27 +1100
Message-Id: <1414727247-31838-3-git-send-email-anton@samba.org>
In-Reply-To: <1414727247-31838-1-git-send-email-anton@samba.org>
References: <1414727247-31838-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the declaration up to silence the warning.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/rtas-proc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index 8777fb0..fb2fb3e 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -113,17 +113,6 @@
 #define SENSOR_PREFIX		"ibm,sensor-"
 #define cel_to_fahr(x)		((x*9/5)+32)
 
-
-/* Globals */
-static struct rtas_sensors sensors;
-static struct device_node *rtas_node = NULL;
-static unsigned long power_on_time = 0; /* Save the time the user set */
-static char progress_led[MAX_LINELENGTH];
-
-static unsigned long rtas_tone_frequency = 1000;
-static unsigned long rtas_tone_volume = 0;
-
-/* ****************STRUCTS******************************************* */
 struct individual_sensor {
 	unsigned int token;
 	unsigned int quant;
@@ -134,6 +123,15 @@ struct rtas_sensors {
 	unsigned int quant;
 };
 
+/* Globals */
+static struct rtas_sensors sensors;
+static struct device_node *rtas_node = NULL;
+static unsigned long power_on_time = 0; /* Save the time the user set */
+static char progress_led[MAX_LINELENGTH];
+
+static unsigned long rtas_tone_frequency = 1000;
+static unsigned long rtas_tone_volume = 0;
+
 /* ****************************************************************** */
 /* Declarations */
 static int ppc_rtas_sensors_show(struct seq_file *m, void *v);
-- 
1.9.1

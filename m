Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7A1BCDDF41
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:27:43 +1000 (EST)
Message-ID: <4818F1CE.8040807@am.sony.com>
Date: Wed, 30 Apr 2008 15:25:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 3/5] PS3: Make ps3_virq_setup and ps3_virq_destroy static
References: <20080430215644.655638516@am.sony.com>
In-Reply-To: <20080430215644.655638516@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

The routines ps3_virq_setup() and ps3_virq_destroy() are used
in only one file, so make them static.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |    6 +++---
 include/asm-powerpc/ps3.h              |    3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -167,8 +167,8 @@ static struct irq_chip ps3_irq_chip = {
  * ps3_private data.
  */
 
-int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
-	unsigned int *virq)
+static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
+			  unsigned int *virq)
 {
 	int result;
 	struct ps3_private *pd;
@@ -217,7 +217,7 @@ fail_create:
  * Clears chip data and calls irq_dispose_mapping() for the virq.
  */
 
-int ps3_virq_destroy(unsigned int virq)
+static int ps3_virq_destroy(unsigned int virq)
 {
 	const struct ps3_private *pd = get_irq_chip_data(virq);
 
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -178,9 +178,6 @@ enum ps3_cpu_binding {
 	PS3_BINDING_CPU_1 = 1,
 };
 
-int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
-	unsigned int *virq);
-int ps3_virq_destroy(unsigned int virq);
 int ps3_irq_plug_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	unsigned int *virq);
 int ps3_irq_plug_destroy(unsigned int virq);

-- 

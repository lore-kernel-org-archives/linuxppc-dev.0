Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 76CC4DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 06:14:31 +1100 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] check for GIQ indicator before calling set-indicator
Date: Thu, 11 Dec 2008 13:14:25 -0600
Message-Id: <1229022865-14993-1-git-send-email-ntl@pobox.com>
In-Reply-To: <c5d656532783550a8b21bb027497160a@bga.com>
References: <c5d656532783550a8b21bb027497160a@bga.com>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since "Factor out cpu joining/unjoining the GIQ"
(b4963255ad5a426f04a0bb15c4315fa4bb40cde9) the WARN_ON in
xics_set_cpu_giq() is being triggered during boot on JS20 because the
GIQ indicator is not available on that platform.  While the warning is
harmless and the system runs normally, it's nicer to check for the
existence of the indicator before trying to manipulate it.

Implement rtas_indicator_present(), which searches the
/rtas/rtas-indicators property for the given indicator token, and use
this function in xics_set_cpu_giq().

Also use a WARN statement in xics_set_cpu_giq to get better
information on failure.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/include/asm/rtas.h       |    1 +
 arch/powerpc/kernel/rtas.c            |   26 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/xics.c |   15 ++++++++++++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 8eaa7b2..e0175be 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -168,6 +168,7 @@ extern void rtas_os_term(char *str);
 extern int rtas_get_sensor(int sensor, int index, int *state);
 extern int rtas_get_power_level(int powerdomain, int *level);
 extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
+extern bool rtas_indicator_present(int token, int *maxindex);
 extern int rtas_set_indicator(int indicator, int index, int new_value);
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 1f8505c..fdfe14c 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -566,6 +566,32 @@ int rtas_get_sensor(int sensor, int index, int *state)
 }
 EXPORT_SYMBOL(rtas_get_sensor);
 
+bool rtas_indicator_present(int token, int *maxindex)
+{
+	int proplen, count, i;
+	const struct indicator_elem {
+		u32 token;
+		u32 maxindex;
+	} *indicators;
+
+	indicators = of_get_property(rtas.dev, "rtas-indicators", &proplen);
+	if (!indicators)
+		return false;
+
+	count = proplen / sizeof(struct indicator_elem);
+
+	for (i = 0; i < count; i++) {
+		if (indicators[i].token != token)
+			continue;
+		if (maxindex)
+			*maxindex = indicators[i].maxindex;
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(rtas_indicator_present);
+
 int rtas_set_indicator(int indicator, int index, int new_value)
 {
 	int token = rtas_token("set-indicator");
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index e190477..37f5986 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -728,9 +728,18 @@ static void xics_set_cpu_priority(unsigned char cppr)
 /* Have the calling processor join or leave the specified global queue */
 static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
 {
-	int status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - gserver, join);
-	WARN_ON(status < 0);
+	int index;
+	int status;
+
+	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE, NULL))
+		return;
+
+	index = (1UL << interrupt_server_size) - 1 - gserver;
+
+	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE, index, join);
+
+	WARN(status < 0, "set-indicator(%d, %d, %u) returned %d\n",
+	     GLOBAL_INTERRUPT_QUEUE, index, join, status);
 }
 
 void xics_setup_cpu(void)
-- 
1.5.5

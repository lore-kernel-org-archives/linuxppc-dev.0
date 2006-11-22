Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:23 +1100
Subject: [PATCH 1/9] Fix sparse warning in xmon Cell code
In-Reply-To: <1164182122.302443.256192350213.qpush@cradle>
Message-Id: <20061122075528.915C767C4B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My patch to add spu helpers to xmon (a898497088f46252e6750405504064e2dce53117)
introduced a few sparse warnings, because I was dereferencing an __iomem
pointer.

I think the best way to handle it is to actually use the appropriate in_beXX
functions. Need to rejigger the DUMP macro a little to accomodate that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/xmon/xmon.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -2746,13 +2746,13 @@ static void restart_spus(void)
 }
 
 #define DUMP_WIDTH	23
-#define DUMP_FIELD(obj, format, field)					\
+#define DUMP_VALUE(format, field, value)				\
 do {									\
 	if (setjmp(bus_error_jmp) == 0) {				\
 		catch_memory_errors = 1;				\
 		sync();							\
 		printf("  %-*s = "format"\n", DUMP_WIDTH,		\
-				#field, obj->field);			\
+				#field, value);				\
 		sync();							\
 		__delay(200);						\
 	} else {							\
@@ -2763,6 +2763,9 @@ do {									\
 	catch_memory_errors = 0;					\
 } while (0)
 
+#define DUMP_FIELD(obj, format, field)	\
+	DUMP_VALUE(format, field, obj->field)
+
 static void dump_spu_fields(struct spu *spu)
 {
 	printf("Dumping spu fields at address %p:\n", spu);
@@ -2791,13 +2794,18 @@ static void dump_spu_fields(struct spu *
 	DUMP_FIELD(spu, "0x%p", timestamp);
 	DUMP_FIELD(spu, "0x%lx", problem_phys);
 	DUMP_FIELD(spu, "0x%p", problem);
-	DUMP_FIELD(spu, "0x%x", problem->spu_runcntl_RW);
-	DUMP_FIELD(spu, "0x%x", problem->spu_status_R);
-	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
+	DUMP_VALUE("0x%x", problem->spu_runcntl_RW,
+			in_be32(&spu->problem->spu_runcntl_RW));
+	DUMP_VALUE("0x%x", problem->spu_status_R,
+			in_be32(&spu->problem->spu_status_R));
+	DUMP_VALUE("0x%x", problem->spu_npc_RW,
+			in_be32(&spu->problem->spu_npc_RW));
 	DUMP_FIELD(spu, "0x%p", priv1);
 
-	if (spu->priv1)
-		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
+	if (spu->priv1) {
+		DUMP_VALUE("0x%lx", priv1->mfc_sr1_RW,
+				in_be64(&spu->priv1->mfc_sr1_RW));
+	}
 
 	DUMP_FIELD(spu, "0x%p", priv2);
 }

Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 13/20] powerpc/xmon: Use start/end_bus_error_jump() in more
 routines
Date: Wed, 10 Oct 2012 01:20:40 +1100
Message-Id: <1349792447-15714-13-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are not entirely equivalent to the old code. In most cases they
just gain a call to __delay() via end_bus_error_jump().

In symbol_lookup() we also move the printf() outside the protected area,
this should be safe as we are not derefencing the value we lookup, just
printing its value.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 45be9ce..ddae5cf 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1321,17 +1321,16 @@ static void get_function_bounds(unsigned long pc, unsigned long *startp,
 	*startp = *endp = 0;
 	if (pc == 0)
 		return;
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+
+	if (start_bus_error_jump() == 0) {
 		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
 		if (name != NULL) {
 			*startp = pc - offset;
 			*endp = pc - offset + size;
 		}
-		sync();
+
+		end_bus_error_jump();
 	}
-	catch_memory_errors = 0;
 }
 
 #define LRSAVE_OFFSET		(STACK_FRAME_LR_SAVE * sizeof(unsigned long))
@@ -2016,14 +2015,11 @@ static void dump_one_paca(int cpu)
 {
 	struct paca_struct *p;
 
-	if (setjmp(bus_error_jmp) != 0) {
+	if (start_bus_error_jump() != 0) {
 		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
 		return;
 	}
 
-	catch_memory_errors = 1;
-	sync();
-
 	p = &paca[cpu];
 
 	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
@@ -2063,8 +2059,7 @@ static void dump_one_paca(int cpu)
 
 #undef DUMP
 
-	catch_memory_errors = 0;
-	sync();
+	end_bus_error_jump();
 }
 
 static void dump_all_pacas(void)
@@ -2402,17 +2397,14 @@ static void proccall(void)
 	}
 	func = (callfunc_t) adrs;
 	ret = 0;
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+	if (start_bus_error_jump() == 0) {
 		ret = func(args[0], args[1], args[2], args[3],
 			   args[4], args[5], args[6], args[7]);
-		sync();
+		end_bus_error_jump();
 		printf("return value is %x\n", ret);
 	} else {
 		printf("*** %x exception occurred\n", fault_except);
 	}
-	catch_memory_errors = 0;
 }
 
 /* Input scanning routines */
@@ -2507,13 +2499,10 @@ scanhex(unsigned long *vp)
 		}
 		tmpstr[i++] = 0;
 		*vp = 0;
-		if (setjmp(bus_error_jmp) == 0) {
-			catch_memory_errors = 1;
-			sync();
+		if (start_bus_error_jump() == 0) {
 			*vp = kallsyms_lookup_name(tmpstr);
-			sync();
+			end_bus_error_jump();
 		}
-		catch_memory_errors = 0;
 		if (!(*vp)) {
 			printf("unknown symbol '%s'\n", tmpstr);
 			return 0;
@@ -2620,17 +2609,15 @@ symbol_lookup(void)
 		break;
 	case 's':
 		getstring(tmp, 64);
-		if (setjmp(bus_error_jmp) == 0) {
-			catch_memory_errors = 1;
-			sync();
+		if (start_bus_error_jump() == 0) {
 			addr = kallsyms_lookup_name(tmp);
+			end_bus_error_jump();
+
 			if (addr)
 				printf("%s: %lx\n", tmp, addr);
 			else
 				printf("Symbol '%s' not found.\n", tmp);
-			sync();
 		}
-		catch_memory_errors = 0;
 		termch = 0;
 		break;
 	}
-- 
1.7.9.5

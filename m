Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 12/20] powerpc/xmon: Do so simple conversions to
 start/end_bus_error_jump()
Date: Wed, 10 Oct 2012 01:20:39 +1100
Message-Id: <1349792447-15714-12-git-send-email-michael@ellerman.id.au>
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

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   79 +++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 65c3d22..45be9ce 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1503,19 +1503,14 @@ static void prregs(struct pt_regs *fp)
 	struct pt_regs regs;
 
 	if (scanhex(&base)) {
-		if (setjmp(bus_error_jmp) == 0) {
-			catch_memory_errors = 1;
-			sync();
+		if (start_bus_error_jump() == 0) {
 			regs = *(struct pt_regs *)base;
-			sync();
-			__delay(200);
+			end_bus_error_jump();
 		} else {
-			catch_memory_errors = 0;
 			printf("*** Error reading registers from "REG"\n",
 			       base);
 			return;
 		}
-		catch_memory_errors = 0;
 		fp = &regs;
 	}
 
@@ -1569,10 +1564,7 @@ static void cacheflush(void)
 	nflush = 1;
 	scanhex(&nflush);
 	nflush = (nflush + L1_CACHE_BYTES - 1) / L1_CACHE_BYTES;
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
-
+	if (start_bus_error_jump() == 0) {
 		if (cmd != 'i') {
 			for (; nflush > 0; --nflush, adrs += L1_CACHE_BYTES)
 				cflush((void *) adrs);
@@ -1580,11 +1572,9 @@ static void cacheflush(void)
 			for (; nflush > 0; --nflush, adrs += L1_CACHE_BYTES)
 				cinval((void *) adrs);
 		}
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+
+		end_bus_error_jump();
 	}
-	catch_memory_errors = 0;
 }
 
 static unsigned long
@@ -1710,9 +1700,7 @@ mread(unsigned long adrs, void *buf, int size)
 	char *p, *q;
 
 	n = 0;
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+	if (start_bus_error_jump() == 0) {
 		p = (char *)adrs;
 		q = (char *)buf;
 		switch (size) {
@@ -1731,12 +1719,9 @@ mread(unsigned long adrs, void *buf, int size)
 				sync();
 			}
 		}
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		end_bus_error_jump();
 		n = size;
 	}
-	catch_memory_errors = 0;
 	return n;
 }
 
@@ -1747,9 +1732,7 @@ mwrite(unsigned long adrs, void *buf, int size)
 	char *p, *q;
 
 	n = 0;
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+	if (start_bus_error_jump() == 0) {
 		p = (char *) adrs;
 		q = (char *) buf;
 		switch (size) {
@@ -1768,14 +1751,11 @@ mwrite(unsigned long adrs, void *buf, int size)
 				sync();
 			}
 		}
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		end_bus_error_jump();
 		n = size;
 	} else {
 		printf("*** Error writing address %x\n", adrs + n);
 	}
-	catch_memory_errors = 0;
 	return n;
 }
 
@@ -2272,24 +2252,18 @@ dump_log_buf(void)
 	unsigned char buf[128];
 	size_t len;
 
-	if (setjmp(bus_error_jmp) != 0) {
+	if (start_bus_error_jump() != 0) {
 		printf("Error dumping printk buffer!\n");
 		return;
 	}
 
-	catch_memory_errors = 1;
-	sync();
-
 	kmsg_dump_rewind_nolock(&dumper);
 	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
 
-	sync();
-	/* wait a little while to see if we get a machine check */
-	__delay(200);
-	catch_memory_errors = 0;
+	end_bus_error_jump();
 }
 
 /*
@@ -2672,18 +2646,12 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 	unsigned long offset, size;
 
 	printf(REG, address);
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+	if (start_bus_error_jump() == 0) {
 		name = kallsyms_lookup(address, &size, &offset, &modname,
 				       tmpstr);
-		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
+		end_bus_error_jump();
 	}
 
-	catch_memory_errors = 0;
-
 	if (name) {
 		printf("%s%s+%#lx/%#lx", mid, name, offset, size);
 		if (modname)
@@ -3123,19 +3091,13 @@ static void restart_spus(void)
 #define DUMP_WIDTH	23
 #define DUMP_VALUE(format, field, value)				\
 do {									\
-	if (setjmp(bus_error_jmp) == 0) {				\
-		catch_memory_errors = 1;				\
-		sync();							\
+	if (start_bus_error_jump() == 0) {				\
 		printf("  %-*s = "format"\n", DUMP_WIDTH,		\
 				#field, value);				\
-		sync();							\
-		__delay(200);						\
-	} else {							\
-		catch_memory_errors = 0;				\
+		end_bus_error_jump();					\
+	} else								\
 		printf("  %-*s = *** Error reading field.\n",		\
 					DUMP_WIDTH, #field);		\
-	}								\
-	catch_memory_errors = 0;					\
 } while (0)
 
 #define DUMP_FIELD(obj, format, field)	\
@@ -3187,18 +3149,13 @@ static void dump_spu_ls(unsigned long num, int subcmd)
 {
 	unsigned long offset, addr, ls_addr;
 
-	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
-		sync();
+	if (start_bus_error_jump() == 0) {
 		ls_addr = (unsigned long)spu_info[num].spu->local_store;
-		sync();
-		__delay(200);
+		end_bus_error_jump();
 	} else {
-		catch_memory_errors = 0;
 		printf("*** Error: accessing spu info for spu %d\n", num);
 		return;
 	}
-	catch_memory_errors = 0;
 
 	if (scanhex(&offset))
 		addr = ls_addr + offset;
-- 
1.7.9.5

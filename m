Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Fixup whitespace in xmon
Date: Fri, 24 Aug 2012 18:09:13 +1000
Message-Id: <1345795753-2881-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1345795753-2881-1-git-send-email-michael@ellerman.id.au>
References: <1345795753-2881-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a few whitespace goolies in xmon.c, some of them appear to
be my fault. Fix them all in one go.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 013f286..9b49c65 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -895,13 +895,13 @@ cmds(struct pt_regs *excp)
 #endif
 		default:
 			printf("Unrecognized command: ");
-		        do {
+			do {
 				if (' ' < cmd && cmd <= '~')
 					putchar(cmd);
 				else
 					printf("\\x%x", cmd);
 				cmd = inchar();
-		        } while (cmd != '\n'); 
+			} while (cmd != '\n');
 			printf(" (type ? for help)\n");
 			break;
 		}
@@ -1098,7 +1098,7 @@ static long check_bp_loc(unsigned long addr)
 	return 1;
 }
 
-static char *breakpoint_help_string = 
+static char *breakpoint_help_string =
     "Breakpoint command usage:\n"
     "b                show breakpoints\n"
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
@@ -1194,7 +1194,7 @@ bpt_cmds(void)
 
 	default:
 		termch = cmd;
-	        cmd = skipbl();
+		cmd = skipbl();
 		if (cmd == '?') {
 			printf(breakpoint_help_string);
 			break;
@@ -1360,7 +1360,7 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 				       sp + REGS_OFFSET);
 				break;
 			}
-                        printf("--- Exception: %lx %s at ", regs.trap,
+			printf("--- Exception: %lx %s at ", regs.trap,
 			       getvecname(TRAP(&regs)));
 			pc = regs.nip;
 			lr = regs.link;
@@ -1624,14 +1624,14 @@ static void super_regs(void)
 
 	cmd = skipbl();
 	if (cmd == '\n') {
-	        unsigned long sp, toc;
+		unsigned long sp, toc;
 		asm("mr %0,1" : "=r" (sp) :);
 		asm("mr %0,2" : "=r" (toc) :);
 
 		printf("msr  = "REG"  sprg0= "REG"\n",
 		       mfmsr(), mfspr(SPRN_SPRG0));
 		printf("pvr  = "REG"  sprg1= "REG"\n",
-		       mfspr(SPRN_PVR), mfspr(SPRN_SPRG1)); 
+		       mfspr(SPRN_PVR), mfspr(SPRN_SPRG1));
 		printf("dec  = "REG"  sprg2= "REG"\n",
 		       mfspr(SPRN_DEC), mfspr(SPRN_SPRG2));
 		printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
@@ -1784,7 +1784,7 @@ byterev(unsigned char *val, int size)
 static int brev;
 static int mnoread;
 
-static char *memex_help_string = 
+static char *memex_help_string =
     "Memory examine command usage:\n"
     "m [addr] [flags] examine/change memory\n"
     "  addr is optional.  will start where left off.\n"
@@ -1799,7 +1799,7 @@ static char *memex_help_string =
     "NOTE: flags are saved as defaults\n"
     "";
 
-static char *memex_subcmd_help_string = 
+static char *memex_subcmd_help_string =
     "Memory examine subcommands:\n"
     "  hexval   write this val to current location\n"
     "  'string' write chars from string to this location\n"
@@ -2065,7 +2065,7 @@ prdump(unsigned long adrs, long ndump)
 		nr = mread(adrs, temp, r);
 		adrs += nr;
 		for (m = 0; m < r; ++m) {
-		        if ((m & (sizeof(long) - 1)) == 0 && m > 0)
+			if ((m & (sizeof(long) - 1)) == 0 && m > 0)
 				putchar(' ');
 			if (m < nr)
 				printf("%.2x", temp[m]);
@@ -2073,7 +2073,7 @@ prdump(unsigned long adrs, long ndump)
 				printf("%s", fault_chars[fault_type]);
 		}
 		for (; m < 16; ++m) {
-		        if ((m & (sizeof(long) - 1)) == 0)
+			if ((m & (sizeof(long) - 1)) == 0)
 				putchar(' ');
 			printf("  ");
 		}
@@ -2153,13 +2153,13 @@ dump_log_buf(void)
 	unsigned char buf[128];
 	size_t len;
 
-        if (setjmp(bus_error_jmp) != 0) {
+	if (setjmp(bus_error_jmp) != 0) {
 		printf("Error dumping printk buffer!\n");
-                return;
-        }
+		return;
+	}
 
-        catch_memory_errors = 1;
-        sync();
+	catch_memory_errors = 1;
+	sync();
 
 	kmsg_dump_rewind_nolock(&dumper);
 	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
@@ -2167,10 +2167,10 @@ dump_log_buf(void)
 		printf("%s", buf);
 	}
 
-        sync();
-        /* wait a little while to see if we get a machine check */
-        __delay(200);
-        catch_memory_errors = 0;
+	sync();
+	/* wait a little while to see if we get a machine check */
+	__delay(200);
+	catch_memory_errors = 0;
 }
 
 /*
-- 
1.7.9.5

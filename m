Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 17/20] powerpc/xmon: Make less variables global
Date: Wed, 10 Oct 2012 01:20:44 +1100
Message-Id: <1349792447-15714-17-git-send-email-michael@ellerman.id.au>
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

Move a number of variables into their only user, reducing some of the
global variable clutter. They remain static, so their behaviour across
calls is unchanged.

Also use ARRAY_SIZE for regnames in scanhex().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index abc89a4..c6cd027 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -64,11 +64,7 @@ static int xmon_gate;
 static unsigned long in_xmon __read_mostly = 0;
 
 static unsigned long adrs;
-static int size = 1;
 #define MAX_DUMP (128 * 1024)
-static unsigned long ndump = 64;
-static unsigned long nidump = 16;
-static unsigned long ncsum = 4096;
 static int termch;
 static char tmpstr[128];
 
@@ -1109,6 +1105,7 @@ static unsigned short fcstab[256] = {
 static void
 csum(void)
 {
+	static unsigned long ncsum = 4096;
 	unsigned int i;
 	unsigned short fcs;
 	unsigned char v;
@@ -1634,12 +1631,12 @@ write_spr(int n, unsigned long val)
 	}
 }
 
-static unsigned long regno;
 extern char exc_prolog;
 extern char dec_exc;
 
 static void super_regs(void)
 {
+	static unsigned long regno;
 	int cmd;
 	unsigned long val;
 
@@ -1768,9 +1765,6 @@ byterev(unsigned char *val, int size)
 	}
 }
 
-static int brev;
-static int mnoread;
-
 static char *memex_help_string =
     "Memory examine command usage:\n"
     "m [addr] [flags] examine/change memory\n"
@@ -1811,6 +1805,7 @@ static char *memex_subcmd_help_string =
 static void
 memex(void)
 {
+	static int mnoread, brev, size = 1;
 	int cmd, inc, i, nslash;
 	unsigned long n;
 	unsigned char val[16];
@@ -2087,6 +2082,8 @@ static void dump_pacas(void)
 static void
 dump(void)
 {
+	static unsigned long ndump = 64;
+	static unsigned long nidump = 16;
 	int c;
 
 	c = inchar();
@@ -2253,12 +2250,13 @@ dump_log_buf(void)
 static unsigned long mdest;		/* destination address */
 static unsigned long msrc;		/* source address */
 static unsigned long mval;		/* byte value to set memory to */
-static unsigned long mcount;		/* # bytes to affect */
-static unsigned long mdiffs;		/* max # differences to print */
 
 static void
 memops(int cmd)
 {
+	static unsigned long mcount;		/* # bytes to affect */
+	static unsigned long mdiffs;		/* max # differences to print */
+
 	scanhex((void *)&mdest);
 	if( termch != '\n' )
 		termch = 0;
@@ -2297,12 +2295,12 @@ memdiffs(unsigned char *p1, unsigned char *p2, unsigned nb, unsigned maxpr)
 		printf("Total of %d differences\n", prt);
 }
 
-static unsigned mend;
-static unsigned mask;
-
 static void
 memlocate(void)
 {
+	static unsigned mend;
+	static unsigned mask;
+
 	unsigned a, n;
 	unsigned char val[4];
 
@@ -2330,12 +2328,11 @@ memlocate(void)
 	}
 }
 
-static unsigned long mskip = 0x1000;
-static unsigned long mlim = 0xffffffff;
-
 static void
 memzcan(void)
 {
+	static unsigned long mskip = 0x1000;
+	static unsigned long mlim = 0xffffffff;
 	unsigned char v;
 	unsigned a;
 	int ok, ook;
@@ -2409,8 +2406,10 @@ skipbl(void)
 	return c;
 }
 
-#define N_PTREGS	44
-static char *regnames[N_PTREGS] = {
+int
+scanhex(unsigned long *vp)
+{
+	static char *regnames[] = {
 	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
 	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
 	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
@@ -2422,11 +2421,7 @@ static char *regnames[N_PTREGS] = {
 	"mq",
 #endif
 	"trap", "dar", "dsisr", "res"
-};
-
-int
-scanhex(unsigned long *vp)
-{
+	};
 	int c, d;
 	unsigned long v;
 
@@ -2445,7 +2440,7 @@ scanhex(unsigned long *vp)
 			regname[i] = c;
 		}
 		regname[i] = 0;
-		for (i = 0; i < N_PTREGS; ++i) {
+		for (i = 0; i < ARRAY_SIZE(regnames); ++i) {
 			if (strcmp(regnames[i], regname) == 0) {
 				if (xmon_regs == NULL) {
 					printf("regs not available\n");
@@ -2551,7 +2546,6 @@ getstring(char *s, int size)
 	*s = 0;
 }
 
-static char line[256];
 static char *lineptr;
 
 static void
@@ -2563,6 +2557,8 @@ flush_input(void)
 static int
 inchar(void)
 {
+	static char line[256];
+
 	if (lineptr == NULL || *lineptr == 0) {
 		if (xmon_gets(line, sizeof(line)) == NULL) {
 			lineptr = NULL;
-- 
1.7.9.5

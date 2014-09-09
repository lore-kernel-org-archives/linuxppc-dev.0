Return-Path: <simon.kagstrom@netinsight.net>
Received: from ernst.netinsight.se (ernst.netinsight.se [194.16.221.21])
 by lists.ozlabs.org (Postfix) with SMTP id 825EB1A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 00:11:50 +1000 (EST)
Date: Tue, 9 Sep 2014 16:01:27 +0200
From: Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?= <simon.kagstrom@netinsight.net>
To: linuxppc-dev@lists.ozlabs.org, grant.likely@linaro.org,
 scottwood@freescale.com, geert@linux-m68k.org
Subject: [PATCH / RFC] PowerPC: boot: Parse chosen/cmdline-timeout parameter
Message-ID: <20140909160127.671fef38@marrow.netinsight.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A 5 second timeout during boot might be too long, so make it
configurable.

The property is added to the chosen node, e.g.,

	chosen {
		bootargs = "console=ttyUL0 root=/dev/ram0";
		linux,stdout-path = "/plb@0/serial@46000000";
		cmdline-timeout = <100>;
	} ;


Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---

We build a simpleImage for a Virtex 4 PPC405 target, and the
delay-for-command-line-edits is a significant part of the total boot
time.

Questions (apart from the patch in general):

- Should the property be in the chosen node?

- Naming of the property?

Thanks,
// Simon


 arch/powerpc/boot/main.c   |   11 ++++++++++-
 arch/powerpc/boot/ops.h    |    2 +-
 arch/powerpc/boot/serial.c |    4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index a28f021..2fb3184 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -144,13 +144,22 @@ static char cmdline[COMMAND_LINE_SIZE]
 
 static void prep_cmdline(void *chosen)
 {
+	unsigned int getline_timeout = 5000;
+	int v;
+	int n;
+
+	/* Wait-for-input time */
+	n = getprop(chosen, "cmdline-timeout", &v, sizeof(v));
+	if (n == sizeof(v))
+		getline_timeout = v;
+
 	if (cmdline[0] == '\0')
 		getprop(chosen, "bootargs", cmdline, COMMAND_LINE_SIZE-1);
 
 	printf("\n\rLinux/PowerPC load: %s", cmdline);
 	/* If possible, edit the command line */
 	if (console_ops.edit_cmdline)
-		console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE);
+		console_ops.edit_cmdline(cmdline, COMMAND_LINE_SIZE, getline_timeout);
 	printf("\n\r");
 
 	/* Put the command line back into the devtree for the kernel */
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index b3218ce..c42ea70 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -58,7 +58,7 @@ extern struct dt_ops dt_ops;
 struct console_ops {
 	int	(*open)(void);
 	void	(*write)(const char *buf, int len);
-	void	(*edit_cmdline)(char *buf, int len);
+	void	(*edit_cmdline)(char *buf, int len, unsigned int getline_timeout);
 	void	(*close)(void);
 	void	*data;
 };
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index f2156f0..6daec2f 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -33,7 +33,7 @@ static void serial_write(const char *buf, int len)
 		scdp->putc(*buf++);
 }
 
-static void serial_edit_cmdline(char *buf, int len)
+static void serial_edit_cmdline(char *buf, int len, unsigned int timeout)
 {
 	int timer = 0, count;
 	char ch, *cp;
@@ -44,7 +44,7 @@ static void serial_edit_cmdline(char *buf, int len)
 	cp = &buf[count];
 	count++;
 
-	while (timer++ < 5*1000) {
+	while (timer++ < timeout) {
 		if (scdp->tstc()) {
 			while (((ch = scdp->getc()) != '\n') && (ch != '\r')) {
 				/* Test for backspace/delete */
-- 
1.7.9.6

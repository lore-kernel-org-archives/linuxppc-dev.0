Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F02551A05AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 13:33:43 +1100 (AEDT)
Message-ID: <1444876423.5970.2.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Paged output for paca display
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, khandual@linux.vnet.ibm.com
Date: Thu, 15 Oct 2015 13:33:43 +1100
In-Reply-To: <20151014222438.GA1900@tungsten.ozlabs.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
 <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
 <1444815549.1843.4.camel@ellerman.id.au>
 <20151014222438.GA1900@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-15 at 09:24 +1100, Sam Bobroff wrote:
> On Wed, Oct 14, 2015 at 08:39:09PM +1100, Michael Ellerman wrote:
> > On Thu, 2015-10-08 at 11:50 +1100, Sam Bobroff wrote:
> > > The paca display is already more than 24 lines, which can be problematic
> > > if you have an old school 80x24 terminal, or more likely you are on a
> > > virtual terminal which does not scroll for whatever reason.
> > > 
> > > This patch adds a new command ".", which takes a single (hex) numeric
> > > argument: lines per page. It will cause the output of "dp" and "dpa"
> > > to be broken into pages, if necessary.
> > > 
> > > Sample output:
> > > 
> > > 0:mon> .10
> > 
> > So what about making it "#" rather than "." ?
> > 
> > cheers
> 
> Sure, although we'll have to do a better job than the other commands in the help text ;-)
> (They use "#" to indicate a hex number and "##" is just going to be confusing.)
> 
> Do you want me to respin? (I'm happy for you to just adjust the patch.)

Not that's fine I'll fix it up here.

I also converted some things to bool that could be, final patch is below.

cheers


diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
index c98748617896..d00123421e00 100644
--- a/arch/powerpc/xmon/nonstdio.c
+++ b/arch/powerpc/xmon/nonstdio.c
@@ -11,10 +11,25 @@
 #include <asm/time.h>
 #include "nonstdio.h"
 
+static bool paginating, paginate_skipping;
+static unsigned long paginate_lpp; /* Lines Per Page */
+static unsigned long paginate_pos;
 
-static int xmon_write(const void *ptr, int nb)
+void xmon_start_pagination(void)
 {
-	return udbg_write(ptr, nb);
+	paginating = true;
+	paginate_skipping = false;
+	paginate_pos = 0;
+}
+
+void xmon_end_pagination(void)
+{
+	paginating = false;
+}
+
+void xmon_set_pagination_lpp(unsigned long lpp)
+{
+	paginate_lpp = lpp;
 }
 
 static int xmon_readchar(void)
@@ -24,6 +39,51 @@ static int xmon_readchar(void)
 	return -1;
 }
 
+static int xmon_write(const char *ptr, int nb)
+{
+	int rv = 0;
+	const char *p = ptr, *q;
+	const char msg[] = "[Hit a key (a:all, q:truncate, any:next page)]";
+
+	if (nb <= 0)
+		return rv;
+
+	if (paginating && paginate_skipping)
+		return nb;
+
+	if (paginate_lpp) {
+		while (paginating && (q = strchr(p, '\n'))) {
+			rv += udbg_write(p, q - p + 1);
+			p = q + 1;
+			paginate_pos++;
+
+			if (paginate_pos >= paginate_lpp) {
+				udbg_write(msg, strlen(msg));
+
+				switch (xmon_readchar()) {
+				case 'a':
+					paginating = false;
+					break;
+				case 'q':
+					paginate_skipping = true;
+					break;
+				default:
+					/* nothing */
+					break;
+				}
+
+				paginate_pos = 0;
+				udbg_write("\r\n", 2);
+
+				if (paginate_skipping)
+					return nb;
+			}
+		}
+	}
+
+	return rv + udbg_write(p, nb - (p - ptr));
+}
+
 int xmon_putchar(int c)
 {
 	char ch = c;
diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
index 18a51ded4ffd..f8653365667e 100644
--- a/arch/powerpc/xmon/nonstdio.h
+++ b/arch/powerpc/xmon/nonstdio.h
@@ -3,6 +3,9 @@
 #define printf	xmon_printf
 #define putchar	xmon_putchar
 
+extern void xmon_set_pagination_lpp(unsigned long lpp);
+extern void xmon_start_pagination(void);
+extern void xmon_end_pagination(void);
 extern int xmon_putchar(int c);
 extern void xmon_puts(const char *);
 extern char *xmon_gets(char *, int);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 6ef1231c6e9c..f829baf45fd7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -242,6 +242,9 @@ Commands:\n\
 "  u	dump TLB\n"
 #endif
 "  ?	help\n"
+#ifdef CONFIG_PPC64
+"  # n	limit output to n lines per page (dump paca only)\n"
+#endif
 "  zr	reboot\n\
   zh	halt\n"
 ;
@@ -833,6 +836,16 @@ static void remove_cpu_bpts(void)
 	write_ciabr(0);
 }
 
+static void set_lpp_cmd(void)
+{
+	unsigned long lpp;
+
+	if (!scanhex(&lpp)) {
+		printf("Invalid number.\n");
+		lpp = 0;
+	}
+	xmon_set_pagination_lpp(lpp);
+}
 /* Command interpreting routine */
 static char *last_cmd;
 
@@ -924,6 +937,9 @@ cmds(struct pt_regs *excp)
 		case '?':
 			xmon_puts(help_string);
 			break;
+		case '#':
+			set_lpp_cmd();
+			break;
 		case 'b':
 			bpt_cmds();
 			break;
@@ -2166,7 +2182,9 @@ dump(void)
 
 #ifdef CONFIG_PPC64
 	if (c == 'p') {
+		xmon_start_pagination();
 		dump_pacas();
+		xmon_end_pagination();
 		return;
 	}
 #endif

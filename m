Return-Path: <vinay@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A791FDE0BE
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 19:17:08 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4F9CmCl023527
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 19:12:48 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4F9H7NJ1544238
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 19:17:07 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4F9H78j032467
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 19:17:07 +1000
From: Vinay Sridhar <vinay@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc64: xmon: Add dl command to dump contents of __log_buf
Date: Fri, 15 May 2009 14:43:07 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200905151443.07723.vinay@linux.vnet.ibm.com>
Cc: ellerman@au1.ibm.com, vinay@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

Quite a while back Michael Ellerman had posted a patch to add support to xmon to print the contents of the console log pointed to by __log_buf.
Here's the link to that patch - http://ozlabs.org/pipermail/linuxppc64-dev/2005-March/003657.html
I've ported the patch in the above link to 2.6.30-rc5 and have tested it. 

Thanks & regards,
Vinay

Signed-off-by: Michael Ellerman <michael at ellerman.id.au>

diff -Nuarp linux-2.6.30-rc5_orig//arch/powerpc/xmon/xmon.c linux-2.6.30-rc5/arch/powerpc/xmon/xmon.c
--- linux-2.6.30-rc5_orig//arch/powerpc/xmon/xmon.c	2009-05-15 03:06:24.000000000 -0500
+++ linux-2.6.30-rc5/arch/powerpc/xmon/xmon.c	2009-05-15 03:26:26.000000000 -0500
@@ -110,6 +110,7 @@ static int bsesc(void);
 static void dump(void);
 static void prdump(unsigned long, long);
 static int ppc_inst_dump(unsigned long, long, int);
+static void dump_log_buf(void);
 static void backtrace(struct pt_regs *);
 static void excprint(struct pt_regs *);
 static void prregs(struct pt_regs *);
@@ -197,6 +198,7 @@ Commands:\n\
   di	dump instructions\n\
   df	dump float values\n\
   dd	dump double values\n\
+  dl    dump the kernel log buffer\n\
   dr	dump stream of raw bytes\n\
   e	print exception information\n\
   f	flush cache\n\
@@ -2009,6 +2011,8 @@ dump(void)
 			nidump = MAX_DUMP;
 		adrs += ppc_inst_dump(adrs, nidump, 1);
 		last_cmd = "di\n";
+	} else if (c == 'l') {
+		dump_log_buf();
 	} else if (c == 'r') {
 		scanhex(&ndump);
 		if (ndump == 0)
@@ -2122,6 +2126,49 @@ print_address(unsigned long addr)
 	xmon_print_symbol(addr, "\t# ", "");
 }
 
+void
+dump_log_buf(void)
+{
+        const unsigned long size = 128;
+        unsigned long i, end, addr;
+        unsigned char buf[size + 1];
+
+        addr = 0;
+        buf[size] = '\0';
+
+        if (setjmp(bus_error_jmp) != 0) {
+                printf("Unable to lookup symbol __log_buf!\n");
+                return;
+        }
+
+        catch_memory_errors = 1;
+        sync();
+        addr = kallsyms_lookup_name("__log_buf");
+
+        if (! addr)
+                printf("Symbol __log_buf not found!\n");
+        else {
+                end = addr + (1 << CONFIG_LOG_BUF_SHIFT);
+                while (addr < end) {
+                        if (! mread(addr, buf, size)) {
+                                printf("Can't read memory at address 0x%lx\n", addr);
+                                break;
+                        }
+      
+                        printf("%s", buf);
+       
+                        if (strlen(buf) < size)
+                                break;
+
+                        addr += size;
+                }
+        }
+
+        sync();
+        /* wait a little while to see if we get a machine check */
+        __delay(200);
+        catch_memory_errors = 0;
+}
 
 /*
  * Memory operations - move, set, print differences

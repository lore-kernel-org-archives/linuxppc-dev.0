Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC7FFB6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 16:10:10 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 24 May 2012 11:40:02 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4O6A0Tr9175386
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 11:40:00 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4OBdmc9008740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2012 21:39:48 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] [ppc] Do not reserve cpu spin-table for crash kernel
To: kexec@lists.infradead.org
Date: Thu, 24 May 2012 11:39:45 +0530
Message-ID: <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
In-Reply-To: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
References: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: B29882@freescale.com, Simon Horman <horms@verge.net.au>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of now, the kexec reserves the spin-table for all the CPUs
on an SMP machine. The spin-table is pointed to by the 
cpu-release-addr property in the device-tree. Reserving the
spin-table in the crash kernel will cause a BUG(), if the table
lies outside the memory reserved for the crashkernel.

Disable reserving the spin-table regions and use maxcpus=1 to 
use only the crashing CPU to boot the crash kernel.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 kexec/arch/ppc/crashdump-powerpc.c |   19 +++++++++++++------
 kexec/arch/ppc/fixup_dtb.c         |    4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 1bef69b..4c8c75d 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -262,10 +262,19 @@ static void ulltoa(unsigned long long i, char *str)
 	}
 }
 
+/* Append str to cmdline */
+static void add_cmdline(char *cmdline, char *str)
+{
+	int cmdlen = strlen(cmdline) + strlen(str);
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+}
+
 static int add_cmdline_param(char *cmdline, unsigned long long addr,
 				char *cmdstr, char *byte)
 {
-	int cmdlen, len, align = 1024;
+	int align = 1024;
 	char str[COMMAND_LINE_SIZE], *ptr;
 
 	/* Passing in =xxxK / =xxxM format. Saves space required in cmdline.*/
@@ -284,11 +293,8 @@ static int add_cmdline_param(char *cmdline, unsigned long long addr,
 	ptr += strlen(str);
 	ulltoa(addr, ptr);
 	strcat(str, byte);
-	len = strlen(str);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str);
+
+	add_cmdline(cmdline, str);
 
 	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
 
@@ -365,6 +371,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 	 */
 	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
 	add_cmdline_param(mod_cmdline, saved_max_mem, " savemaxmem=", "M");
+	add_cmdline(mod_cmdline, " maxcpus=1");
 	return 0;
 }
 
diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index e9890a4..f832026 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -172,6 +172,9 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf)
 		}
 	}
 
+#if 0
+	/* XXX: Do not reserve spin-table for CPUs. */
+
 	/* Add reserve regions for cpu-release-addr */
 	nodeoffset = fdt_node_offset_by_prop_value(blob_buf, -1, "device_type", "cpu", 4);
 	while (nodeoffset != -FDT_ERR_NOTFOUND) {
@@ -201,6 +204,7 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf)
 		nodeoffset = fdt_node_offset_by_prop_value(blob_buf, nodeoffset,
 				"device_type", "cpu", 4);
 	}
+#endif
 
 out:
 	print_fdt_reserve_regions(blob_buf);

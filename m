Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBC771A1892
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 10:54:06 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 2 Oct 2014 18:54:04 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0BDFC1FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 18:42:48 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s930s2BC48103500
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 02:54:02 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s930wbLK029959
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 18:58:38 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org
Subject: [PATCH 3/3] tools/perf: Fix error reporting
Date: Thu,  2 Oct 2014 17:53:36 -0700
Message-Id: <1412297616-14179-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1412297616-14179-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1412297616-14179-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If user explicitly specifies a vmlinux or kallsyms file on the command
line and the specified file doesn't yield any symbols, print a warning
message.

	$ perf report -kallsyms
	No kernel symbols in the vmlinux 'allsyms'?
	Failed to load symbols for DSO [kernel.kallsyms], continuing
	without symbols

This could help user better recognize the typo -kallsyms v. --kallsyms.
It would also help if the user points to a stripped/invalid vmlinux or
an invalid kallsyms.

With a stripped vmlinux:

	$ perf report -k /tmp/vmlinux
	No kernel symbols in the vmlinux '/tmp/vmlinux'?
	Failed to load symbols for DSO [kernel.kallsyms], continuing
	without symbols

and with perf top

	$ perf top -k /tmp/vmlinux
	No kernel symbols in the vmlinux '/tmp/vmlinux'?
	/tmp/vmlinux with build id f43f4e78d3afac6492dcae52cd756394247997d6
	not found, continuing without symbols

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/symbol.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9b66e27..ad5baa4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1658,8 +1658,13 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map,
 	}
 
 	if (!symbol_conf.ignore_vmlinux && symbol_conf.vmlinux_name != NULL) {
-		return dso__load_vmlinux(dso, map, symbol_conf.vmlinux_name,
+		nsyms = dso__load_vmlinux(dso, map, symbol_conf.vmlinux_name,
 					 false, filter);
+		if (nsyms <= 0) {
+			pr_warning("No kernel symbols in the vmlinux '%s'?\n",
+					symbol_conf.vmlinux_name);
+		}
+		return nsyms;
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
@@ -1682,6 +1687,10 @@ do_kallsyms:
 	nsyms = dso__load_kallsyms(dso, kallsyms_filename, map, filter);
 	if (nsyms > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
+	else if (symbol_conf.kallsyms_name) {
+		pr_warning("No kernel symbols in the kallsyms '%s'?\n",
+				kallsyms_filename);
+	}
 	free(kallsyms_allocated_filename);
 
 	if (nsyms > 0 && !dso__is_kcore(dso)) {
-- 
1.8.3.1

Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MMD1bMnzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:35 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnE09143303
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:29 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29x744us6g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:28 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:21:25 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpNYc12321018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:23 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCpMdJ026772
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:23 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] kprobes: validate the symbol name length
Date: Wed, 19 Apr 2017 18:21:02 +0530
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a kprobe is being registered, we use the symbol_name field to
lookup the address where the probe should be placed. Since this is a
user-provided field, let's ensure that the length of the string is
within expected limits.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/kprobes.h     |  1 +
 kernel/kprobes.c            | 24 ++++++++++++++++++++++++
 kernel/trace/trace_kprobe.c |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1f82a3db00b1..4ee10fef5135 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -405,6 +405,7 @@ int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
 
 void dump_kprobe(struct kprobe *kp);
+bool is_valid_kprobe_symbol_name(const char *name);
 
 #else /* !CONFIG_KPROBES: */
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6a128f3a7ed1..bb86681c8a10 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long addr)
 	return false;
 }
 
+bool is_valid_kprobe_symbol_name(const char *name)
+{
+	size_t sym_len;
+	char *s;
+
+	s = strchr(name, ':');
+	if (s) {
+		sym_len = strnlen(s+1, KSYM_NAME_LEN);
+		if (sym_len <= 0 || sym_len >= KSYM_NAME_LEN)
+			return false;
+		sym_len = (size_t)(s - name);
+		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)
+			return false;
+	} else {
+		sym_len = strnlen(name, MODULE_NAME_LEN);
+		if (sym_len <= 0 || sym_len >= MODULE_NAME_LEN)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * If we have a symbol_name argument, look it up and add the offset field
  * to it. This way, we can specify a relative address to a symbol.
@@ -1397,6 +1419,8 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 		goto invalid;
 
 	if (p->symbol_name) {
+		if (!is_valid_kprobe_symbol_name(p->symbol_name))
+			return ERR_PTR(-EINVAL);
 		addr = kprobe_lookup_name(p->symbol_name, p->offset);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5f688cc724f0..bf73e5f31128 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -704,6 +704,10 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Return probe must be used without offset.\n");
 			return -EINVAL;
 		}
+		if (!is_valid_kprobe_symbol_name(symbol)) {
+			pr_info("Symbol name is too long.\n");
+			return -EINVAL;
+		}
 	}
 	argc -= 2; argv += 2;
 
-- 
2.12.1

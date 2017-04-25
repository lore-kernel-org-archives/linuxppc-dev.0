Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC7hV0MtyzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:19:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PGIxUd140373
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:19:24 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a24a4gpuu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:19:24 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 02:19:22 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PGJBAC1376584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:19:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PGIfIO018065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:18:42 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Paul Clarke <pc@us.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
Date: Tue, 25 Apr 2017 21:48:22 +0530
Message-Id: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. Fail early for invalid/zero length symbols.
2. Detect names of the form <mod:name> and skip checking for kernel
symbols in that case.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Masami, Michael,
I have added two very simple checks here, which I felt is good to have,
rather than the elaborate checks in the previous version. Given the
change in module code to use strnchr(), the checks are now safe and
further tests are not probably not that useful.

- Naveen

 kernel/kallsyms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 6a3b249a2ae1..d134b060564f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -205,6 +205,12 @@ unsigned long kallsyms_lookup_name(const char *name)
 	unsigned long i;
 	unsigned int off;
 
+	if (!name || *name == '\0')
+		return false;
+
+	if (strnchr(name, MODULE_NAME_LEN, ':'))
+		return module_kallsyms_lookup_name(name);
+
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 
-- 
2.12.1

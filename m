Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MMM2kJfzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:43 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnFFk138870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:30 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x760un1r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:30 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:21:27 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpJ5i16515114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:19 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCpNgS026785
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] powerpc: kprobes: use safer string functions in
 kprobe_lookup_name()
Date: Wed, 19 Apr 2017 18:21:03 +0530
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <d8a1de28324a2350483a961be078a6343111632b.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert usage of strncpy()/strncat() to memcpy()/strlcat() for simpler
and safer string manipulation.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 97b5eed1f76d..d743bacefa8c 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -69,24 +69,23 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 		modsym++;
 		if (*modsym != '\0' && *modsym != '.') {
 			/* Convert to <module:.symbol> */
-			strncpy(dot_name, name, modsym - name);
+			memcpy(dot_name, name, modsym - name);
 			dot_name[modsym - name] = '.';
 			dot_name[modsym - name + 1] = '\0';
-			strncat(dot_name, modsym,
-				sizeof(dot_name) - (modsym - name) - 2);
+			strlcat(dot_name, modsym, sizeof(dot_name));
 			dot_appended = true;
 		} else {
 			dot_name[0] = '\0';
-			strncat(dot_name, name, sizeof(dot_name) - 1);
+			strlcat(dot_name, name, sizeof(dot_name));
 		}
 	} else if (name[0] != '.') {
 		dot_name[0] = '.';
 		dot_name[1] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 2);
+		strlcat(dot_name, name, sizeof(dot_name));
 		dot_appended = true;
 	} else {
 		dot_name[0] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 1);
+		strlcat(dot_name, name, sizeof(dot_name));
 	}
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
 	if (!addr && dot_appended) {
-- 
2.12.1

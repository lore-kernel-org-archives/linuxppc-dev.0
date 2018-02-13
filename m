Return-Path: <harish@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgXm674HnzF0sw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 17:33:04 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1D6VH6r126638
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 01:33:02 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g3sgaje3n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 01:33:02 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <harish@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 06:33:00 -0000
From: Harish <harish@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Harish <harish@linux.vnet.ibm.com>
Subject: [PATCH] selftests/powerpc: Fix: use ucontext_t instead of struct
 ucontext
Date: Tue, 13 Feb 2018 12:02:55 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1518503575-19021-1-git-send-email-harish@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With glibc 2.26 'struct ucontext' is removed to improve POSIX
compliance, which breaks powerpc/alignment_handler selftest.
Fix the test by using ucontext_t. Tested on ppc, works with older
glibc versions as well.

Fixes the following:
alignment_handler.c: In function ‘sighandler’:
alignment_handler.c:68:5: error: dereferencing pointer to incomplete type ‘struct ucontext’
  ucp->uc_mcontext.gp_regs[PT_NIP] += 4;
     ^~

Signed-off-by: Harish <harish@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/alignment/alignment_handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 39fd362..0f2698f 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -57,7 +57,7 @@ volatile int gotsig;
 
 void sighandler(int sig, siginfo_t *info, void *ctx)
 {
-	struct ucontext *ucp = ctx;
+	ucontext_t *ucp = ctx;
 
 	if (!testing) {
 		signal(sig, SIG_DFL);
-- 
2.7.4

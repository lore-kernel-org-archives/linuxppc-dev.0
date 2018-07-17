Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMC41G5hzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:44 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id c192-v6so513078qkg.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:44 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 9/9] powerpc/ptrace-pkeys: execute-permission on keys are
 disabled by default
Date: Tue, 17 Jul 2018 06:51:10 -0700
Message-Id: <1531835470-32691-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
References: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The test case assumes execute-permissions of unallocated keys are
enabled by default.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index 5cf631f..559c6cb 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -104,6 +104,11 @@ static int child(struct shared_info *info)
 
 	if (disable_execute)
 		info->expected_iamr |= 1ul << pkeyshift(pkey1);
+	else
+		info->expected_iamr &= ~(1ul << pkeyshift(pkey1));
+	info->expected_iamr &= ~(1ul << pkeyshift(pkey2) | 1ul << pkeyshift(pkey3));
+
+
 
 	info->expected_uamor |= 3ul << pkeyshift(pkey1) |
 				3ul << pkeyshift(pkey2);
-- 
1.7.1

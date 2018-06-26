Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F8mj53sRzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 12:16:37 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id l10-v6so13887433qtj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 19:16:37 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH 2/2] powerpc/ptrace-pkeys: execute-permission on keys are
 disabled by default
Date: Mon, 25 Jun 2018 19:16:16 -0700
Message-Id: <1529979376-7292-4-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
References: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
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

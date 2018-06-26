Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F8mg6kLPzF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 12:16:35 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id 92-v6so9409392qta.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 19:16:35 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH 1/2] powerpc/core-pkeys: execute-permission on keys are
 disabled by default
Date: Mon, 25 Jun 2018 19:16:15 -0700
Message-Id: <1529979376-7292-3-git-send-email-linuxram@us.ibm.com>
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

Only when the key is allocated, its permission are enabled.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index 36bc312..b353d86 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -140,6 +140,10 @@ static int child(struct shared_info *info)
 
 	if (disable_execute)
 		info->iamr |= 1ul << pkeyshift(pkey1);
+	else
+		info->iamr &= ~(1ul << pkeyshift(pkey1));
+	info->iamr &= ~(1ul << pkeyshift(pkey2) | 1ul << pkeyshift(pkey3));
+
 
 	info->uamor |= 3ul << pkeyshift(pkey1) | 3ul << pkeyshift(pkey2);
 
-- 
1.7.1

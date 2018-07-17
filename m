Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMC24M3SzF3Hk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:42 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id c192-v6so513023qkg.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:42 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 8/9] powerpc/core-pkeys: execute-permission on keys are
 disabled by default
Date: Tue, 17 Jul 2018 06:51:09 -0700
Message-Id: <1531835470-32691-9-git-send-email-linuxram@us.ibm.com>
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

Only when the key is allocated, its permission are enabled.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lLt5YWkzF09h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:02 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id y4-v6so2704445qka.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:02 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 08/24] selftests/vm: fix the wrong assert in
 pkey_disable_set()
Date: Wed, 13 Jun 2018 17:44:59 -0700
Message-Id: <1528937115-10132-9-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the flag is 0, no bits will be set. Hence we cant expect
the resulting bitmap to have a higher value than what it
was earlier.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 57340b3..5fcccdb 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -415,7 +415,7 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x"PKEY_REG_FMT"\n",
 		__func__, pkey, read_pkey_reg());
 	if (flags)
-		pkey_assert(read_pkey_reg() > orig_pkey_reg);
+		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
-- 
1.7.1

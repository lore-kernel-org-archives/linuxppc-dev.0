Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VM9W4ggLzF3J3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:50:23 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id 27-v6so519542qkv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:50:23 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v14 09/22] selftests/vm: fixed bugs in pkey_disable_clear()
Date: Tue, 17 Jul 2018 06:49:12 -0700
Message-Id: <1531835365-32387-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

instead of clearing the bits, pkey_disable_clear() was setting
the bits. Fixed it.

Also fixed a wrong assertion in that function. When bits are
cleared, the resulting bit value will be less than the original.

This hasn't been a problem so far because this code isn't currently
used.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2dd94c3..8fa4f74 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -433,7 +433,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
-	pkey_rights |= flags;
+	pkey_rights &= ~flags;
 
 	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	shadow_pkey_reg &= clear_pkey_flags(pkey, flags);
@@ -446,7 +446,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x"PKEY_REG_FMT"\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() > orig_pkey_reg);
+		assert(read_pkey_reg() <= orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
1.7.1

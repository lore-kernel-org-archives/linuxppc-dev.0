Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lM43dyyzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:12 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id d3-v6so4285511qto.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:12 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 13/24] selftests/vm: pkey register should match shadow pkey
Date: Wed, 13 Jun 2018 17:45:04 -0700
Message-Id: <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
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

expected_pkey_fault() is comparing the contents of pkey
register with 0. This may not be true all the time. There
could be bits set by default by the architecture
which can never be changed. Hence compare the value against
shadow pkey register, which is supposed to track the bits
accurately all throughout

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 9afe894..adcae4a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -916,10 +916,10 @@ void expected_pkey_fault(int pkey)
 		pkey_assert(last_si_pkey == pkey);
 
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler should have cleared out pkey-register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__read_pkey_reg() != 0)
+	if (__read_pkey_reg() != shadow_pkey_reg)
 		pkey_assert(0);
 
 	__write_pkey_reg(shadow_pkey_reg);
-- 
1.7.1

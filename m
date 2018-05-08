Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gN295MnZzF1P7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 01:00:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 7/8] mm/pkeys: Add an empty arch_pkeys_enabled()
Date: Wed,  9 May 2018 00:59:47 +1000
Message-Id: <20180508145948.9492-8-mpe@ellerman.id.au>
In-Reply-To: <20180508145948.9492-1-mpe@ellerman.id.au>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an empty arch_pkeys_enabled() in linux/pkeys.h for the
CONFIG_ARCH_HAS_PKEYS=n case.

Split out of a patch by Ram Pai <linuxram@us.ibm.com>.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/pkeys.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 946cb773b79f..2955ba976048 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -39,6 +39,11 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return 0;
 }
 
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
 static inline void copy_init_pkru_to_fpregs(void)
 {
 }
-- 
2.14.1

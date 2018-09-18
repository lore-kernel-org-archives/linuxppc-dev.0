Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9jx041YzF3Hk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 03:59:32 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:44 +0200
Message-Id: <20180918175850.4437-3-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 3/9] signal/powerpc: Call _exception_pkey directly
 from bad_key_fault_exception
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the need for other code paths to deal with pkey exceptions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e5725fa96a48..5afc1ee55043 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -145,7 +145,17 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
 				    int pkey)
 {
-	return __bad_area_nosemaphore(regs, address, SEGV_PKUERR, pkey);
+	/*
+	 * If we are in kernel mode, bail out with a SEGV, this will
+	 * be caught by the assembly which will restore the non-volatile
+	 * registers before calling bad_page_fault()
+	 */
+	if (!user_mode(regs))
+		return SIGSEGV;
+
+	_exception_pkey(SIGSEGV, regs, SEGV_PKUERR, address, pkey);
+
+	return 0;
 }
 
 static noinline int bad_access(struct pt_regs *regs, unsigned long address)
-- 
2.17.1

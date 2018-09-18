Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9k3663WzF3J3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 03:59:39 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:45 +0200
Message-Id: <20180918175850.4437-4-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 4/9] signal/powerpc: Remove pkey parameter from
 __bad_area_nosemaphore
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that bad_key_fault_exception no longer calls __bad_area_nosemaphore
there is no reason for __bad_area_nosemaphore to handle pkeys.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 5afc1ee55043..a84d06b7d50d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -103,8 +103,7 @@ static bool store_updates_sp(unsigned int inst)
  */
 
 static int
-__bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code,
-		int pkey)
+__bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code)
 {
 	/*
 	 * If we are in kernel mode, bail out with a SEGV, this will
@@ -114,14 +113,14 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code,
 	if (!user_mode(regs))
 		return SIGSEGV;
 
-	_exception_pkey(SIGSEGV, regs, si_code, address, pkey);
+	_exception(SIGSEGV, regs, si_code, address);
 
 	return 0;
 }
 
 static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long address)
 {
-	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR, 0);
+	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
 }
 
 static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
@@ -134,7 +133,7 @@ static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
 	 */
 	up_read(&mm->mmap_sem);
 
-	return __bad_area_nosemaphore(regs, address, si_code, 0);
+	return __bad_area_nosemaphore(regs, address, si_code);
 }
 
 static noinline int bad_area(struct pt_regs *regs, unsigned long address)
-- 
2.17.1

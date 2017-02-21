Return-Path: <fweisbec@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSPKR15jczDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 02:18:51 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id q39so15552260wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 07:18:51 -0800 (PST)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove leftover cputime_to_nsecs call causing build
 error
Date: Tue, 21 Feb 2017 16:18:41 +0100
Message-Id: <1487690321-21553-1-git-send-email-fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This type conversion is a leftover that got ignored during the kcpustat
conversion to nanosecs, resulting in build breakage with config having
CONFIG_NO_HZ_FULL=y.

	arch/powerpc/kernel/time.c: In function 'running_clock':
	arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function 'cputime_to_nsecs' [-Werror=implicit-function-declaration]
	  return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);

All we need is to remove it.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 14e4855..bc84a8d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -709,7 +709,7 @@ unsigned long long running_clock(void)
 	 * time and on a host which doesn't do any virtualisation TB *should* equal
 	 * VTB so it makes no difference anyway.
 	 */
-	return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
+	return local_clock() - kcpustat_this_cpu->cpustat[CPUTIME_STEAL];
 }
 #endif
 
-- 
2.7.4

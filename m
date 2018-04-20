Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RyWH2HX3zF1x2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 11:12:11 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Apr 2018 20:04:06 -0500
Message-Id: <20180420010408.24438-15-ebiederm@xmission.com>
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
Subject: [REVIEW][PATCH 15/17] signal: Add TRAP_UNK si_code for undiagnosted
 trap exceptions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both powerpc and alpha have cases where they wronly set si_code to 0
in combination with SIGTRAP and don't mean SI_USER.

About half the time this is because the architecture can not report
accurately what kind of trap exception triggered the trap exception.
The other half the time it looks like no one has bothered to
figure out an appropriate si_code.

For the cases where the architecture does not have enough information
or is too lazy to figure out exactly what kind of trap exception
it is define TRAP_UNK.

Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 14c057f29979..9ccbf0576cd0 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -29,7 +29,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGFPE  != 15);
 	BUILD_BUG_ON(NSIGSEGV != 7);
 	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 4);
+	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
 	BUILD_BUG_ON(NSIGSYS  != 1);
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 558b902f18d4..80e2a7227205 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -249,7 +249,8 @@ typedef struct siginfo {
 #define TRAP_TRACE	2	/* process trace trap */
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
-#define NSIGTRAP	4
+#define TRAP_UNK	5	/* undiagnosed trap */
+#define NSIGTRAP	5
 
 /*
  * There is an additional set of SIGTRAP si_codes used by ptrace
-- 
2.14.1

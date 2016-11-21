Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMhCV6L3KzDvj2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:12:06 +1100 (AEDT)
From: <yanjiang.jin@windriver.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <yanjiang.jin@windriver.com>,
 <linux-kernel@vger.kernel.org>, <jinyanjiang@gmail.com>
Subject: [PATCH] powerpc: cputime: fix a compile warning
Date: Mon, 21 Nov 2016 12:56:59 +0800
Message-ID: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yanjiang Jin <yanjiang.jin@windriver.com>

This patch is to avoid the below warning:

kernel/sched/cpuacct.c:298:25: warning:
format '%lld' expects argument of type 'long long int',
but argument 4 has type 'long unsigned int' [-Wformat=]

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/powerpc/include/asm/cputime.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 4f60db0..4423e97 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
 	return (__force cputime_t) ct;
 }
 
-#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
+#define cputime64_to_clock_t(ct)	\
+	(__force u64)(cputime_to_clock_t((cputime_t)(ct)))
 
 /*
  * PPC64 uses PACA which is task independent for storing accounting data while
-- 
1.9.1

Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmCw85tjKzDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:11:20 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id k8so8128854pli.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:11:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/9] powerpc/64s: dt_cpu_ftrs fix POWER9 DD2.2 and above
Date: Wed, 21 Feb 2018 05:08:27 +1000
Message-Id: <20180220190832.1872-5-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTR_POWER9_DD2_1 flag is intended to be set for DD2.1 and
above (which is what the cputable setup does). Fix dt_cpu_ftrs setup
to match.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 945e2c29ad2d..cb6ae7b3cdd6 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -707,7 +707,9 @@ static __init void cpufeatures_cpu_quirks(void)
 	 */
 	if ((version & 0xffffff00) == 0x004e0100)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
-	else if ((version & 0xffffefff) == 0x004e0201)
+	else if ((version & 0xffffefff) == 0x004e0200)
+		; /* DD2.0 has no feature flag */
+	else /* DD2.1 and up have DD2_1 */
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
 }
 
-- 
2.16.1

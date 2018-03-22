Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dND47jHzF203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:00 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id z8so9983824wrh.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:00 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 11/19] powerpc/powermac: Move pmac_pfunc_base_install
 prototype to header file
Date: Thu, 22 Mar 2018 21:19:57 +0100
Message-Id: <20180322202007.23088-12-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
function was used there, move it to pmac_pfunc.h header to be visible in
pfunc_base.c. Fix a warning treated as error with W=1:

  arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/pmac_pfunc.h | 1 +
 arch/powerpc/platforms/powermac/smp.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pmac_pfunc.h b/arch/powerpc/include/asm/pmac_pfunc.h
index 73bd8f28f2a8..99f7a288789a 100644
--- a/arch/powerpc/include/asm/pmac_pfunc.h
+++ b/arch/powerpc/include/asm/pmac_pfunc.h
@@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function *func);
 
 extern int pmf_call_one(struct pmf_function *func, struct pmf_args *args);
 
+extern int pmac_pfunc_base_install(void);
 
 /* Suspend/resume code called by via-pmu directly for now */
 extern void pmac_pfunc_base_suspend(void);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 95275e0e2efa..447da6db450a 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -65,7 +65,6 @@
 #endif
 
 extern void __secondary_start_pmac_0(void);
-extern int pmac_pfunc_base_install(void);
 
 static void (*pmac_tb_freeze)(int freeze);
 static u64 timebase;
-- 
2.11.0

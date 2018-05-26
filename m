Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98v4jVFzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:28:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 21/23] powerpc/pseries: Restore default
 security feature flags on setup
Date: Sat, 26 May 2018 14:27:47 +1000
Message-Id: <20180526042749.5324-22-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 6232774f1599028a15418179d17f7df47ede770a upstream.

After migration the security feature flags might have changed (e.g.,
destination system with unpatched firmware), but some flags are not
set/clear again in init_cpu_char_feature_flags() because it assumes
the security flags to be the defaults.

Additionally, if the H_GET_CPU_CHARACTERISTICS hypercall fails then
init_cpu_char_feature_flags() does not run again, which potentially
might leave the system in an insecure or sub-optimal configuration.

So, just restore the security feature flags to the defaults assumed
by init_cpu_char_feature_flags() so it can set/clear them correctly,
and to ensure safe settings are in place in case the hypercall fail.

Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Depends-on: 19887d6a28e2 ("powerpc: Move default security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 3cb12d27f168..1973de3cf355 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -462,6 +462,10 @@ static void __init find_and_init_phbs(void)
 
 static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 {
+	/*
+	 * The features below are disabled by default, so we instead look to see
+	 * if firmware has *enabled* them, and set them if so.
+	 */
 	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
 		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
 
@@ -501,6 +505,13 @@ void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
+	/*
+	 * Set features to the defaults assumed by init_cpu_char_feature_flags()
+	 * so it can set/clear again any features that might have changed after
+	 * migration, and in case the hypercall fails and it is not even called.
+	 */
+	powerpc_security_features = SEC_FTR_DEFAULT;
+
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
-- 
2.14.1

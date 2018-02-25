Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcJ5yWvzF1Mn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:22:56 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id a20so13820698wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:22:56 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 01/21] powerpc: Remove warning on array size when empty
Date: Sun, 25 Feb 2018 18:22:16 +0100
Message-Id: <20180225172236.29650-2-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
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

When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
array feature_properties is defined as an empty array, which in turn
triggers the following warning (treated as error on W=1):

  CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
  for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
                ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4dffef947b8a..6e8e4122820e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -291,11 +291,10 @@ static inline void identical_pvr_fixup(unsigned long node)
 
 static void __init check_cpu_feature_properties(unsigned long node)
 {
-	unsigned long i;
 	struct feature_property *fp = feature_properties;
 	const __be32 *prop;
 
-	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
+	for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
 		prop = of_get_flat_dt_prop(node, fp->name, NULL);
 		if (prop && be32_to_cpup(prop) >= fp->min_value) {
 			cur_cpu_spec->cpu_features |= fp->cpu_feature;
-- 
2.11.0

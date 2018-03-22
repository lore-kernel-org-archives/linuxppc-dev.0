Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNL203TzF20B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:06 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id 139so18532393wmn.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:06 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
Date: Thu, 22 Mar 2018 21:20:00 +0100
Message-Id: <20180322202007.23088-15-malat@debian.org>
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

Some functions prototypes were missing for the non-altivec code. Add the
missing prototypes directly in xor_vmx, fix warnings treated as errors with
W=1:

  arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
index 5c2b0839b179..2173e3c84151 100644
--- a/arch/powerpc/lib/xor_vmx.h
+++ b/arch/powerpc/lib/xor_vmx.h
@@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
 void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
 			     unsigned long *v2_in, unsigned long *v3_in,
 			     unsigned long *v4_in, unsigned long *v5_in);
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in);
+
+void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in);
+
+void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in);
+
+void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in, unsigned long *v5_in);
-- 
2.11.0

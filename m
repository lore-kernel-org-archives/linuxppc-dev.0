Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5bgt1M66zDrWS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:00:41 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id i11so34855782wmf.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 05:00:41 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: 
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xive: Properly use static keyword for inline function
Date: Tue, 26 Dec 2017 14:00:17 +0100
Message-Id: <20171226130020.23626-1-malat@debian.org>
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

Fix fatal warning during compilation:

In file included from arch/powerpc/xmon/xmon.c:54:0:
./arch/powerpc/include/asm/xive.h:157:20: error: no previous prototype for ‘xive_smp_prepare_cpu’ [-Werror=missing-prototypes]
 extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
                    ^

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/xive.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 371fbebf1ec9..83dc2cc320a3 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -154,7 +154,7 @@ static inline bool xive_enabled(void) { return false; }
 static inline bool xive_spapr_init(void) { return false; }
 static inline bool xive_native_init(void) { return false; }
 static inline void xive_smp_probe(void) { }
-extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
+static inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
 static inline void xive_smp_setup_cpu(void) { }
 static inline void xive_smp_disable_cpu(void) { }
 static inline void xive_kexec_teardown_cpu(int secondary) { }
-- 
2.11.0

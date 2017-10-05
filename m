Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x22c.google.com (mail-pg0-x22c.google.com
 [IPv6:2607:f8b0:400e:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7McC65PTzDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 06:03:22 +1100 (AEDT)
Received: by mail-pg0-x22c.google.com with SMTP id v78so6933973pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 12:03:22 -0700 (PDT)
Date: Thu, 5 Oct 2017 12:03:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: Default to enabling STRICT_KERNEL_RWX
Message-ID: <20171005190317.GA98302@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When available, CONFIG_KERNEL_RWX should be default-enabled for PPC64.
On PPC32, there is a performance trade-off.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- depend on PPC64, as noted by Christophe.
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 809c468edab1..4315c9b2db4f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -178,6 +178,7 @@ config PPC
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
+	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT	if PPC64
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
-- 
2.7.4


-- 
Kees Cook
Pixel Security

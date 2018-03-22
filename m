Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dMt1XG7zF202
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:42 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id 139so18530639wmn.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:41 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 01/19] powerpc/powermac: Mark variable x as unused
Date: Thu, 22 Mar 2018 21:19:47 +0100
Message-Id: <20180322202007.23088-2-malat@debian.org>
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

Since the value of x is never intended to be read, declare it with gcc
attribute as unused. Fix warning treated as error with W=1:

  arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index c3c9bbb3573a..d3ce55dae78f 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	boot_infos_t *bi = (boot_infos_t *) r4;
 	unsigned long hdr;
 	unsigned long space;
-	unsigned long ptr, x;
+	unsigned long ptr, x __maybe_unused;
 	char *model;
 	unsigned long offset = reloc_offset();
 
-- 
2.11.0

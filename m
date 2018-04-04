Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GcTC0HNfzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:07:58 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id u11so24695295wri.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:07:58 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/19] powerpc/powermac: Mark variable x as unused
Date: Wed,  4 Apr 2018 22:07:46 +0200
Message-Id: <20180404200746.27379-1-malat@debian.org>
In-Reply-To: <20180328192717.656-1-malat@debian.org>
References: <20180328192717.656-1-malat@debian.org>
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

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: style: add missing empty line after declaration
v2: move x variable within its local scope

 arch/powerpc/platforms/powermac/bootx_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index c3c9bbb3573a..ba0964c17620 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	boot_infos_t *bi = (boot_infos_t *) r4;
 	unsigned long hdr;
 	unsigned long space;
-	unsigned long ptr, x;
+	unsigned long ptr;
 	char *model;
 	unsigned long offset = reloc_offset();
 
@@ -562,6 +562,8 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	 * MMU switched OFF, so this should not be useful anymore.
 	 */
 	if (bi->version < 4) {
+		unsigned long x __maybe_unused;
+
 		bootx_printf("Touching pages...\n");
 
 		/*
-- 
2.11.0

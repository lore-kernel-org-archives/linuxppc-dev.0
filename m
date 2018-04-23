Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VGtX3McdzF21G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 05:36:52 +1000 (AEST)
Received: by mail-wr0-x243.google.com with SMTP id q3-v6so34376977wrj.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 12:36:52 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Randy Dunlap <rdunlap@infradead.org>, Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/mm/radix: use do/while(0) trick for single
 statement block
Date: Mon, 23 Apr 2018 21:36:38 +0200
Message-Id: <20180423193638.10535-1-malat@debian.org>
In-Reply-To: <20180408194424.8719-1-malat@debian.org>
References: <20180408194424.8719-1-malat@debian.org>
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

In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
disable_radix") an `if` statement was added for a possible empty body
(prom_debug).

Fix the following warning, treated as error with W=1:

  arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: update macro directly

 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5ae153b97d0a..7edf3aa5bc6d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -103,7 +103,7 @@ int of_workarounds;
 #ifdef DEBUG_PROM
 #define prom_debug(x...)	prom_printf(x)
 #else
-#define prom_debug(x...)
+#define prom_debug(x...)	do { } while (0)
 #endif
 
 
-- 
2.11.0

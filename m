Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dN26m9HzF20M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:50 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id p53so2474910wrc.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:50 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 06/19] powerpc: Make function btext_initialize static
Date: Thu, 22 Mar 2018 21:19:52 +0100
Message-Id: <20180322202007.23088-7-malat@debian.org>
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

This function can be static, make it so, this fix a warning treated as
error with W=1:

  arch/powerpc/kernel/btext.c:173:5: error: no previous prototype for ‘btext_initialize’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/btext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 6537cba1a758..38ae3ffe44f6 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -170,7 +170,7 @@ void btext_map(void)
 	boot_text_mapped = 1;
 }
 
-int btext_initialize(struct device_node *np)
+static int btext_initialize(struct device_node *np)
 {
 	unsigned int width, height, depth, pitch;
 	unsigned long address = 0;
-- 
2.11.0

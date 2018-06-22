Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C7rb6HZCzF13G
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 05:27:59 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id p126-v6so3234976wmb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 12:27:59 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc/mm:=20remove=20warning=20about=20?=
 =?UTF-8?q?=E2=80=98type=E2=80=99=20being=20set?=
Date: Fri, 22 Jun 2018 21:27:47 +0200
Message-Id: <20180622192749.24954-1-malat@debian.org>
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

‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
unused tag to variable. Remove warning treated as error with W=1:

  arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/highmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
index 668e87d03f9e..82a0e37557a5 100644
--- a/arch/powerpc/mm/highmem.c
+++ b/arch/powerpc/mm/highmem.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
 void __kunmap_atomic(void *kvaddr)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
+	int type __maybe_unused;
 
 	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
 		pagefault_enable();
-- 
2.11.0

Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C986C2C0104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:10:21 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <paulus@samba.org>,
 <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/6 v5] powerpc: book3e: _PAGE_LENDIAN must be _PAGE_ENDIAN
Date: Thu, 19 Sep 2013 11:32:41 +0530
Message-ID: <1379570566-3715-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For booke3e _PAGE_ENDIAN is not defined. Infact what is defined
is "_PAGE_LENDIAN" which is wrong and that should be _PAGE_ENDIAN.
There are no compilation errors as
arch/powerpc/include/asm/pte-common.h defines _PAGE_ENDIAN to 0
as it is not defined anywhere.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v5
 - no change

 arch/powerpc/include/asm/pte-book3e.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/pte-book3e.h
index 0156702..576ad88 100644
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -40,7 +40,7 @@
 #define _PAGE_U1	0x010000
 #define _PAGE_U0	0x020000
 #define _PAGE_ACCESSED	0x040000
-#define _PAGE_LENDIAN	0x080000
+#define _PAGE_ENDIAN	0x080000
 #define _PAGE_GUARDED	0x100000
 #define _PAGE_COHERENT	0x200000 /* M: enforce memory coherence */
 #define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */
-- 
1.7.0.4

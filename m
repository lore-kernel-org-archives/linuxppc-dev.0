Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znDNS1nQ3zF1T9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:35:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: npiggin@gmail.com, linuxppc-dev@ozlabs.org, linux@roeck-us.net,
 corsac@debian.org
Subject: [PATCH v4.9 backport 1/3] powerpc/64s: Fix conversion of
 slb_miss_common to use RFI_TO_USER/KERNEL
Date: Thu, 22 Feb 2018 23:35:43 +1100
Message-Id: <20180222123545.8946-1-mpe@ellerman.id.au>
In-Reply-To: <20180222065738.GB2428@kroah.com>
References: <20180222065738.GB2428@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The back port of commit c7305645eb0c ("powerpc/64s: Convert
slb_miss_common to use RFI_TO_USER/KERNEL") missed a hunk needed to
restore cr6.

Fixes: 48cc95d4e4d6 ("powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 96db6c3adebe..d0be752ea86c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -680,6 +680,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 .machine	push
 .machine	"power4"
 	mtcrf	0x80,r9
+	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
-- 
2.14.1

Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNN3LnBzF207
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:08 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id z73so10009648wrb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:07 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 15/19] powerpc: Add missing prototype
Date: Thu, 22 Mar 2018 21:20:01 +0100
Message-Id: <20180322202007.23088-16-malat@debian.org>
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

Add one missing prototype for function rh_dump_blk. Fix warning treated as
error in W=1:

  arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/rheap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
index 172381769cfc..e75d96de19a0 100644
--- a/arch/powerpc/include/asm/rheap.h
+++ b/arch/powerpc/include/asm/rheap.h
@@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
 /* Simple dump of remote heap info */
 extern void rh_dump(rh_info_t * info);
 
+/* Simple dump of remote info block */
+extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
+
 /* Set owner of taken block */
 extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
-- 
2.11.0

Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GcYd4rS0zF1pZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:11:49 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id p9so353618wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:11:49 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/19] powerpc: Add missing prototype
Date: Wed,  4 Apr 2018 22:11:42 +0200
Message-Id: <20180404201142.27691-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-16-malat@debian.org>
References: <20180322202007.23088-16-malat@debian.org>
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

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/include/asm/rheap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
index 172381769cfc..8e83703d6736 100644
--- a/arch/powerpc/include/asm/rheap.h
+++ b/arch/powerpc/include/asm/rheap.h
@@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
 /* Simple dump of remote heap info */
 extern void rh_dump(rh_info_t * info);
 
+/* Simple dump of remote info block */
+void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
+
 /* Set owner of taken block */
 extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
-- 
2.11.0

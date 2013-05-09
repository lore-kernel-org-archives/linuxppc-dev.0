Return-Path: <yefremov.denis@gmail.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AF322C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 20:41:08 +1000 (EST)
Received: by mail-lb0-f173.google.com with SMTP id 10so360047lbf.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 May 2013 03:41:05 -0700 (PDT)
From: Denis Efremov <yefremov.denis@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 20/21] powerpc/ps3: remove inline marking of EXPORT_SYMBOL
 functions
Date: Thu,  9 May 2013 14:36:58 +0400
Message-Id: <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
In-Reply-To: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
Cc: ldv-project@linuxtesting.org, trivial@kernel.org,
 Denis Efremov <yefremov.denis@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EXPORT_SYMBOL and inline directives are contradictory to each other.
The patch fixes this inconsistency.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
---
 arch/powerpc/platforms/ps3/spu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index e17fa14..a0bca05 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -143,7 +143,7 @@ static void _dump_areas(unsigned int spe_id, unsigned long priv2,
 	pr_debug("%s:%d: shadow:  %lxh\n", func, line, shadow);
 }
 
-inline u64 ps3_get_spe_id(void *arg)
+u64 ps3_get_spe_id(void *arg)
 {
 	return spu_pdata(arg)->spe_id;
 }
-- 
1.8.1.4

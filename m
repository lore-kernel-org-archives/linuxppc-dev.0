Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GcbF5n6TzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:13:13 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id r131so466009wmb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:13:13 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/19] powerpc/powermac: Add missing prototype for
 note_bootable_part()
Date: Wed,  4 Apr 2018 22:13:05 +0200
Message-Id: <20180404201306.27818-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-13-malat@debian.org>
References: <20180322202007.23088-13-malat@debian.org>
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

Add a missing prototype for function `note_bootable_part` to silence a
warning treated as error with W=1:

  arch/powerpc/platforms/powermac/setup.c:361:12: error: no previous prototype for ‘note_bootable_part’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/platforms/powermac/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index ab668cb72263..8b2eab1340f4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -352,6 +352,7 @@ static int pmac_late_init(void)
 }
 machine_late_initcall(powermac, pmac_late_init);
 
+void note_bootable_part(dev_t dev, int part, int goodness);
 /*
  * This is __ref because we check for "initializing" before
  * touching any of the __init sensitive things and "initializing"
-- 
2.11.0

Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 845981A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 10:17:14 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so118875426pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 17:17:11 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andreas Ruprecht <andreas.ruprecht@fau.de>
Subject: [PATCH] powerpc: Remove PPC32 code from pseries specific
 find_and_init_phbs()
Date: Tue, 14 Apr 2015 10:16:47 +1000
Message-Id: <1428970607-17513-1-git-send-email-dja@axtens.net>
In-Reply-To: <552C0AA6.4010403@fau.de>
References: <552C0AA6.4010403@fau.de>
Cc: Paul Bolle <pebolle@tiscali.nl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 Stefan Hengelein <stefan.hengelein@fau.de>,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In bdc728a849a7 ("powerpc: move find_and_init_phbs() to pSeries
specific code"), find_and_init_phbs() was moved into a pseries
specific file, but PPC32 code wasn't removed. Remove it.

See https://lkml.kernel.org/r/552C0AA6.4010403@fau.de

Reported-by: Andreas Ruprecht <andreas.ruprecht@fau.de>
Fixes: bdc728a849a7
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/pseries/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 328e318..baefd3e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -499,13 +499,6 @@ static void __init find_and_init_phbs(void)
 			else
 				pci_clear_flags(PCI_PROBE_ONLY);
 		}
-
-#ifdef CONFIG_PPC32 /* Will be made generic soon */
-		prop = of_get_property(of_chosen,
-				"linux,pci-assign-all-buses", NULL);
-		if (prop && *prop)
-			pci_add_flags(PCI_REASSIGN_ALL_BUS);
-#endif /* CONFIG_PPC32 */
 	}
 }
 
-- 
2.1.4

Return-Path: <clg@kaod.org>
Received: from 16.mo4.mail-out.ovh.net (16.mo4.mail-out.ovh.net
 [188.165.55.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gFcQ6j5QzF1x5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 20:10:45 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.122.5])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 84A7A16AC18
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 09:05:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 3/4] powerpc/xive: shutdown XIVE when kexec or kdump is
 performed
Date: Tue,  8 May 2018 09:05:16 +0200
Message-Id: <20180508070517.947-4-clg@kaod.org>
In-Reply-To: <20180508070517.947-1-clg@kaod.org>
References: <20180508070517.947-1-clg@kaod.org>
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

The hcall H_INT_RESET should be called to make sure XIVE is fully
reseted.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/platforms/pseries/kexec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 3fe126796975..46fbaef69a59 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -57,8 +57,11 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 		}
 	}
 
-	if (xive_enabled())
+	if (xive_enabled()) {
 		xive_kexec_teardown_cpu(secondary);
-	else
+
+		if (!secondary)
+			xive_shutdown();
+	} else
 		xics_kexec_teardown_cpu(secondary);
 }
-- 
2.13.6

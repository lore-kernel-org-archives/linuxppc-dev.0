Return-Path: <clg@kaod.org>
Received: from 18.mo5.mail-out.ovh.net (18.mo5.mail-out.ovh.net [178.33.45.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FhFV51kpzF24w
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 17:54:38 +1000 (AEST)
Received: from player716.ha.ovh.net (unknown [10.109.122.38])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 119E2199F09
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 09:16:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] powerpc/xive: shutdown XIVE when kexec or kdump is
 performed
Date: Tue,  3 Apr 2018 09:15:47 +0200
Message-Id: <20180403071548.19829-4-clg@kaod.org>
In-Reply-To: <20180403071548.19829-1-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
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
index eeb13429d685..1d9bbf8e7357 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -52,8 +52,11 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
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

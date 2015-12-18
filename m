Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E54D61A1A2B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 21:46:04 +1100 (AEDT)
Message-ID: <1450435564.2791.98.camel@neuling.org>
Subject: [PATCH] powerpc/powernv: Only delay opal_rtc_read() retry when
 necessary
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Stewart Smith
 <sesmith@au1.ibm.com>, Anton Blanchard <anton@samba.org>
Date: Fri, 18 Dec 2015 21:46:04 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only delay opal_rtc_read() when busy and are going to retry.

This has the advantage of possibly saving a massive 10ms off booting!

Kudos to Stewart for noticing.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platf=
orms/powernv/opal-rtc.c
index 37dbee1..06511f3 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -51,7 +51,7 @@ unsigned long __init opal_get_boot_time(void)
 		rc =3D opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc =3D=3D OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (rc =3D=3D OPAL_BUSY)
 			mdelay(10);
 	}
 	if (rc !=3D OPAL_SUCCESS)

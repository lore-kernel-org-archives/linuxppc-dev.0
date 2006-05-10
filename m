Return-Path: <anton@ozlabs.org>
Date: Wed, 10 May 2006 13:05:54 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix LED progress on pseries boxes
Message-ID: <20060510030553.GA8702@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It looks like we are printing the wrong thing on the op panel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5eb55ef..5f79f01 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -255,7 +255,7 @@ static int __init pSeries_init_panel(voi
 {
 	/* Manually leave the kernel version on the panel. */
 	ppc_md.progress("Linux ppc64\n", 0);
-	ppc_md.progress(system_utsname.version, 0);
+	ppc_md.progress(system_utsname.release, 0);
 
 	return 0;
 }

Return-Path: <anton@ozlabs.org>
Date: Fri, 8 Dec 2006 18:08:37 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] micro optimise pSeries_probe
Message-ID: <20061208070837.GC29167@krispykreme>
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


We find the OF root the line before, we may as well use it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- kernel.orig/arch/powerpc/platforms/pseries/setup.c	2006-10-24 10:23:28.234782030 -0500
+++ kernel/arch/powerpc/platforms/pseries/setup.c	2006-10-24 10:26:19.068732015 -0500
@@ -503,8 +503,8 @@ static int __init pSeries_probe_hypertas
 static int __init pSeries_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
- 	char *dtype = of_get_flat_dt_prop(of_get_flat_dt_root(),
- 					  "device_type", NULL);
+ 	char *dtype = of_get_flat_dt_prop(root, "device_type", NULL);
+
  	if (dtype == NULL)
  		return 0;
  	if (strcmp(dtype, "chrp"))

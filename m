Return-Path: <johns.daniel@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 933FBDE12D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:50:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so42064and.39
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 08:50:56 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Mar 2009 10:50:56 -0500
Message-ID: <ba5d9360903110850gbcb0d2y25f8756a19d46cda@mail.gmail.com>
Subject: [PATCH] powerpc: Remove extra semicolon in fsl_soc.c
From: Johns Daniel <johns.daniel@gmail.com>
To: afleming@freescale.com, linuxppc-dev@ozlabs.org, stable@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A semicolon at the end of the macro means that the for loop has an
empty body, and so TSEC/MDIO will not work with older device trees.

This fix only applies to 2.6.28; apparently, this code is gone for
2.6.29, according to Grant Likely!

Signed-off-by: Johns Daniel <johns.daniel@gmail.com>
---
--- linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c.orig   2009-02-20
16:41:27.000000000 -0600
+++ linux-2.6.28.7/arch/powerpc/sysdev/fsl_soc.c        2009-03-10
15:56:47.000000000 -0500
@@ -257,7 +257,7 @@
                gfar_mdio_of_init_one(np);

        /* try the deprecated version */
-       for_each_compatible_node(np, "mdio", "gianfar");
+       for_each_compatible_node(np, "mdio", "gianfar")
                gfar_mdio_of_init_one(np);

        return 0;
---

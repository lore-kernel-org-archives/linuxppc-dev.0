Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com
 [IPv6:2a00:1450:4010:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKbwB4MKJzDrjD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 05:52:25 +1000 (AEST)
Received: by mail-lf0-x236.google.com with SMTP id g25so97850384lfh.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 12:52:25 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-Id: <20170729195217.214940504@cogentembedded.com>
Date: Sat, 29 Jul 2017 22:52:09 +0300
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] mpc832x_rdb: fix of_irq_to_resource() error check
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_irq_to_resource() has recently been  fixed to return negative error #'s
along with 0 in case of failure,  however the Freescale MPC832x RDB board
code still only regards 0 as as failure indication -- fix it up.

Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'master' branch of Scott Wood's 'linux.git' repo
(the 'fixes' branch is too much behind).

 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/powerpc/platforms/83xx/mpc832x_rdb.c
===================================================================
--- linux.orig/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ linux/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -89,7 +89,7 @@ static int __init of_fsl_spi_probe(char
 			goto err;
 
 		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (!ret)
+		if (ret <= 0)
 			goto err;
 
 		pdev = platform_device_alloc("mpc83xx_spi", i);

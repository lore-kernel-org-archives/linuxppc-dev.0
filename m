Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyLgb1hv2zDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 21:49:47 +1000 (AEST)
Date: Wed, 28 Jun 2017 14:49:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc: remapping too much memory
Message-ID: <20170628114907.kf3t65mrdbq7rsfm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a cut and paste error here so we use "sizeof(struct mpc83xx_pmc)"
to remap the memory for "clock_regs".  That sizeof() is 20 bytes and we
only need to remap 12 bytes.  It presumably doesn't affect run time too
much...

I changed them to both use "sizeof(*variable_name)" because that's the
prefered kernel style these days.

Fixes: d49747bdfb2d ("powerpc/mpc83xx: Power Management support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 978b85bb3233..7fa3e197871a 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -361,7 +361,7 @@ static int pmc_probe(struct platform_device *ofdev)
 			return -EBUSY;
 	}
 
-	pmc_regs = ioremap(res.start, sizeof(struct mpc83xx_pmc));
+	pmc_regs = ioremap(res.start, sizeof(*pmc_regs));
 
 	if (!pmc_regs) {
 		ret = -ENOMEM;
@@ -374,7 +374,7 @@ static int pmc_probe(struct platform_device *ofdev)
 		goto out_pmc;
 	}
 
-	clock_regs = ioremap(res.start, sizeof(struct mpc83xx_pmc));
+	clock_regs = ioremap(res.start, sizeof(*clock_regs));
 
 	if (!clock_regs) {
 		ret = -ENOMEM;

Return-Path: <computersforpeace@gmail.com>
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com
 [209.85.220.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85FE32C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:29:00 +1100 (EST)
Received: by mail-vc0-f169.google.com with SMTP id kw10so219815vcb.28
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 21:28:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364387100-23013-1-git-send-email-tie-fei.zang@freescale.com>
References: <1364387100-23013-1-git-send-email-tie-fei.zang@freescale.com>
Date: Thu, 28 Mar 2013 21:28:56 -0700
Message-ID: <CAN8TOE-fpTYj5Z5VW=MbH6epK9Ymc+=uQkh7V6=k=76_DjouPA@mail.gmail.com>
Subject: Re: [upstream] mtd/ifc: fix ifc driver memory release issue
From: Brian Norris <computersforpeace@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Li Hao <b44421@freescale.com>,
 linux-mtd@lists.infradead.org, scottwood@freescale.com, dwmw2@infradead.org,
 Cao Yonghua <b43619@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 27, 2013 at 5:25 AM, Roy Zang <tie-fei.zang@freescale.com> wrote:
> memory is allocated by devm_kzalloc, so release it using
> devm_kfree() instead kfree();

You are correct that it should not be freed with kfree(). But the
correct solution is that it does not need to be freed (explicitly) at
all. That's the whole point of the managed allocators (i.e.,
devm_kzalloc()). Try this patch instead. Totally untested here.

From: Brian Norris <computersforpeace@gmail.com>
Date: Thu, 28 Mar 2013 21:20:27 -0700
Subject: [PATCH] mtd: fsl_ifc_nand: remove incorrect kfree()

The struct fsl_ifc_mtd is allocated with devm_kzalloc, so its memory
is "managed" automatically by the kernel. That is, we do not need to
free it explicitly; it will be freed when the device is removed. And we
*certainly* shouldn't free it with a regular kfree().

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index f1f7f12..180bfa7 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -908,7 +908,6 @@ static int fsl_ifc_chip_remove(struct fsl_ifc_mtd *priv)

 	ifc_nand_ctrl->chips[priv->bank] = NULL;
 	dev_set_drvdata(priv->dev, NULL);
-	kfree(priv);

 	return 0;
 }
-- 
1.7.9.5

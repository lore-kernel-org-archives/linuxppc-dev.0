Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 21A5CDDF2D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:41:33 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so263755wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 04:41:32 -0700 (PDT)
Date: Fri, 10 Oct 2008 07:40:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mtd: remove dead Kconfig associated with !CONFIG_PPC_MERGE
Message-ID: <20081010114008.GA8590@yoda.jdub.homelinux.org>
References: <1223610606-13096-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223610606-13096-1-git-send-email-galak@kernel.crashing.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 10:50:06PM -0500, Kumar Gala wrote:
>Removed the Kconfig associated with 'NDFC NanD Flash Controller'.
>We can't enable !CONFIG_PPC_MERGE so there is no way to enable
>this.  Additionally the code needs to get updated for arch/powerpc.
>
>For the time being lets just remove the Kconfig option so we can
>actually remove CONFIG_PPC_MERGE.
>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

The driver does need fixing, and there are patches for it.  We just
haven't settled on an implementation yet so:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
> drivers/mtd/nand/Kconfig |    7 -------
> 1 files changed, 0 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>index 41f361c..1acdff7 100644
>--- a/drivers/mtd/nand/Kconfig
>+++ b/drivers/mtd/nand/Kconfig
>@@ -163,13 +163,6 @@ config MTD_NAND_S3C2410_HWECC
> 	  incorrect ECC generation, and if using these, the default of
> 	  software ECC is preferable.
> 
>-config MTD_NAND_NDFC
>-	tristate "NDFC NanD Flash Controller"
>-	depends on 4xx && !PPC_MERGE
>-	select MTD_NAND_ECC_SMC
>-	help
>-	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
>-
> config MTD_NAND_S3C2410_CLKSTOP
> 	bool "S3C2410 NAND IDLE clock stop"
> 	depends on MTD_NAND_S3C2410
>-- 
>1.5.5.1
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev

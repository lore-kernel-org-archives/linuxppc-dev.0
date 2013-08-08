Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A5D82C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 10:33:10 +1000 (EST)
Received: from mail66-db8 (localhost [127.0.0.1])	by mail66-db8-R.bigfish.com
 (Postfix) with ESMTP id 2A39D8C00BD	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Aug 2013 00:33:03 +0000 (UTC)
Received: from DB8EHSMHS015.bigfish.com (unknown [10.174.8.228])	by
 mail66-db8.bigfish.com (Postfix) with ESMTP id 519C8600046	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 00:33:00 +0000 (UTC)
Date: Wed, 7 Aug 2013 19:32:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [3/3,v2] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
Message-ID: <20130808003255.GA3901@home.buserror.net>
References: <1371812354-1962-3-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1371812354-1962-3-git-send-email-Minghuan.Lian@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 21, 2013 at 06:59:14PM +0800, Minghuan Lian wrote:
> The original MPIC MSI bank contains 8 registers, MPIC v4.3 MSI bank
> contains 16 registers, and this patch adds NR_MSI_REG_MAX and
> NR_MSI_IRQS_MAX to describe the maximum capability of MSI bank.
> MPIC v4.3 provides MSIIR1 to index these 16 MSI registers. MSIIR1
> uses different bits definition than MSIIR. This patch adds
> ibs_shift and srs_shift to indicate the bits definition of the
> MSIIR and MSIIR1, so the same code can handle the MSIIR and MSIIR1
> simultaneously.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> ---
> v2 log:
> 1. remove 'msiregs' support.
> 
>  arch/powerpc/sysdev/fsl_msi.c | 132 ++++++++++++++++++++++++++++++------------
>  arch/powerpc/sysdev/fsl_msi.h |  10 +++-
>  2 files changed, 101 insertions(+), 41 deletions(-)

Applied with the following changes:

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index fd6458b..77efbae 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -481,8 +481,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 				goto error_out;
 		}
 	} else {
-		const u32 all_avail[] = { 0,
-					  NR_MSI_REG_MSIIR * IRQS_PER_MSI_REG};
+		static const u32 all_avail[] =
+			{ 0, NR_MSI_REG_MSIIR * IRQS_PER_MSI_REG };
 
 		msi->srs_shift = MSIIR_SRS_SHIFT;
 		msi->ibs_shift = MSIIR_IBS_SHIFT;


-Scott

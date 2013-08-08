Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5F7A2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 10:30:32 +1000 (EST)
Received: from mail56-ch1 (localhost [127.0.0.1])	by mail56-ch1-R.bigfish.com
 (Postfix) with ESMTP id BD12E3000E5	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Aug 2013 00:30:26 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.228])	by mail56-ch1.bigfish.com (Postfix) with ESMTP id
 34CB318004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 00:30:25 +0000 (UTC)
Date: Wed, 7 Aug 2013 19:30:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [1/3,v2] powerpc/dts: update MSI bindings doc for MPIC v4.3
Message-ID: <20130808003021.GA22932@home.buserror.net>
References: <1371812354-1962-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1371812354-1962-1-git-send-email-Minghuan.Lian@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 21, 2013 at 06:59:12PM +0800, Minghuan Lian wrote:
> Add compatible "fsl,mpic-msi-v4.3" for MPIC v4.3. MPIC v4.3 contains
> MSIIR and MSIIR1. MSIIR supports 8 MSI registers and MSIIR1 supports
> 16 MSI registers, but uses different IBS and SRS shift. When using
> MSIR1, the interrupt number is not consecutive. It is hard to use
> 'msi-available-ranges' to describe the ranges of the available
> interrupt, so MPIC v4.3 does not support this property.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> ---
> v2 log:
> 1. move msi-available-ranges to optional properties.
> 
>  .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 51 +++++++++++++++++-----
>  1 file changed, 40 insertions(+), 11 deletions(-)

Applied with these changes:

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
index d82b080..82dd5b6 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
@@ -1,13 +1,13 @@
 * Freescale MSI interrupt controller
 
 Required properties:
-- compatible : compatible list, may contains one or two entries,
-  first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
+- compatible : compatible list, may contain one or two entries
+  The first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
   etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" or
   "fsl,mpic-msi-v4.3" depending on the parent type and version. If mpic
   version is 4.3, the number of MSI registers is increased to 16, MSIIR1 is
-  provided to access these 16 registers, compatible "fsl,mpic-msi-v4.3"
-  should be used. The first entry is optional, the second entry must be
+  provided to access these 16 registers, and compatible "fsl,mpic-msi-v4.3"
+  should be used. The first entry is optional; the second entry is
   required.
 
 - reg : It may contain one or two regions. The first region should contain

-Scott

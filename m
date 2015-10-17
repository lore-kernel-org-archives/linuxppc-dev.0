Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3D401A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 16:35:28 +1100 (AEDT)
Date: Sat, 17 Oct 2015 00:35:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Hongtao Jia <hongtao.jia@freescale.com>
CC: <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: PowerPC: Move Freescale device tree files into fsl folder
Message-ID: <20151017053512.GA24971@home.buserror.net>
References: <1442548824-45849-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442548824-45849-1-git-send-email-hongtao.jia@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 18, 2015 at 12:00:24PM +0800, Hongtao Jia wrote:
> It makes no sense that some Freescale device tree files are in fsl
> directory while some others not. This patch move Freescale device tree
> files into fsl folder. To do that the following two steps are made:
> - Move Freescale device tree files into fsl folder.
> - Update the include path in these files from "fsl/*.dtsi" to "*.dtsi".
> 
> Please add "fsl/" prefix when you make dtb using Makefile.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>

This broke cuImage -- I made this change when applying:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4eec430..99e4487 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -364,6 +364,9 @@ $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
+$(obj)/cuImage.%: vmlinux $(obj)/fsl/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/fsl/$*.dtb)
+
 $(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)

-Scott

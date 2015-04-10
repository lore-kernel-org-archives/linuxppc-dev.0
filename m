Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F42E1A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 13:56:02 +1000 (AEST)
Message-ID: <1428638140.22867.583.camel@freescale.com>
Subject: Re: [PATCH] QorIQ/TMU: add TMU node to device tree for QorIQ T104x
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
Date: Thu, 9 Apr 2015 22:55:40 -0500
In-Reply-To: <1427782669-20368-1-git-send-email-hongtao.jia@freescale.com>
References: <1427782669-20368-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 14:17 +0800, Jia Hongtao wrote:
> This is Thermal Monitoring Unit for QorIQ platform.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  | 58 +++++++++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi   | 82 ++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  1 +
>  3 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
>  create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-tmu-t104xsi.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> new file mode 100644
> index 0000000..dfc17fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -0,0 +1,58 @@
> +* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> +
> +Required properties:
> +- compatible : "fsl,qoriq-tmu".

compatible: Must include "fsl,qoriq-tmu". The version of the device is
	    determined by the TMU IP Block Revision Register (IPBRR0)
	    at offset 0x0BF8.

	    Table of correspondences between IPBRR0 values and example  
	    chips:
		Value           Device
		-----------     -------
		0x01900102      T1040

> +- reg : address range of TMU registers.
> +- interrupts : should contain the interrupt for TMU.

s/should contain/contains/

> +- calibration : calibration table for TMU.

What is the format of the calibration table, and where does one get the
data?

-Scott

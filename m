Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384A81A0011
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 11:43:37 +1000 (EST)
Date: Tue, 1 Jul 2014 20:43:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [1/3,v4] powerpc/fsl-booke: Add support for T2080/T2081 SoC
Message-ID: <20140702014324.GA21768@home.buserror.net>
References: <1402481406-10830-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1402481406-10830-1-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2014 at 06:10:04PM +0800, Shengzhou Liu wrote:
> +/* controller at 0x240000 */
> +&pci0 {
> +	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie";

None of your patches add "fsl,qoriq-pcie" to of_device_ids[] in
corenet_generic.c, so PCIe will not get probed.

Worse, if I add that string, the kernel hangs trying to access a PCIe
controller that is disabled by the RCW.  This is because U-Boot is
expecting "fsl,qoriq-pcie-v3.0", and thus can't find the disabled node in
order to delete it.

Did you test PCIe at all on these boards?

Did you test other peripherals?

-Scott

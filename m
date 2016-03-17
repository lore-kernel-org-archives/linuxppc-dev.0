Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQvsM1MSZzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 04:06:47 +1100 (AEDT)
Date: Thu, 17 Mar 2016 12:06:40 -0500
From: Rob Herring <robh@kernel.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>, ulf.hansson@linaro.org,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
Subject: Re: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
Message-ID: <20160317170640.GB21009@rob-hp-laptop>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 06:08:49PM +0800, Yangbo Lu wrote:
> Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/
> since it's used by not only PowerPC but also ARM. And add a specification
> for 'little-endian' property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> Changes for v5:
> 	- Modified the description for little-endian property
> Changes for v6:
> 	- None
> ---
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt | 3 +++
>  1 file changed, 3 insertions(+)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> similarity index 91%
> rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
> index b71b203..07adca9 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> @@ -25,6 +25,9 @@ Recommended properties:
>   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
>     registers, for those SOCs that have a PAMU device.
>  
> + - little-endian : Indicates that the global utilities block is little
> +   endian. The default is big endian.

The default is "the native endianness of the system". So absence on an 
ARM system would be LE. This property is valid for any simple-bus 
device, so it isn't really required to document per device. You can, but 
your description had better match the documented behaviour.

Rob

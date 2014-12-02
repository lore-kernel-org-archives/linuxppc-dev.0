Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3C1B1A048E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 15:40:03 +1100 (AEDT)
Message-ID: <1417495189.15957.209.camel@freescale.com>
Subject: Re: [PATCH] Documentation: bindings: net: DPAA corenet binding
 document
From: Scott Wood <scottwood@freescale.com>
To: <madalin.bucur@freescale.com>
Date: Mon, 1 Dec 2014 22:39:49 -0600
In-Reply-To: <1417169426-11823-1-git-send-email-madalin.bucur@freescale.com>
References: <1417169426-11823-1-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Igal.Liberman@freescale.com, Emilian.Medve@freescale.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-28 at 12:10 +0200, Madalin Bucur wrote:
> Add the device tree binding document for the DPAA corenet node
> and DPAA Ethernet nodes.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> ---
>  Documentation/devicetree/bindings/net/fsl-dpaa.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-dpaa.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl-dpaa.txt b/Documentation/devicetree/bindings/net/fsl-dpaa.txt
> new file mode 100644
> index 0000000..822c668
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-dpaa.txt
> @@ -0,0 +1,31 @@
> +*DPAA corenet
> +
> +The corenet bus containing all DPAA Ethernet nodes.

What does this have to do with corenet?

> +Required property
> + - compatible: string property.  Must include "fsl,dpaa". Can include
> +   also "fsl,<SoC>-dpaa".

No need for the <SoC> part.  As we previously discussed, the only
purpose of this node is backwards compatibility with the U-Boot MAC
address fixup -- if U-Boot doesn't look for the <SoC> version, then
don't complicate things.

Though, I can't find where U-Boot references this node.  Are you sure
it's not using the ethernet%d aliases like everything else, in which
case why do we need this node at all?

-Scott

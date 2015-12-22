Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 756711A11B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 14:42:23 +1100 (AEDT)
Message-ID: <1450755731.18314.76.camel@freescale.com>
Subject: Re: [RFC 1/1] powerpc: legacy serial port use device tree
 cell-index property
From: Scott Wood <scottwood@freescale.com>
To: Curt Brune <curt@cumulusnetworks.com>, <galak@codeaurora.org>,
 <ijc+devicetree@hellion.org.uk>, <mark.rutland@arm.com>,
 <pawel.moll@arm.com>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <robh+dt@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Date: Mon, 21 Dec 2015 21:42:11 -0600
In-Reply-To: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
References: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-25 at 10:46 -0800, Curt Brune wrote:
> Currently for PowerPC systems using device tree, the legacy serial
> ports are allocated in the order by which they are found in the device
> tree structure.
> 
> This can cause problems in cases where the device tree nodes are
> sysnthesized by an external program (kexec for example), which may not
> preserve the original order of the device tree nodes.  This in turn
> can result in the serial console changing from ttyS0 to ttyS1
> unexpectedly.
> 
> This patch uses the 'cell-index' property (if present) to map UART
> device tree nodes to legacy serial port number.  The cell-index
> property is widely used in all the Freescale .dts files for PowerPC.
> 
> Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
> ---
>  arch/powerpc/kernel/legacy_serial.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/legacy_serial.c
> b/arch/powerpc/kernel/legacy_serial.c
> index 7b750c4..b717133 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -164,6 +164,8 @@ static int __init add_legacy_soc_port(struct device_node
> *np,
>  	u64 addr;
>  	const __be32 *addrp;
>  	struct device_node *tsi = of_get_parent(np);
> +	int index = -1, len;
> +	u32 *indexp;
>  
>  	/* We only support ports that have a clock frequency properly
>  	 * encoded in the device-tree.
> @@ -188,14 +190,19 @@ static int __init add_legacy_soc_port(struct
> device_node *np,
>  	if (addr == OF_BAD_ADDR)
>  		return -1;
>  
> +	/* Check if the ports have an ordering, defined by 'cell-index' */
> +	if (((indexp = (u32*)of_get_property(np, "cell-index", &len)) !=
> NULL) &&
> +	    (len == sizeof(u32)))
> +		index = *indexp;

const u32 *

Or better, use of_read_number() or similar.

-Scott

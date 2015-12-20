Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DFD61A1A14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 02:06:42 +1100 (AEDT)
Date: Sun, 20 Dec 2015 09:02:25 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Curt Brune <curt@cumulusnetworks.com>
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com,
 pawel.moll@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/1] powerpc: legacy serial port use device tree cell-index
 property
Message-ID: <20151220150225.GA27380@gate.crashing.org>
References: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448477209-22340-2-git-send-email-curt@cumulusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2015 at 10:46:49AM -0800, Curt Brune wrote:
> +	/* Check if the ports have an ordering, defined by 'cell-index' */
> +	if (((indexp = (u32*)of_get_property(np, "cell-index", &len)) != NULL) &&
> +	    (len == sizeof(u32)))
> +		index = *indexp;
> +
>  	/* Add port, irq will be dealt with later. We passed a translated
>  	 * IO port value. It will be fixed up later along with the irq
>  	 */
>  	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
> -		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
> +		return add_legacy_port(np, index, UPIO_TSI, addr, addr,
>  				       NO_IRQ, legacy_port_flags, 0);
>  	else
> -		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
> +		return add_legacy_port(np, index, UPIO_MEM, addr, addr,
>  				       NO_IRQ, legacy_port_flags, 0);

What does this do if the value in cell-index is a duplicate. or the port
with that number is already created some other way?  Are the numbers in
cell-index global anyway, or relative to some parent device (I couldn't
find the documentation for this).


Segher

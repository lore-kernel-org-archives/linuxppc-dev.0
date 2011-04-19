Return-Path: <B07421@freescale.com>
Date: Tue, 19 Apr 2011 12:52:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH 1/2] powerpc: document the FSL MPIC message register
	binding
Message-ID: <20110419125214.560f4b99@schlenkerla.am.freescale.net>
In-Reply-To: <1303232375-25014-2-git-send-email-meador_inge@mentor.com>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-2-git-send-email-meador_inge@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Apr 2011 11:59:34 -0500
Meador Inge <meador_inge@mentor.com> wrote:

> +    - interrupt-parent: Specifies the interrupt parent of the message register
> +      block.  The type shall be a <phandle> and the value of that <phandle>
> +      shall point to the interrupt parent.

interrupt-parent is not required; it can be inherited from an ancestor.  In
any case, this description doesn't say anything specifically about MPIC
message nodes.

>  The default value shall be
> +      all a string of consecutive ones where the length of the run is equal
> +      to the number of registers in the block.  For example, a block with
> +      four registers shall default to 0xF.

Could be more simply worded as, "If not present, all message registers in
the group are available."

> +Required alias:
> +
> +    In order for a message register block to be discovered it *must* define
> +    an alias in the 'aliases' node.

I think the "in order to be discovered" statement is specific to your use
case.

>  Aliases are of the form 'msgr-block<n>',
> +    where <n> is an integer specifying the block's number.  Numbers shall start
> +    at 0.

The hw docs refer to "group A" and "group B", not "block 0" and "block 1".

Plus, I'd put "mpic-" in the alias name.

> +Example:
> +
> +	/* The aliases needed to define an order on the message register blocks.
> +	 */
> +	aliases {
> +		msgr-block0 = &msgr_block0;
> +		msgr-block1 = &msgr_block1;
> +	};
> +
> +	msgr_block0: msgr-block@41400 {
> +		compatible = "fsl,mpic-v3.1-msgr";
> +		reg = <0x41400 0x200>;
> +		// Message registers 0 and 3 in this block can receive interrupts on
> +		// sources 0xb0 and 0xb2, respectively.
> +		interrupts = <0xb0 2 0xb2 2>;
> +		msg-receive-mask = <0x5>;
> +		interrupt-parent = <&mpic>;
> +	};

A mask of 0x5 specifies message registers 0 and 2 (as do interrupts 0xb0
and 0xb2), not 0 and 3.

-Scott

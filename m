Return-Path: <B07421@freescale.com>
Date: Thu, 26 May 2011 15:06:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH v2 1/2] powerpc: document the FSL MPIC message register
	binding
Message-ID: <20110526150643.3e01f9a6@schlenkerla.am.freescale.net>
In-Reply-To: <1305909399-26969-2-git-send-email-meador_inge@mentor.com>
References: <1305909399-26969-1-git-send-email-meador_inge@mentor.com>
	<1305909399-26969-2-git-send-email-meador_inge@mentor.com>
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

On Fri, 20 May 2011 11:36:38 -0500
Meador Inge <meador_inge@mentor.com> wrote:

> This binding documents how the message register blocks found in some FSL
> MPIC implementations shall be represented in a device tree.
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 ++++++++++++++++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> new file mode 100644
> index 0000000..385dba6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> @@ -0,0 +1,62 @@
> +* FSL MPIC Message Registers
> +
> +This binding specifies what properties must be available in the device tree
> +representation of the message register groups found in some FSL MPIC
> +implementations.
> +
> +Required properties:
> +
> +    - compatible: Specifies the compatibility list for the message register
> +      block.  The type shall be <string> and the value shall be of the form
> +      "fsl,mpic-v<version>-msgr", where <version> is the version number of
> +      the MPIC containing the message registers.
> +
> +    - reg: Specifies the base physical address(s) and size(s) of the
> +      message register block's addressable register space.  The type shall be
> +      <prop-encoded-array>.
> +
> +    - interrupts: Specifies a list of interrupt source and level-sense pairs.
> +      The type shall be <prop-encoded-array>.  The length shall be equal to
> +      the number of bits set in the 'msg-receive-mask' property value.

Oh, just noticed -- mismatch between msg-receive-mask here...

> +
> +Optional properties:
> +
> +    - mpic-msgr-receive-mask: Specifies what registers in the containing block
> +      are allowed to receive interrupts.  The value is a bit mask where a set
> +      bit at bit 'n' indicates that message register 'n' can receive interrupts.
> +      The type shall be <prop-encoded-array>.  If not present, then all of
> +      the message registers in the block are available.

...and mpic-msgr-receive-mask here.

Might want to just say "equal to the number of registers that are
available for receiving interrupts", to more clearly apply to the case where
mpic-msgr-receive-mask is missing.

-Scott

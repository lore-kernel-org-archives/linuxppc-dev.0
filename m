Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 85CCA2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 02:05:07 +1000 (EST)
Subject: Re: [PATCH] Add device file bindings for MAPLE
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1375354963-11219-1-git-send-email-shaveta@freescale.com>
Date: Thu, 1 Aug 2013 11:05:09 -0500
Message-Id: <5C32ABF4-ECC3-4F1C-82D0-EA3AD9053575@kernel.crashing.org>
References: <1375354963-11219-1-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 1, 2013, at 6:02 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/maple.txt      |   30 =
++++++++++++++++++++
> 1 files changed, 30 insertions(+), 0 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/maple.txt
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/maple.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
> new file mode 100644
> index 0000000..da51c5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
> @@ -0,0 +1,30 @@
> +* Freescale MAPLE Multi Accelerator Platform Engine Baseband 3
> +  (MAPLE-B3)device nodes
> +
> +Supported chips:
> +Example: B4860
> +
> +Required properties:
> +
> +- compatible:	Should contain "fsl,maple-b3-liodn" as the value
> +		This identifies Multi Accelerator Platform Engine
> +		Baseband 3 block.This representation is required
> +		for doing the PAMU/LIODN programming on the Linux side.

This compatible makes no sense, we shouldn't be marking a full HW block =
with some name that is just intended for LIODN convenance.

Is this version 3 of the block?  If so a name like "fsl,maple-v3" or =
"fsl,maple-v3.0" would be more appropriate.

- k

> +
> +- reg:		offset and length of the register set for the =
device
> +
> +Devices that have LIODNs need to specify links to the parent PAMU =
controller
> +(the actual PAMU controller that this device is connected to) and a =
pointer to
> +the LIODN register, if applicable.


Does Maple not have any IRQs associated with it?

If you are going to have a minimal binding, at least cover the basics =
associated with a device.

> +
> +- fsl,iommu-parent
> +		: <phandle>
> +		This property should be present
> +
> +Example:
> +	/* B4860 */
> +	maple@800000 {
> +		compatible =3D "fsl,maple-b3-liodn";
> +		reg =3D <0x8000000 0x10000>;
> +		fsl,iommu-parent =3D <&pamu1>;
> +	};
> --=20
> 1.7.6.GIT
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

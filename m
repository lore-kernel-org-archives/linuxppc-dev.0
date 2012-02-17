Return-Path: <B08248@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2808B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 02:50:26 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPIC
 message register binding
Date: Fri, 17 Feb 2012 15:50:13 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15032F516B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329446943-9732-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1329446943-9732-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meador_inge@mentor.com" <meador_inge@mentor.com>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-relea=
se-
> bounces@linux.freescale.net] On Behalf Of Jia Hongtao-B38951
> Sent: Thursday, February 16, 2012 8:49 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: meador_inge@mentor.com; Li Yang-R58472; Jia Hongtao-B38951
> Subject: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPIC me=
ssage register
> binding
>=20
> This binding documents how the message register blocks found in some FSL =
MPIC implementations
> shall be represented in a device tree.
>=20
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 ++++++++++++++=
++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> new file mode 100644
> index 0000000..b4ae70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> @@ -0,0 +1,62 @@
> +* FSL MPIC Message Registers
> +
> +This binding specifies what properties must be available in the device
> +tree representation of the message register blocks found in some FSL
> +MPIC implementations.
> +
> +Required properties:
> +
> +    - compatible: Specifies the compatibility list for the message regis=
ter
> +      block.  The type shall be <string> and the value shall be of the f=
orm
> +      "fsl,mpic-v<version>-msgr", where <version> is the version number =
of
> +      the MPIC containing the message registers.

The type for compatibles is a <string-list>.

> +    - reg: Specifies the base physical address(s) and size(s) of the
> +      message register block's addressable register space.  The type sha=
ll be
> +      <prop-encoded-array>.
> +
> +    - interrupts: Specifies a list of interrupt source and level-sense p=
airs.
> +      The type shall be <prop-encoded-array>.  The length shall be equal=
 to
> +      the number of registers that are available for receiving interrupt=
s.

How many interrupts are there?   If more than 1,  this is where
you need to specify what each interrupt is for.

> +Optional properties:
> +
> +    - mpic-msgr-receive-mask: Specifies what registers in the containing=
 block
> +      are allowed to receive interrupts.  The value is a bit mask where =
a set
> +      bit at bit 'n' indicates that message register 'n' can receive int=
errupts.
> +      The type shall be <prop-encoded-array>.  If not present, then all =
of
> +      the message registers in the block are available.

Your example implies that this is 1 32-bit cell.  If that is the case then
this really should be of type '<u32>'.

Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AEDB12C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:06:38 +1000 (EST)
Received: from mail139-ch1 (localhost [127.0.0.1])	by
 mail139-ch1-R.bigfish.com (Postfix) with ESMTP id 8D66E18068B	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:06:32 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail139-ch1.bigfish.com (Postfix) with ESMTP id
 2347740006E	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:06:31
 +0000 (UTC)
Date: Fri, 14 Jun 2013 17:06:29 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
To: Minghuan Lian <Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-3-git-send-email-Minghuan.Lian@freescale.com>
 (from Minghuan.Lian@freescale.com on Fri Jun 14 02:15:57 2013)
Message-ID: <1371247589.2996.15@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 02:15:57 AM, Minghuan Lian wrote:
> Add compatible "fsl,mpic-msi-v4.3" for MPIC v4.3. MPIC v4.3 contains
> MSIIR and MSIIR1. MSIIR supports 8 MSI registers and MSIIR1 supports
> 16 MSI registers, but uses different IBS and SRS shift. When using
> MSIR1, the interrupt number is not consecutive. It is hard to use
> 'msi-available-ranges' to describe the ranges of the available
> interrupt and the ranges are related to the application, rather than
> the description of the hardware. this patch also removes
> 'msi-available-ranges' property.
>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 49 =20
> ++++++++++------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
>=20
> diff --git =20
> a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> index 5693877..e851e93 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> @@ -1,26 +1,23 @@
>  * Freescale MSI interrupt controller
>=20
>  Required properties:
> -- compatible : compatible list, contains 2 entries,
> +- compatible : compatible list, may contains one or two entries,
>    first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, =20
> mpc8572,
> -  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending =20
> on
> -  the parent type.
> +  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" or
> +  "fsl,mpic-msi-v4.3" depending on the parent type and version. If =20
> mpic
> +  version is 4.3, the number of MSI registers is increased to 16, =20
> MSIIR1 is
> +  provided to access these 16 registers, compatible =20
> "fsl,mpic-msi-v4.3"
> +  should be used.

Why "one or two"?  What does it look like in the case where there's =20
just one?

>  - reg : It may contain one or two regions. The first region should =20
> contain
>    the address and the length of the shared message interrupt =20
> register set.
> -  The second region should contain the address of aliased MSIIR =20
> register for
> -  platforms that have such an alias.
> -
> -- msi-available-ranges: use <start count> style section to define =20
> which
> -  msi interrupt can be used in the 256 msi interrupts. This property =20
> is
> -  optional, without this, all the 256 MSI interrupts can be used.
> -  Each available range must begin and end on a multiple of 32 (i.e.
> -  no splitting an individual MSI register or the associated PIC =20
> interrupt).
> +  The second region should contain the address of aliased MSIIR or =20
> MSIIR1
> +  register for platforms that have such an alias, if using MSIIR1, =20
> the second
> +  region must be added because different MSI group has different =20
> MSIRR1 offset.

Why are you removing msi-available-ranges?  It's not valid for MPIC =20
v4.3, but it's still valid for older MPICs.  It should move to the =20
optional section, though.

>  - interrupts : each one of the interrupts here is one entry per 32 =20
> MSIs,
>    and routed to the host interrupt controller. the interrupts should
> -  be set as edge sensitive.  If msi-available-ranges is present, only
> -  the interrupts that correspond to available ranges shall be =20
> present.
> +  be set as edge sensitive.
>=20
>  - interrupt-parent: the phandle for the interrupt controller
>    that services interrupts for this device. for 83xx cpu, the =20
> interrupts
> @@ -39,20 +36,18 @@ Optional properties:
>=20
>  Example:
>  	msi@41600 {
> -		compatible =3D "fsl,mpc8610-msi", "fsl,mpic-msi";
> -		reg =3D <0x41600 0x80>;
> -		msi-available-ranges =3D <0 0x100>;
> -		interrupts =3D <
> -			0xe0 0
> -			0xe1 0
> -			0xe2 0
> -			0xe3 0
> -			0xe4 0
> -			0xe5 0
> -			0xe6 0
> -			0xe7 0>;
> -		interrupt-parent =3D <&mpic>;
> -	};
> +	compatible =3D "fsl,mpic-msi";
> +	reg =3D <0x41600 0x200 0x44140 4>;

Why 0x200?

-Scott=

Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlR6f5b8mzDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 15:30:49 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Daniel Walker <danielwa@cisco.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>, Jaiprakash Singh
 <b44839@freescale.com>, Scott Wood <scottwood@freescale.com>, Lijun Pan
 <Lijun.Pan@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>
Subject: Re: t1040 IFC flash driver Extended Chip Select
Date: Thu, 7 Jul 2016 00:57:13 +0000
Message-ID: <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <577D68B8.8020305@cisco.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2016 03:23 PM, Daniel Walker wrote:=0A=
> Hi,=0A=
> =0A=
> We are using the t1040 platform, and we have found that we need to =0A=
> populate this register. In the Technical Reference Manual it's =0A=
> description is section 24.3.2. This option appears in the driver, but it =
=0A=
> doesn't appears to be used anyplace.=0A=
=0A=
I'm not sure what you mean by "in the driver".  U-boot sets these registers=
.=0A=
=0A=
> We we're considered adding something to the device tree to allow =0A=
> populating this value, but I'm wondering if any of you have specific =0A=
> considerations on how this is done. Or maybe it's not needed at all, and =
=0A=
> we're just missing something.=0A=
> =0A=
> (not a good patch, just an example.)=0A=
> =0A=
> diff --git =0A=
> a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt =0A=
> b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=0A=
> index 89427b0..b506001 100644=0A=
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=0A=
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=0A=
> @@ -24,6 +24,8 @@ Properties:=0A=
>   - ranges : Each range corresponds to a single chipselect, and covers=0A=
>              the entire access window as configured.=0A=
> =0A=
> +- cspr_ext : This value sets the extended chip select for all banks.=0A=
=0A=
I see no reason to put this here.  Boot software should be setting the=0A=
chipselect registers, and if for some reason you don't want to do that,=0A=
you could just translate the address through ranges to find the value to=0A=
write.  Why would you have the binding assume it's the same for all banks?=
=0A=
=0A=
The information that is missing from the device tree, that currently=0A=
must come from boot software programming the registers, is the various=0A=
attributes that get programmed in CSPR/CSOR.=0A=
=0A=
-Scott=0A=
=0A=

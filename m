Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A31412C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 09:36:39 +1000 (EST)
Date: Mon, 29 Jul 2013 18:36:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: P1021rdb-pc
To: BHARATHI KANDIMALLA <bharathik@icommtele.com>
In-Reply-To: <633176325F8AEB44967E1E3F9795BB22440FFEC9@TC-MX1.icommtele.local> (from
 bharathik@icommtele.com on Thu Jul 25 03:29:45 2013)
Message-ID: <1375140991.30721.65@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 03:29:45 AM, BHARATHI KANDIMALLA wrote:
> Dear Sir,
>=20
> We  are using  P1021rdb-pc   board  with p1021 processor.
>=20
> 1.  compilation and build process  is taking  so  much of time. How =20
> should I
> reduce the time for linux  build process?

Remove things from the .config that you don't need.

Be sure you're using a -j value that is large enough to keep all your =20
CPUs busy.

Use ccache.

Get a faster build machine. :-)

> 2.  In  kernel configuration  we are not able to select  P1021rdb., =20
> When we configured the  board for p1021RDB-PC ,  in  default kenel =20
> config  file   all the below platforms are selected , We want only  =20
> p1021rdb  , what should we select here?
>=20
>  CONFIG_PPC_CELL is not set
> CONFIG_FSL_SOC_BOOKE=3Dy
> CONFIG_FSL_85XX_CACHE_SRAM=3Dy
> CONFIG_MPC8540_ADS=3Dy
> CONFIG_MPC8560_ADS=3Dy
> CONFIG_MPC85xx_CDS=3Dy
> CONFIG_MPC85xx_MDS=3Dy
> CONFIG_MPC8536_DS=3Dy
> CONFIG_MPC85xx_DS=3Dy
> CONFIG_MPC85xx_RDB=3Dy

fsl,P1021RDB-PC is handled by mpc85xx_rdb.c (and thus =20
CONFIG_MPC85xx_RDB).

> 3. We are using  p1021 processor which has 36 bit support  , but we  =20
> have compiled uboot for 32 bit only.Is there any specfic use of 36 =20
> bit  compilation, ?

If your U-Boot is configured for 32 bits, there's no benefit to =20
enabling CONFIG_PHYS_64BIT (unless you're remapping things yourself, =20
such as moving the PCIe windows), and it can slow things down.

> 4. Now we are using  SDK 1.3.2  for  p1021 procesor .Is there any =20
> specific
> necessity that we should switch  to sdk1.4
> regarding linux drivers  specially included for  p1021 procesor?

It's generally good to use more recent code for the various =20
improvements and fixes it contains, but I don't know of a specific =20
p1021-related requirement.  Note that this list is for upstream Linux; =20
for help with Freescale SDKs go to https://community.freescale.com/

Also note that p1021rdb-pc is supported in upstream Linux; you do not =20
need to use the SDK at all unless there is something specific you need =20
beyond basic board support.

> 5.UMCC driver  is  available in  linux driver ?

No.

> where should I get some help regarding UMCC ?

community.freescale.com, support@freescale.com, or your sales/FAE =20
contact.

-Scott=

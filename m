Return-Path: <K.Stewart@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D156CDDEC6
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 06:46:01 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2GJjvSK024896
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:45:58 -0700 (MST)
Received: from az33exm21.fsl.freescale.net (az33exm21.am.freescale.net
	[10.64.32.7])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2GJjvEW028960
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 14:45:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][POWERPC] [004/006] Removed config options that we
	don'tsupport in embedded6xx
Date: Fri, 16 Mar 2007 12:45:57 -0700
Message-ID: <FC71C8AD27EC834C88291394CDB18EB001B65E7C@az33exm21.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0703161023390.9740@localhost.localdomain>
From: "Stewart Katherine-ra4863" <K.Stewart@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmm, a little bit more homework is needed, I believe.

A couple of the boards listed in your delete are still
active & available systems.  The two that caught my eye are:
PQ2FADS_VR : MPC82xx Family Application Development System=20
PQ2FADS ZU : MPC82xx Family Application Development System=20

Have all the formal maintainers of the boards listed for=20
removal from the config been consulted?

A reasonable list of the one's Freescale still has active can be found
at:=20
http://www.freescale.com/webapp/sps/site/taxonomy.jsp?nodeId=3D0162468rH3=
b
TdGJk19Pcqx
but I need to double check a couple of other spots, too.

Couple of minor comments in text.

Kate

> -----Original Message-----
> From: linuxppc-dev-bounces+k.stewart=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+k.stewart=3Dfreescale.com@ozlabs.org]On
> Behalf Of Kumar Gala
> Sent: Friday, March 16, 2007 10:24 AM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH][POWERPC] [004/006] Removed config options that we
> don'tsupport in embedded6xx
>=20
>=20
> When we started arch/powerpc we duplicated a number of config=20
> options from arch/ppc
> for various platforms that are supported.  Now that we=20
> actually support a few
> platforms, remove all the ones that haven't been moved over. =20
> Additionally, this
> cleanup moved the 82xx/PQ2 options over into=20
> arch/powerpc/platforms/82xx/Kconfig
> where they belong.  It also killed GEN550 which doesn't exist=20
> in arch/powerpc.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/Kconfig.debug                 |    3 +-
>  arch/powerpc/platforms/82xx/Kconfig        |   35 ++++
>  arch/powerpc/platforms/embedded6xx/Kconfig |  264=20
> +---------------------------
>  3 files changed, 38 insertions(+), 264 deletions(-)
>=20
<snip>

> +
> +config 8260
> +	bool "CPM2 Support" if WILLOW
> +	depends on 6xx
> +	default y if PQ2FADS
> +	help
> +	  The MPC8260 is a typical embedded CPU made by=20
> Motorola.  Selecting

while you're updating this, it should be corrected. Motorola
doesn't make these parts, Freescale does. =20

> +	  this option means that you wish to build a kernel for=20
> a machine with
> +	  an 8260 class CPU.
> +
> +config 8272
> +	bool
> +	depends on 6xx
> +	default y if ADS8272
> +	select 8260
> +	help
> +	  The MPC8272 CPM has a different internal dpram setup=20
> than other CPM2
> +	  devices
> +
> +config CPM2
> +	bool
> +	depends on 8260 || MPC8560 || MPC8555
> +	default y
> +	help
> +	  The CPM2 (Communications Processor Module) is a coprocessor on
> +	  embedded CPUs made by Motorola.  Selecting this

ditto change Motorola to Freescale
=20
> option means that
> +	  you wish to build a kernel for a machine with a CPM2=20
> coprocessor
> +	  on it (826x, 827x, 8560).
>  endmenu

<snip>

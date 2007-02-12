Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id F302DDDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:34:32 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1CKYSw7004584
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 13:34:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1CKYS31020276
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:34:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] mpc5200 device tree bindings refinement
Date: Mon, 12 Feb 2007 13:34:04 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
In-Reply-To: <11710062092006-git-send-email-grant.likely@secretlab.ca>
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	"Sylvain Munaut" <tnt@246tnt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Grant Likely
> Sent: Friday, February 09, 2007 1:30 AM

[snip]

>  3) The soc5200 node
>  -------------------
> -This node describes the on chip SOC peripherals.  Every mpc52xx based
> +This node describes the on chip SOC peripherals.  Every mpc5200 based
>  board will have this node, and as such there is a common naming
>  convention for SOC devices.
> =20
> @@ -125,71 +144,107 @@ name			type	=09
> description
>  device_type		string		must be "soc"
>  ranges			int		should be <0=20
> baseaddr baseaddr+10000>
>  reg			int		must be <baseaddr 10000>
> +compatible		string		mpc5200: "mpc5200-soc"
> +					mpc5200b:=20
> "mpc5200b-soc\0mpc5200-soc"
> +system-frequency	int		Fsystem frequency; source of all
> +					other clocks.
> +bus-frequency		int		IPB bus=20
> frequency in HZ.  Clock rate

My suggestion would be to _not_ create a brand new property
called system-frequency.  Could we not use the existing
clock-frequency property instead (defined to mean the
Fsystem frequency)?

Currently across many device types (e.g. PCI, serial) the
clock-frequency property is used to describe the clock
frequency in a way specific to that device.  Could that work
here?

If you did need to create a new property unique to this
particular device it should have the vendor name preprended
to the property (e.g. linux,phandle).

If this property is generally across all soc device types
the "soc" section in booting_without_of.txt should
be updated with a clear definition of what the property
means.

Stuart Yoder

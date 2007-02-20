Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 610B3DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:08:53 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KF8oI5022591
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:08:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KF8oFK518396
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:08:50 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KF8n0K021844
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:08:49 -0700
Subject: Re: [PATCH 12/14] Add device tree for Ebony
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070220021235.DC02DDDD06@ozlabs.org>
References: <20070220021235.DC02DDDD06@ozlabs.org>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 09:09:51 -0600
Message-Id: <1171984191.24204.84.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 13:12 +1100, David Gibson wrote:
> Add a device tree for the Ebony evaluation board (440GP based).  This
> tree is not complete or finalized.  This tree needs a very recent
> version of dtc to process.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
> 
>  arch/powerpc/boot/dts/ebony.dts |  225 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)
> 
> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-02-19 15:31:36.000000000 +1100
> @@ -0,0 +1,225 @@
> +/*
> + * Device Tree Source for IBM Ebony
> + *
> + * Copyright (c) 2006, 2007 IBM Corp.
> + * Josh Boyer <jdub@us.ibm.com>, David Gibson <dwg@au1.ibm.com>

That email address died about 2 weeks ago.  Feel free to change it to
this one: jwboyer@linux.vnet.ibm.com

> + *
> + * FIXME: Draft only!
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + *
> + * To build:
> + *   dtc -I dts -O asm -o ebony.S -b 0 -V 16 ebony.dts
> + *   dtc -I dts -O dtb -o ebony.dtb -b 0 -V 16 ebony.dts
> + */
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "Ebony";
> +	compatible = "Ebony";
> +	dcr-parent = <&/cpus/PowerPC,440GP@0>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,440GP@0 {
> +			model = "440GP Rev. C";
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <17d78400>; /* 400MHz FIXME: poke in zImage */
> +			timebase-frequency = <17d78400>; /* 400MHz FIXME: wrong, poke in zImage */
> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <0>;
> +			d-cache-size = <0>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 00000000 08000000>; /* Set by bootwrapper */
> +	};
> +
> +	UIC0: interrupt-controller { /* UIC0 */
> +		device_type = "interrupt-controller";
> +		compatible = "ibm,uic440gp", "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0c0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +
> +		UIC1: interrupt-controller@1 { /* UIC1 */
> +			device_type = "interrupt-controller";
> +			compatible = "ibm,uic440gp", "ibm,uic";
> +			interrupt-controller;
> +			cell-index = <1>;
> +			dcr-reg = <0d0 009>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <2>;
> +			interrupts = <1e 4 1f 4>; /* cascade */
> +		};
> +	};
> +
> +	plb {
> +		device_type = "ibm,plb";
> +		compatible = "ibm,plb-440gp", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		POB0: opb@0 {

I think you meant "OPB0:" for the label.

> +			device_type = "ibm,opb";
> +			compatible = "ibm,opb-440gp", "ibm,opb";

As I pointed out in an earlier email, this breaks working with the
current legacy_serial driver.  It's looking for a device_type of "opb".
I'm not sure if we should fix the driver or fix this and the
ebony_of_bus types in arch/powerpc/platforms/4xx/ebony.c

josh

Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3779DDE31
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 02:55:51 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2OFtlxU021497
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 08:55:47 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2OFtkEr013314
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 10:55:46 -0500 (CDT)
Date: Tue, 24 Mar 2009 10:55:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Simon Kagstrom <simon.kagstrom@ericsson.com>
Subject: Re: of_serial and device trees
Message-ID: <20090324155545.GA24778@ld0162-tx32.am.freescale.net>
References: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 09:49:59AM +0100, Simon Kagstrom wrote:
> My problem is that I can't figure out how to express this correctly in
> the device tree for the board. My device tree looks like this ("isf" is
> the name of the FPGA):
> 
> 	isf@c0020000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		reg = <c0020000 00020000>;
> 

Change this line to: ranges = <0 c0020000 00020000>;
This causes reg resources in child nodes to be properly translated.  What
you have above indicates that all 0x20000 bytes are for the driver of *this*
node.

Add compatible = "simple-bus".  This lets children of this node be probed
by of_platform drivers (make sure you list simple-bus when calling
of_platform_bus_probe), and in a few other places (like legacy_serial.c).

>                 isf_pic: isf_pic@4000 {
>                         device_type = "isf-pic";
>                         compatible = "isf-pic";
>                         interrupt-controller;
>                         clock-frequency = <0>;
>                         #address-cells = <0>;
>                         #interrupt-cells = <2>;
>                         reg = <4000 100>;
>                         built-in;
>                         interrupts = <4 1>;
>                         interrupt-parent = <&mpic>;

Ged rid of built-in, clock-frequency, and device_type.

Compatible should be of the form "vendor,device" -- and does "isf"
uniquely identify the specific FPGA logic, or are there other versions
out there (or likely to exist in the future)?  Note that there are some
bad examples in existing device trees that have yet to be fixed.

Node name should be interrupt-controller, not isf_pic.

>                         clock-frequency = <13ab6680>; /* 330Mhz */

Note that dts-v1 syntax has C-like constants, with decimal by default. 
I'm guessing you're working with a relatively old kernel?

> and thereafter calling a custom setup function for the FPGA interrupt
> controller. That appears to work fine, but I'm wondering how to get the
> serial ports detected properly by of_serial.

The simple-bus compatible, and ranges property, should do it.  I'm
guessing that your FPGA PIC driver isn't getting its register address
from the device tree, given that it works without the ranges property?

-Scott

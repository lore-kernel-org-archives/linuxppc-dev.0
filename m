Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 197F4B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 01:58:42 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB3Ewav9018328
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 15:58:36 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Fri, 3 Dec 2010 15:58:35 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012021847.09367.dargaud@lpsc.in2p3.fr>
	<1291321371.32570.415.camel@pasglop>
In-Reply-To: <1291321371.32570.415.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201012031558.35557.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> No. of_platform_drivers are more/less obsolete. Normal platform drivers
> can now be associated with a device-tree node just fine.

OK.

If my dts definition is thus:
		xps_acqui_data_0: xps-acqui-data@c9800000 {
			compatible = "xlnx,xps-acqui-data-3.00.a";
			interrupt-parent = <&xps_intc_0>;
			interrupts = < 0 2 >;
			reg = < 0xc9800000 0x10000 >;
			xlnx,family = "virtex4";
			xlnx,include-dphase-timer = <0x1>;
			xlnx,mplb-awidth = <0x20>;
			xlnx,mplb-clk-period-ps = <0x2710>;
			xlnx,mplb-dwidth = <0x40>;
			xlnx,mplb-native-dwidth = <0x40>;
			xlnx,mplb-p2p = <0x0>;
			xlnx,mplb-smallest-slave = <0x20>;
		} ;

What are the names I need to pass to platform_driver_register and 
platform_device_register_simple ? xps_acqui_data_0, xps-acqui-data or xps-
acqui-data-3.00.a ? None seem to call any init functions...

Why is there not a word about the functions platform_*_register in my various 
driver books ? LDD 3rd ed (O'Reilly), Writing LDD (Cooperstein) or LKD 
(Love)... Is it something specific to powerpc and the books are oriented x86 ? 
What's a good source, besides grepping the kernel to no end ?

-- 
Guillaume Dargaud
http://www.gdargaud.net/

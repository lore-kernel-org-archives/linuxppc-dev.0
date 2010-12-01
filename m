Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34036B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 03:36:04 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB1GZxP5007170
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 17:35:59 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Wed, 1 Dec 2010 17:35:58 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<1291205941.11595.9.camel@concordia>
In-Reply-To: <1291205941.11595.9.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012011735.58769.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I guess it depends how basic they are :)
> 
> If they're basic _powerpc_ driver questions then this is probably the
> right place.
> 
> But I'd say just ask and maybe someone will be able to help, or maybe
> they'll point you somewhere else.

OK, here goes then: how do I get the IRQ number so that I can install an 
interrupt handler on it ?

In my dts file I have:
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

In my minimal driver init, I have:
  first = MKDEV (my_major, my_minor);
  register_chrdev_region(first, count, NAME);
  cdev_init(my_cdev, &fops);
  cdev_add (my_cdev, first, count);
So far so good.

Now how do I connect the dots between the hardware definitions from the dts and 
my driver ?
I have:
# ll /proc/device-tree/plb@0/xps-acqui-data@c9800000/
-r--r--r--    1 root     root          27 Dec  1 16:26 compatible
-r--r--r--    1 root     root           4 Dec  1 16:26 interrupt-parent
-r--r--r--    1 root     root           8 Dec  1 16:26 interrupts
-r--r--r--    1 root     root          15 Dec  1 16:26 name
-r--r--r--    1 root     root           8 Dec  1 16:26 reg
-r--r--r--    1 root     root           8 Dec  1 16:26 xlnx,family
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,include-dphase-
timer
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-awidth
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-clk-period-ps
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-dwidth
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-native-dwidth
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-p2p
-r--r--r--    1 root     root           4 Dec  1 16:26 xlnx,mplb-smallest-
slave

But first I'm not sure where to find the IRQ in there, and also I'm not sure if 
reading the filesystem from a module is allowed.

How do I know if this interrupt is shared or not (is it important ?)

Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/

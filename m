Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id DCE21DDED5
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 22:57:54 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so4735822rvb.1
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 03:57:53 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 23 Feb 2009 17:27:53 +0530
Message-ID: <f234e2140902230357r16bc5083uebe1d1d28deb3ac5@mail.gmail.com>
Subject: Regarding Level/Edge of Interrupt sense values
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I created a device node for gpio-controller for evaluation board
mpc83313erdb. I created the dtb and loaded on target and the interrupt
is generated successfully.

But in dts at interrupts = <74 0x2> I set sense as Edge (sense== 2:
Edge, high-to-low change),  when I load the driver module and checked
the entry in /proc/interrupts it shows the sense as Level i.e. 8
(sense == 8: Level, low assertion) as follows;

74:          1   IPIC   Level     gpio

Following is gpio-controller device tree node;

gpio-controller@c00 {
		#gpio-cells = <2>;
		compatible = "fsl,mpc8313-gpio", "fsl,mpc8349-gpio";
		reg = <0xc00 0x100>;
		interrupts = <74 0x2>;
		interrupt-parent = <&ipic>;
		gpio-controller;
                              };

Could anyone please tell what could be the reason ? ? ? Am I missing
something ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

##################### Start ############################
cat /proc/interrupts

          CPU0
 16:        162   IPIC   Level     serial
 19:         43   IPIC   Level     i2c-mpc
 20:          1   IPIC   Level     i2c-mpc
 22:          2   IPIC   Edge      phy_interrupt
 32:          0   IPIC   Level     enet_error
 33:        765   IPIC   Level     enet_rx
 34:          3   IPIC   Level     enet_tx
 35:          0   IPIC   Level     enet_error
 36:          0   IPIC   Level     enet_rx
 37:         15   IPIC   Level     enet_tx
 38:          0   IPIC   Edge      ehci_hcd:usb1
 72:          0   IPIC   Level     gtm timer
 74:          1   IPIC   Level     gpio
 77:      51451   IPIC   Level     fsl-elbc
 80:          0   IPIC   Level     pmc
BAD:          0
###################### END ############################

Return-Path: <spamreceptor@yahoo.com>
Received: from web30107.mail.mud.yahoo.com (web30107.mail.mud.yahoo.com
	[209.191.69.39]) by ozlabs.org (Postfix) with SMTP id 56DE0DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 04:27:55 +1100 (EST)
Date: Wed, 3 Dec 2008 09:27:54 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: Help with DTS file on MPC8313e-rdb board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <193995.57491.qm@web30107.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I need some help interpreting the DTS file for this
board such that I can change it to support our new
Phy.  Here is what the DTS file shows unmodified:

		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			phy1: ethernet-phy@1 {
				interrupt-parent = < &ipic >;
				interrupts = <13 8>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
			phy4: ethernet-phy@4 {
				interrupt-parent = < &ipic >;
				interrupts = <14 8>;
				reg = <4>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <25 8 24 8 23 8>;
			interrupt-parent = < &ipic >;
			phy-handle = < &phy1 >;
		};

		ethernet@25000 {
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <22 8 21 8 20 8>;
			interrupt-parent = < &ipic >;
			phy-handle = < &phy4 >;
		};

What I don't know is what reg = <4> means.  Is that
the phy address or the interrupt?  For this board that
phy uses IRQ4 and has its address wired to 4.  I would
guess it is the IRQ since there is also a phy address
of 0x1c but that does not appear in this DTS file
anywhere.  

My phy is the National semi dp83848.  It does not use
an IRQ.  Should I replace this with zero?  Should I
take that line out of the DTS file?

Thanks.


      

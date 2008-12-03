Return-Path: <spamreceptor@yahoo.com>
Received: from web30104.mail.mud.yahoo.com (web30104.mail.mud.yahoo.com
	[209.191.69.36]) by ozlabs.org (Postfix) with SMTP id 30EA3DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 07:11:44 +1100 (EST)
Date: Wed, 3 Dec 2008 12:11:43 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: Help with DTS file on MPC8313e-rdb board
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4936C547.6060409@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <359722.47085.qm@web30104.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for that info Scott.  However I am still stuck.

Please take a look at how I adjusted the DTS:
		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			phy3: ethernet-phy@3 {
				reg = <3>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				reg = <1>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			phy-handle = < &phy1 >;
		};

		ethernet@25000 {
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			phy-handle = < &phy3 >;
		};


Also note that our new PHY does not support gbit. 
I've made sure that the HCW is set for MII and not
GMII which allowed us to load the kernel via uboot and
TFTP.  Even though the phy is still blinking away, we
see no data come out of the board after TFTP is done. 
  Here's the screen dump.  Note that it looks like the
kernel is happy.  Also note that we tested our
192.168.1.21 NFS server and it can connect fine and
has no firewall. 


Thanks again

--- Scott Wood <scottwood@freescale.com> wrote:

> Joe Shmo wrote:
> > What I don't know is what reg = <4> means.  Is
> that
> > the phy address or the interrupt? 
> 
> It's the PHY address.
> 
> > My phy is the National semi dp83848.  It does not
> use
> > an IRQ.  Should I replace this with zero?  Should
> I
> > take that line out of the DTS file?
> 
> You should remove the interrupts and
> interrupt-parent properties.
> 
> -Scott
> 



      

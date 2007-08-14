Return-Path: <joe.hamman@embeddedspecialties.com>
Received: from mail.embeddedspecialties.com (mail.embeddedspecialties.com
	[74.94.113.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D734DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 13:29:49 +1000 (EST)
From: "Joe Hamman" <joe.hamman@embeddedspecialties.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <1187044669.10295.4.camel@server>
	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>
Subject: RE: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
Date: Mon, 13 Aug 2007 22:29:44 -0500
Message-ID: <013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: joe.hamman@embeddedspecialties.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, August 13, 2007 10:10 PM
> To: joe.hamman@embeddedspecialties.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be
> configurable
> 
> 
> On Aug 13, 2007, at 5:37 PM, Joe Hamman wrote:
> 
> > Allow the address of the Ten Bit Interface (TBI) to be changed in the
> > event of a conflict with another device.
> >
> > Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>
> > ---
> >
> > Please ignore the last patch - I missed a cut & paste error on the
> > range
> > that my testing didn't catch.
> 
> I think we'd rather this came from the device tree.
> 
Duh, that makes sense ;-)

Has there been any discussion yet?  Maybe something like this:

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			phy0: ethernet-phy@0 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <0>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
			phy2: ethernet-phy@2 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <2>;
				device_type = "ethernet-phy";
			};
			phy3: ethernet-phy@3 {
				interrupt-parent = <&mpic>;
				interrupts = <a 1>;
				reg = <3>;
				device_type = "ethernet-phy";
			};
			tbi:  ethernet-tbi@1f {
				reg = <1f>;
				device_type = "ethernet-tbi";
			};
		};

Thanks,
Joe

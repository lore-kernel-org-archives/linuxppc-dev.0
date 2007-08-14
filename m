Return-Path: <joe.hamman@embeddedspecialties.com>
Received: from mail.embeddedspecialties.com (mail.embeddedspecialties.com
	[74.94.113.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 413D9DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 07:01:22 +1000 (EST)
From: "Joe Hamman" <joe.hamman@embeddedspecialties.com>
To: "'Andy Fleming'" <afleming@freescale.com>,
	"'Scott Wood'" <scottwood@freescale.com>
References: <1187044669.10295.4.camel@server>	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>	<013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
	<1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
	<46C1D553.4000201@freescale.com>
	<018801c7de93$43390e80$6f00a8c0@ESIDT>
	<46C1EDAA.3070402@freescale.com>
	<66FE71AE-6AF2-4A2F-91D0-6517B0702C13@freescale.com>
Subject: RE: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
Date: Tue, 14 Aug 2007 16:01:15 -0500
Message-ID: <020101c7deb6$4168cd70$6f00a8c0@ESIDT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <66FE71AE-6AF2-4A2F-91D0-6517B0702C13@freescale.com>
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

Hi Andy,

> >
> > Is any given board going to have at runtime (i.e. not jumper
> > selectable)  both a phy and a tbi (I'm not very familiar with the
> > latter, so I apologize if this is a dumb question).  If not, I'd
> > stick with phy-handle and have something in the phy node to
> > indicate that it's tbi.
> 
> 
> Yes.  That will be the more common case.  The TBI PHYs are connected
> to the MDIO pins of each TSEC.  The TBIPA register defines what
> address it sits on.  It is used to configure non MII-style data
> connections, usually to another PHY.  For instance, to configure a
> TSEC for SGMII, you first configure the attached TBI to communicate
> with the on-chip SERDES.
> 
> While the TBI devices technically all sit on MDIO busses, only the
> TBI PHY connected to the first TSEC will interfere with MDIO
> transactions.  I don't think we need to create nodes for each of the
> TBIs.  They exist as a secondary part of the ethernet controller, and
> their address is only really important to that controller.
> 
> I still think it should just be a property of the ethernet node.  We
> aren't describing the TBI, we're describing a setting for the
> ethernet controller's register.
> 

Like this?  Do we need to have one for each ethernet@xxxxxx?

	ethernet@24000 {
		#address-cells = <1>;
		#size-cells = <0>;
		device_type = "network";
		model = "eTSEC";
		compatible = "gianfar";
		reg = <24000 1000>;
		mac-address = [ 00 E0 0C 00 73 00 ];
		interrupts = <1d 2 1e 2 22 2>;
		interrupt-parent = <&mpic>;
		phy-handle = <&phy1f>;
		tbi-address = <0x1e>;
	};

Joe

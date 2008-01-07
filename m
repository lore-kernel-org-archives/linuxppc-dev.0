Return-Path: <rmcguire@videopresence.com>
Received: from smtpout04-01.prod.mesa1.secureserver.net
	(smtpout04-01.prod.mesa1.secureserver.net [64.202.165.196])
	by ozlabs.org (Postfix) with SMTP id 19685DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Jan 2008 21:55:37 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org><000001c84b47$50b0e2b0$6405a8c0@absolut>
	<20071231111443.4c6d8691@kernel.crashing.org>
Subject: 83xx, ucc_geth, kernel 2.6.23, IP-Config: No network devices
Date: Mon, 7 Jan 2008 02:54:53 -0800
Message-ID: <000001c8511b$bc0c03d0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20071231111443.4c6d8691@kernel.crashing.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, I am still stuck on this. 
Why isn't probe being called on any of the Freescale network device drivers?

I can see the Generic MII PHY Driver being registered.
The UCC_GETH and UCC_GETH_MDIO both being registered. 

An for fun, I even modified the Marvell PHY driver devices ID's to correctly
identify a National part that I am using, and I see this registering.

I would appear all the appropriate entries are in the .dts file
for each the different parts (mdio, ucc_geth, ucc_geth_mdio, phy0).

And yet still no probe functions get called for any of those drivers?

I need this to NFS boot, into the ELDK 4.1 file system.

Does anyone have an example of the 2.6.23 kernel working DTS files for a
Freescale 8360 that they are using NFS Booting for? Has anyone proofed this
out, or is everyone else using this as a module or driver that doesn't kick
until after the root file system is loaded?  

Alternatively is there something specific perhaps U-boot is populating in
the OF structure that is preventing my Ethernet phy from being recognized in
the linux kernel? Why are none of the probe functions being called?

-Russ 
> -----Original Message-----
> From: Vitaly Bordug [mailto:vitb@kernel.crashing.org]
> Sent: Monday, December 31, 2007 12:15 AM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: 83xx, ELDK 2.6.23, IP-Config: No network devices
> 
> On Sun, 30 Dec 2007 16:51:44 -0800
> Russell McGuire wrote:
> 
> > 1) Is there some basic kernel feature I am missing? I have enabled
> > the GIGE UEC GETH driver in the kernel.  Perhaps a PHY LIB? Isn't
> > generic MII supported by default?
> >
> yes you will need phylib
> 
> > 2) Is there something in the startup board files, that I need to add
> > to register my PHY like an of_put_node()? Again I have pretty much
> > copied the MPC8360E MDS board and it is starting, and defining the
> > par_io port already, except that my PHY ID <on the iC2 bus, is using
> > dev ID 0x01>. However, I don't see the probe function being called,
> > so I don't think this is a concern yet.
> I think you will need to write a driver for your specific PHY access to
> get it covered by phy abstraction layer.
> Generic mii thing is useful when it has access to phy regs somehow (live
> examples are some BCM phys that do not have specs
> available but the thing works using generic mii and standard phy regs).

Return-Path: <rmcguire@videopresence.com>
Received: from smtpout04-01.prod.mesa1.secureserver.net
	(smtpout04-01.prod.mesa1.secureserver.net [64.202.165.196])
	by ozlabs.org (Postfix) with SMTP id AFC48DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 00:00:50 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Jochen Friedrich'" <jochen@scram.de>
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org><000001c84b47$50b0e2b0$6405a8c0@absolut>	<20071231111443.4c6d8691@kernel.crashing.org>
	<000001c8511b$bc0c03d0$6405a8c0@absolut>
	<47820A60.2040500@scram.de>
Subject: RE: 83xx, ucc_geth, kernel 2.6.23, IP-Config: No network devices
Date: Mon, 7 Jan 2008 04:59:52 -0800
Message-ID: <000401c8512d$3b9d93a0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <47820A60.2040500@scram.de>
Cc: linuxppc-embedded@ozlabs.org
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

Joch,

Thanks, apparently I had a conditional that was not matching up around that
call. So now that I 'am' calling the of_platform_bus_probe(). I can see all
the probe functions getting called.  Thank you very much.

Next question, I can see that 'quick' mods I have made to the Marvell driver
are indeed matching up with the device ID that the Freescale MII device is
pulling back from my 'National' part. <I'll make a real phy driver once I
get this working>. I.e. I can see the phy_probe get called when this Id is
registered.  You can see the extra debug messages above the National DP83865
device registration, and the probe returns 0 for success I assume. <err =
0>.

I am still getting the "IP-Config: No network devices" error before the NFS
boot tries to take place.

BootLog:

RWM DEBUG, uec_mdio_init:278
RWM DEBUG, uec_mdio_probe:145
UCC Ethernet Controller MII Bus: probed
UCC Ethernet Controller MII Bus: Registered
ucc_geth: QE UCC Gigabit Ethernet Controller
Marvell 88E1101: Registered new driver
Marvell 88E1112: Registered new driver
Marvell 88E1111: Registered new driver
RWM DEBUG: phy_probe:635
RWM DEBUG: phy_probe:663 err = 0
National DP83865: Registered new driver
Marvell 88E1145: Registered new driver
HDLC support module revision 1.21
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (16 seconds)
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
lec.c: Dec 18 2007 15:30:33 initialized
mpc.c: Dec 18 2007 15:30:31 initialized
IP-Config: No network devices available.
.... NFS boot fails

-Russ
> -----Original Message-----
> From: Jochen Friedrich [mailto:jochen@scram.de]
> Sent: Monday, January 07, 2008 3:18 AM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: 83xx, ucc_geth, kernel 2.6.23, IP-Config: No network devices
> 
> Hi Russell,
> 
> > I would appear all the appropriate entries are in the .dts file
> > for each the different parts (mdio, ucc_geth, ucc_geth_mdio, phy0).
> >
> > And yet still no probe functions get called for any of those drivers?
> 
> Do you export the subtree using of_platform_bus_probe()?
> 
> Thanks,
> Jochen

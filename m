Return-Path: <robert.sciuk@exfo.com>
Received: from smtpinqc.exfo.com (smtpinqc.exfo.com [206.162.164.97])
 by ozlabs.org (Postfix) with ESMTP id 6E719B702E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 05:35:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: FW: P4080 device tree problems with fsl dpaa ...
Date: Mon, 17 Oct 2011 14:34:54 -0400
Message-ID: <2DD52030B5146141BEB762A11AE97C4CF6E2E7@SPQCEXC05.exfo.com>
In-reply-to: <CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com>
References: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com>
 <CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Thomas De Schampheleire" <patrickdepinguin+linuxppc@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: patrickdepinguin@gmail.com [mailto:patrickdepinguin@gmail.com] =
On
> Behalf Of Thomas De Schampheleire
> Sent: Monday, October 17, 2011 5:01 AM
> To: Robert Sciuk
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: FW: P4080 device tree problems with fsl dpaa ...
>=20
> Hi Robert,

[my stuff snipped]
>=20
> > I have no idea what an OH binding is, what it might look like, and
> what it entails, but I think that it might be a significant factor in
> our not seeing a working interface. =A0Has anyone any experience with
> dpaa device trees, and configuration? =A0Any pointers? =A0Any docs? =
Shots
> in the dark?
>=20
> We are using a device tree on p4080 with a dpaa configuration, yes.
> I also don't know about the OH bindings, but I have a vague memory of
> us having that message too, and it not being a real problem.
>=20

Other indicators concur with your assessment, and suggest that I back =
those nodes out as well. =20


> What I do know is that the device tree is very easy to get wrong, and
> that it should match your hardware precisely. I'm not using the same
> configuration as you are (there are no MDIO devices between our phy
> and dTSEC) so the device tree looks a little different.

Would it be possible to have a look at the relevant portions of your dev =
tree?



>=20
> Are you using the reference design or is this custom?

This is a custom design, and is an ATCA blade.


> Did you have a look at the device tree in the linux kernel sources?
> (arch/powerpc/boot/dts/p4080.dts). Does this configuration match
> yours? In that configuration, there are separate nodes of type
> p4080ds-mdio, inside the main mdio node.

We actually used the 36 bit tree (we plan to ship the boards with 16G =
initially, and up to 32G eventually).  I've also re-worked the tree from =
the LTIB (System Builder) in an attempt to get this to work.  Our design =
differs significantly from the P4080DS in that there exists no MUX =
between the bus and phy ... and there is no PIXIS FPGA to do all the =
clocking and startup stuff.=20

I've modified u-boot to assign mac addresses based upon our OUI, and the =
MACs all seem to be configured properly coming out of firmware, the =
ifconfig on the Linux side recognizes all of our 6 interfaces ...


>=20
> Is your phy configured correctly? Are there any boot messages about
> this? Can you check its registers?
> The same for the mdio.

There is some question about the TBI initialization, and we are tracing =
that as we speak ...

>=20
> Some generic pointers:
> * If you set CONFIG_PROC_DEVICETREE in the kernel config, you can read
> out the device-tree at runtime in /proc/device-tree. This helps in
> verifying whether the nodes you programmed actually appear in the
> running system.

Ack.

>=20
> * The /sys/devices directory can also be useful in identifying
> potential problems for unfound devices (which does not appear to be
> your case).
>=20
=20
Ack.  Also using /proc/interrupts ...


> * Can you step through the code, e.g. with a JTAG debugger? Try
> following the transmit path in the dpaa_eth driver. Maybe something
> errors out prematurely.
>=20

With some headaches ... using codewarrior, and getting assembly level =
tracing ...

> Best regards,
> Thomas

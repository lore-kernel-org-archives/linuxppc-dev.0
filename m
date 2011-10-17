Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BB0B0B6F8F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 20:01:30 +1100 (EST)
Received: by vcbfl13 with SMTP id fl13so1795262vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2011 02:01:26 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com>
References: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com>
Date: Mon, 17 Oct 2011 11:01:26 +0200
Message-ID: <CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com>
Subject: Re: FW: P4080 device tree problems with fsl dpaa ...
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Robert Sciuk <robert.sciuk@exfo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Robert,

On Fri, Oct 14, 2011 at 11:57 PM, Robert Sciuk <robert.sciuk@exfo.com> wrot=
e:
>
>
> -----Original Message-----
> From: Robert Sciuk
> Sent: Friday, October 14, 2011 5:27 PM
> To: 'devicetree-discuss@lists.ozlabs.org'
> Subject: P4080 device tree problems with fsl dpaa ...
>
> I've just joined the list, and I hope that this is not an inappropriate q=
uestion, but I'm looking for some direction with respect to device trees, a=
nd the fsl, dpaa Ethernet drivers.
>
> I'm wondering if anyone has had any experience with the FreeScale DPAA dr=
ivers for the 1g dtsec interface. =A0We are getting interfaces defined, and=
 the tx count increases, but we are not seeing packets on the "wire".
>
> ...
> [ =A0 =A00.911592] Freescale FM module (Oct 13 2011:14:41:07)
> [ =A0 =A00.916745] cpu6/6: fsl_mac: FSL FMan MAC API based driver ()
> [ =A0 =A00.923077] cpu6/6: fsl_mac: ffe4e0000.ethernet: FMan dTSEC versio=
n: 0x08240101
> [ =A0 =A00.930403] cpu6/6: fsl_mac: ffe4e0000.ethernet: FMan MAC address:=
 00:a0:a9:be:ef:10
> ...
> [ =A0 =A01.015863] cpu6/6: fsl_dpa: FSL DPAA Ethernet driver ()
> [ =A0 =A01.021446] cpu6/6: fsl_dpa: ethernet.23: dpaa_eth.c:1684:dpa_bp_c=
reate() eth%d: Using private BM buffer pools
> [ =A0 =A01.032263] cpu6/6: Using dynamic RX QM frame queues
> [ =A0 =A01.037242] cpu6/6: Using dynamic TX QM frame queues
> [ =A0 =A01.042263] cpu6/6: > WARNING (FM) [/export2/rd2/dev/robsci1/Work/=
gold/wr4linux-layer/obj/hotwire1/hotwire1/build/linux/drivers/n
> et/dpa/NetCommSw/Peripherals/FM/fm.c:911 FmGetSetPortParams]:
> [ =A0 =A01.059138] cpu6/6: FIFO size enlarged to 11008
> [ =A0 =A01.063670] cpu6/6:
> [ =A0 =A01.066672] cpu6/6: fsl_dpa: ethernet.23: dpaa_eth.c:2327:dpaa_oh_=
probe() no OH port bindings on node /fsl,dpaa/ethernet@0
> [ =A0 =A01.077806] cpu6/6: fsl_dpa: ethernet.24: dpaa_eth.c:1684:dpa_bp_c=
reate() eth%d: Using private BM buffer pools
> [ =A0 =A01.087826] cpu6/6: Using dynamic RX QM frame queues
> [ =A0 =A01.092798] cpu6/6: Using dynamic TX QM frame queues
> ...
>
> Our device tree defines the top level Ethernet as:
> ethernet@0 {
> =A0compatible =3D "fsl,p4080-dpa-ethernet", "fsl,dpa-ethernet";
> =A0fsl,qman-channel =3D <0x13>;
> =A0fsl,fman-mac =3D <0x50>;
> };
>
> And the mac and phys are defined as follows:
>
> ethernet@e0000 {
> =A0cell-index =3D <0x0>;
> =A0compatible =3D "fsl,p4080-fman-1g-mac", "fsl,fman-1g-mac";
> =A0reg =3D <0xe0000 0x1000>;
> =A0fsl,port-handles =3D <0x22 0x23>;
> =A0tbi-handle =3D <0x24>;
> =A0phy-handle =3D <0x25>;
> =A0phy-connection-type =3D "sgmii";
> =A0ptimer-handle =3D <0x26>;
> =A0linux,phandle =3D <0x50>;
> };
> mdio@e1120 {
> =A0#address-cells =3D <0x1>;
> =A0#size-cells =3D <0x0>;
> =A0compatible =3D "fsl,fman-mdio";
> =A0reg =3D <0xe1120 0xee0>;
> =A0interrupts =3D <0x64 0x1 0x0 0x0>;
> =A0gpios =3D <0x27 0x0 0x0 0x27 0x1 0x0>;
> =A0linux,phandle =3D <0x28>;
> =A0tbi-phy@8 {
> =A0reg =3D <0x8>;
> =A0device_type =3D "tbi-phy";
> =A0linux,phandle =3D <0x24>;
> =A0};
> =A0phy0: ethernet-phy@0 {
> =A0device_type=3D"ethernet-phy";
> =A0compatible=3D"broadcom,BCM5482";
> =A0reg =3D <0>;
> =A0linux,phandle =3D <0x25>;
> =A0};
> };
>
>
> I have no idea what an OH binding is, what it might look like, and what i=
t entails, but I think that it might be a significant factor in our not see=
ing a working interface. =A0Has anyone any experience with dpaa device tree=
s, and configuration? =A0Any pointers? =A0Any docs? Shots in the dark?

We are using a device tree on p4080 with a dpaa configuration, yes.
I also don't know about the OH bindings, but I have a vague memory of
us having that message too, and it not being a real problem.

What I do know is that the device tree is very easy to get wrong, and
that it should match your hardware precisely. I'm not using the same
configuration as you are (there are no MDIO devices between our phy
and dTSEC) so the device tree looks a little different.

Are you using the reference design or is this custom?
Did you have a look at the device tree in the linux kernel sources?
(arch/powerpc/boot/dts/p4080.dts). Does this configuration match
yours? In that configuration, there are separate nodes of type
p4080ds-mdio, inside the main mdio node.

Is your phy configured correctly? Are there any boot messages about
this? Can you check its registers?
The same for the mdio.

Some generic pointers:
* If you set CONFIG_PROC_DEVICETREE in the kernel config, you can read
out the device-tree at runtime in /proc/device-tree. This helps in
verifying whether the nodes you programmed actually appear in the
running system.

* The /sys/devices directory can also be useful in identifying
potential problems for unfound devices (which does not appear to be
your case).

* Can you step through the code, e.g. with a JTAG debugger? Try
following the transmit path in the dpaa_eth driver. Maybe something
errors out prematurely.

Best regards,
Thomas

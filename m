Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 65F5EB6F91
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 18:57:25 +1100 (EST)
Received: by vws20 with SMTP id 20so127080vws.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 00:57:21 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4CF6E2E7@SPQCEXC05.exfo.com>
References: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com>
 <CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4CF6E2E7@SPQCEXC05.exfo.com>
Date: Tue, 18 Oct 2011 09:57:21 +0200
Message-ID: <CAAXf6LWTU_OVBLfn4Tavo6JxE5UfoN8JuCidB4fbr4-RX+XdAw@mail.gmail.com>
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

On Mon, Oct 17, 2011 at 8:34 PM, Robert Sciuk <robert.sciuk@exfo.com> wrote=
:
>
>
>> -----Original Message-----
>> From: patrickdepinguin@gmail.com [mailto:patrickdepinguin@gmail.com] On
>> Behalf Of Thomas De Schampheleire
>> Sent: Monday, October 17, 2011 5:01 AM
>> To: Robert Sciuk
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: FW: P4080 device tree problems with fsl dpaa ...
>>
>> Hi Robert,
>
> [my stuff snipped]
>>
>> > I have no idea what an OH binding is, what it might look like, and
>> what it entails, but I think that it might be a significant factor in
>> our not seeing a working interface. =A0Has anyone any experience with
>> dpaa device trees, and configuration? =A0Any pointers? =A0Any docs? Shot=
s
>> in the dark?
>>
>> We are using a device tree on p4080 with a dpaa configuration, yes.
>> I also don't know about the OH bindings, but I have a vague memory of
>> us having that message too, and it not being a real problem.
>>
>
> Other indicators concur with your assessment, and suggest that I back tho=
se nodes out as well.
>
>
>> What I do know is that the device tree is very easy to get wrong, and
>> that it should match your hardware precisely. I'm not using the same
>> configuration as you are (there are no MDIO devices between our phy
>> and dTSEC) so the device tree looks a little different.
>
> Would it be possible to have a look at the relevant portions of your dev =
tree?
>
>

Sure.
The following snippets are for two SGMII devices on the second FMAN:

First the ports:

// RX
                        fman1_rx2: port@8a000 {
                                compatible =3D
"fsl,p4080-fman-port-1g-rx", "fsl,fman-port-1g-rx";
                                reg =3D <0x8a000 0x1000>;
                                fsl,liodn =3D <0x2d>;
         // Logical Input/Output Device Number used by PAMU
                                cell-index =3D <2>;
         // 1G index
                        };
                        fman1_rx3: port@8b000 {
                                compatible =3D
"fsl,p4080-fman-port-1g-rx", "fsl,fman-port-1g-rx";
                                reg =3D <0x8b000 0x1000>;
                                fsl,liodn =3D <0x2e>;
         // Logical Input/Output Device Number used by PAMU
                                cell-index =3D <3>;
         // 1G index
                        };
// TX
                        fman1_tx2: port@aa000 {
                                compatible =3D
"fsl,p4080-fman-port-1g-tx", "fsl,fman-port-1g-tx";
                                reg =3D <0xaa000 0x1000>;
                                fsl,qman-channel-id =3D <0x63>;
         // Direct-HW-Portal 1: SP3
                                cell-index =3D <2>;
         // 1G index
                        };
                        fman1_tx3: port@ab000 {
                                compatible =3D
"fsl,p4080-fman-port-1g-tx", "fsl,fman-port-1g-tx";
                                reg =3D <0xab000 0x1000>;
                                fsl,qman-channel-id =3D <0x64>;
         // Direct-HW-Portal 1: SP4
                                cell-index =3D <3>;
         // 1G index
                        };

Then the TSECs:
                        enet7: ethernet@e4000 { // dTSEC3
                                compatible =3D "fsl,p4080-fman-1g-mac",
"fsl,fman-1g-mac";
                                reg =3D <0xe4000 0x1000>;
                                fixed-link =3D <7 1 1000 0 0>;
         // Use fixed settings because there is no MDIO bus between
SOC and PHY
                                local-mac-address =3D [00 BA 0B AB 00 0A];
                                fsl,port-handles =3D <&fman1_rx2
&fman1_tx2>;     // RX + TX port
                                phy-connection-type =3D "sgmii";
         // 1Gb
                                cell-index =3D <2>;
                        };
                        enet8: ethernet@e6000 { // dTSEC4
                                compatible =3D "fsl,p4080-fman-1g-mac",
"fsl,fman-1g-mac";
                                reg =3D <0xe6000 0x1000>;
                                fixed-link =3D <8 1 1000 0 0>;
         // Use fixed settings because there is no MDIO bus between
SOC and PHY
                                local-mac-address =3D [00 BA 0B AB 00 0B];
                                fsl,port-handles =3D <&fman1_rx3
&fman1_tx3>;     // RX + TX port
                                phy-connection-type =3D "sgmii";
         // 1Gb
                                cell-index =3D <3>;
                        };

The ethernet devices in the fsl,dpaa node:
                ethernet@7 {
                        compatible =3D "fsl,p4080-dpa-ethernet",
"fsl,dpa-ethernet";
                        fsl,qman-channel =3D <&qportal0>;
                        fsl,fman-mac =3D <&enet7>;
                };
                ethernet@8 {
                        compatible =3D "fsl,p4080-dpa-ethernet",
"fsl,dpa-ethernet";
                        fsl,qman-channel =3D <&qportal0>;
                        fsl,fman-mac =3D <&enet8>;


>
>>
>> Are you using the reference design or is this custom?
>
> This is a custom design, and is an ATCA blade.
>
>
>> Did you have a look at the device tree in the linux kernel sources?
>> (arch/powerpc/boot/dts/p4080.dts). Does this configuration match
>> yours? In that configuration, there are separate nodes of type
>> p4080ds-mdio, inside the main mdio node.
>
> We actually used the 36 bit tree (we plan to ship the boards with 16G ini=
tially, and up to 32G eventually). =A0I've also re-worked the tree from the=
 LTIB (System Builder) in an attempt to get this to work. =A0Our design dif=
fers significantly from the P4080DS in that there exists no MUX between the=
 bus and phy ... and there is no PIXIS FPGA to do all the clocking and star=
tup stuff.

I have to admit that I'm not an export at the DPAA part either. My
colleague who is is on holiday, unfortunately.

In our case, we needed the 'fixed-link' settings because of the
absence of an MDIO, and I also initially made the mistake of
registering the devices on the wrong FMAN.
For RX, I also had some problems receiving frames correctly. Setting
the source MAC address correctly fixed that problem.
But you seem to have problems with TX...

>
> I've modified u-boot to assign mac addresses based upon our OUI, and the =
MACs all seem to be configured properly coming out of firmware, the ifconfi=
g on the Linux side recognizes all of our 6 interfaces ...
>
>
>>
>> Is your phy configured correctly? Are there any boot messages about
>> this? Can you check its registers?
>> The same for the mdio.
>
> There is some question about the TBI initialization, and we are tracing t=
hat as we speak ...
>
>>
>> Some generic pointers:
>> * If you set CONFIG_PROC_DEVICETREE in the kernel config, you can read
>> out the device-tree at runtime in /proc/device-tree. This helps in
>> verifying whether the nodes you programmed actually appear in the
>> running system.
>
> Ack.
>
>>
>> * The /sys/devices directory can also be useful in identifying
>> potential problems for unfound devices (which does not appear to be
>> your case).
>>
>
> Ack. =A0Also using /proc/interrupts ...
>
>
>> * Can you step through the code, e.g. with a JTAG debugger? Try
>> following the transmit path in the dpaa_eth driver. Maybe something
>> errors out prematurely.
>>
>
> With some headaches ... using codewarrior, and getting assembly level tra=
cing ...

Also, did you check in the dTSEC/FMAN/BMAN for relevant counter
registers? Do you find proof that the packets make it as far as the
dTSEC? (then maybe there is a problem in the link between dTSEC and
PHY).
Are there counters in the PHY that can indicate that packets or no
packets are received?

Which version of the kernel and associated Freescale patches are you using?

How and what type of packets are you sending? Raw MAC frames, IP? Are
you using custom code, or can you try things like ping?
If you are using IP, I trust you checked the Linux configuration (like
assigning a valid IP address to the interface and making sure the
routing table is correct).

Best regards,
Thomas

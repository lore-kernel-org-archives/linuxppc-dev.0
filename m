Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: fpga driver on custom PPC target platform (P4080) ...
Date: Mon, 7 Nov 2011 16:50:34 -0500
Message-ID: <2DD52030B5146141BEB762A11AE97C4C0100CB8E@SPQCEXC05.exfo.com>
In-reply-to: <4EB84E24.9000000@firmworks.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
 <20111105004050.GA1384@truffala.fritz.box>
 <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
 <4EB84E24.9000000@firmworks.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Mitch Bradley" <wmb@firmworks.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Mitch Bradley [mailto:wmb@firmworks.com]
>=20
> I would be tempted to add another level of hierarchy as a container =
for
> the two FPEs on CS2.
>=20

Hi, Mitch.

As a long time Forth(er), I'm somewhat honoured to have this exchange =
with you 8-)


Do you mean something like this????

        localbus@ffe124000 {
                compatible =3D "fsl,p4080-elbc", "fsl,elbc", =
"simple-bus";
                reg =3D <0xf 0xfe124000 0 0x1000>;
                interrupts =3D <25 2 0 0>;
                interrupt-parent =3D <&mpic>;
                #address-cells =3D <2>;
                #size-cells =3D <1>;

                /* Local bus region mappings */
                ranges =3D <0 0 0xf 0xe8000000 0x08000000         /* =
CS0: Boot flash */
                          1 0 0xf 0xd0000000 0x7fff             /* CS1: =
FPGA0 -  LIM */
                          2 0 0xf 0xd1000000 0x7fff             /* CS2: =
FPGA1 -  FPE1 */
                          2 1 0xf 0xd2000000 0x7fff >;          /* CS2: =
FPGA2 -  FPE2 */

                flash@0,0 {
                        compatible =3D "cfi-flash";
                        reg =3D <0 0 0x08000000>;
                        bank-width =3D <2>;
                        device-width =3D <2>;
                        #size-cells =3D <1>;
                        #address-cells =3D <1>;

                        partition@0 {
                                label =3D "rcw";
                                reg =3D <0x0 0x20000>;
                                read-only;
                        };
                        partition@40000 {
                                label =3D "saveenv";
                                reg =3D <0x40000 0x20000>;
                        };
                        partition@7000000 {
                                label =3D "fman-firmware";
                                reg =3D <0x7000000 0x20000>;
                                read-only;
                        };
                        partition@7f80000 {
                                label =3D "u-boot";
                                reg =3D <0x7f80000 0x80000>;
                                read-only;
                        };
                };

                lim: fpga@1, {
                }

			nitro: daughtercard@2 {
                	fpe1: fpga@2,0 {
                	}

                	fpe2: fpga@2,1 {
				}
			}
	}

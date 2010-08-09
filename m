Return-Path: <R58472@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: Review Request: New proposal for device tree clock binding.
Date: Mon, 9 Aug 2010 12:50:05 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
References: <AANLkTimm7G--LQHYBqPB1YCXQb7fSXPDaYsLq0p30DG1@mail.gmail.com> 
From: Li Yang-R58472 <r58472@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"devicetree-discuss" <devicetree-discuss@ozlabs.org>,
	"Jeremy Kerr" <jk@ozlabs.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like the previous sending didn't hit the mailing list.  Resend.

Hi Grant,

I have some comment on this proposal.

>Subject: Review Request: New proposal for device tree clock binding.
>
>Hi Ben (well, hello to everyone, but I'm particularly interested in=20
>Ben's feedback),
>
>Jeremy and I have been kicking around the clock binding, and we've come =

>up with a new proposal that doesn't feel quite as forced to me.
>Please take a look and let me know what you think.  The link to the=20
>binding is below[1], but I've also copied the full text so that you can =

>reply and comment.  The rational for the new binding can be found in=20
>talk page[2].
>
>[1] http://www.devicetree.org/ClockBindings
>[2] http://www.devicetree.org/Talk:ClockBindings
>
>---
>
>This page descibes the proposed OF clock bindings. These are a work-in- =

>progress, and are based on some=20
>[http://patchwork.ozlabs.org/patch/31551/
>experimental work by benh].
>
>=3D=3DClock providers=3D=3D
>
>Sources of clock signal can be represented by any node in the device =
tree.
>A mandatory "<tt>clock-outputs</tt>" property describes the clock=20
>outputs from this device.
>
>{|border=3D1
>!property
>!format
>!notes
>|-
>|<tt>clock-outputs</tt>
>|list of strings
>|specifies output clock signal names.
>|}
>
>For example:
>
>    oscillator {
>        clock-outputs =3D "ckil", "ckih";
>    };
>
>- this node defines a device with two clock outputs, the first named=20
>"ckil" and the second named "ckih".  Consumer nodes always reference=20
>clocks by name.  The names should reflect the clock output signal names =

>for the device.
>
>=3D=3DClock consumers=3D=3D
>
>A device connected to a clock signal needs a *-clock property for each=20
>clock that it is connected to.
>
>{|border=3D1
>!property
>!format
>!notes
>|-
>|<tt>*-clock</tt>
>|1 cell phandle to the clock provider, followed by a string containing
>the clock output name.
>|The name of this property should be the name of the clock input
>signal with a "-clock" suffix.
>|}
>
><tt>*-clock</tt> is named for the signal name for the ''clock input''
>of the device. it should describe the function of the signal for that=20
>device, rather than the name of the system-wide clock line. For=20
>example, a UART with two clocks - one for baud-rate clocking, and the=20
>other for register clocking - may have clock input properties named=20
>"baud-clock" and "register-clock".  The property value is a tuple=20
>containing the phandle to the clock provider and the name of the clock =
output signal.
>
>For example:
>
>    uart {
>        baud-clock =3D <&osc>, "ckil";
>        register-clock =3D <&ref>, "bus";
>    };
>
>
>This represents a device with two clock inputs, named "baud" and=20
>"register". The baud clock is connected to the "ckil" output of the =
"osc"
>device, and the register clock is connected to the "bus" output of the=20
>"ref" device.


Instead of having two items to identify a clock, I would suggest to have =
a node for each clock.  So that clock can be referenced by one handle.  =
Also we can have clock specific information defined in the clock node.  =
Here is the example I am planning to use on 85xx PMC.


                power@e0070{
                        compatible =3D "fsl,mpc8548-pmc", =
"fsl,p2020-pmc";
                        reg =3D <0xe0070 0x20>;

                        etsec1_clk: soc-clk@24{
                                fsl,pmcdr-mask =3D <0x00000080>;
                        };
                        etsec2_clk: soc-clk@25{
                                fsl,pmcdr-mask =3D <0x00000040>;
                        };
                        etsec3_clk: soc-clk@26{
                                fsl,pmcdr-mask =3D <0x00000020>;
                        };
                };

                enet0: ethernet@24000 {
                  ......
                        master-clock =3D <&etsec1_clk>;
			......


What do you think?

- Leo

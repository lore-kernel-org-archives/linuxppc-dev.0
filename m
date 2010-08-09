Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <F9BD3E0A8083BE4ABAA94D7EDD7E3F6310925F@zch01exm26.fsl.freescale.net>
References: <AANLkTimm7G--LQHYBqPB1YCXQb7fSXPDaYsLq0p30DG1@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
	<AANLkTi=3MQBSd_phbSZnRA-wFB7cfa4U_PKND+BgZVhd@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F6310925F@zch01exm26.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Aug 2010 01:12:04 -0600
Message-ID: <AANLkTinQnFBcLiDyQtRRwzdAg_M48BnNsa2OyKWCiSUh@mail.gmail.com>
Subject: Re: Review Request: New proposal for device tree clock binding.
To: Li Yang-R58472 <r58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 9, 2010 at 1:05 AM, Li Yang-R58472 <r58472@freescale.com> wrote=
:
>>>><tt>*-clock</tt> is named for the signal name for the ''clock input''
>>>>of the device. it should describe the function of the signal for that
>>>>device, rather than the name of the system-wide clock line. For
>>>>example, a UART with two clocks - one for baud-rate clocking, and the
>>>>other for register clocking - may have clock input properties named
>>>>"baud-clock" and "register-clock". =A0The property value is a tuple
>>>>containing the phandle to the clock provider and the name of the clock
>>output signal.
>>>>
>>>>For example:
>>>>
>>>> =A0 =A0uart {
>>>> =A0 =A0 =A0 =A0baud-clock =3D <&osc>, "ckil";
>>>> =A0 =A0 =A0 =A0register-clock =3D <&ref>, "bus";
>>>> =A0 =A0};
>>>>
>>>>
>>>>This represents a device with two clock inputs, named "baud" and
>>>>"register". The baud clock is connected to the "ckil" output of the
>>"osc"
>>>>device, and the register clock is connected to the "bus" output of the
>>>>"ref" device.
>>>
>>>
>>> Instead of having two items to identify a clock, I would suggest to hav=
e
>>a node for each clock. =A0So that clock can be referenced by one
>>handle. =A0Also we can have clock specific information defined in the clo=
ck
>>node. =A0Here is the example I am planning to use on 85xx PMC.
>>>
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0power@e0070{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8=
548-pmc",
>>> "fsl,p2020-pmc";
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xe0070 0x20>;
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec1_clk: soc-clk@24{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcd=
r-mask =3D <0x00000080>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec2_clk: soc-clk@25{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcd=
r-mask =3D <0x00000040>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec3_clk: soc-clk@26{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcd=
r-mask =3D <0x00000020>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enet0: ethernet@24000 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master-clock =3D <&etsec=
1_clk>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
>>>
>>>
>>> What do you think?
>
> Quoting your reply:
>
>> I've avoided requiring clock nodes to have a separate sub node for
>> each output because it is more verbose and it prevents clock providers
>> from having child nodes for other purposes. =A0Are you concerned that
>
> I don't see why there should be child nodes for other purposes under cloc=
k node.
>
>> having the <phandle>+output name pair will be difficult to manage?
>
> That's part of my concern.

I was concerned about this too until I found precedence for doing the
exact same thing in the pci binding (and ePAPR).  Mixing phandle and a
string in this way doesn't bother me anymore.

> =A0But my main concern is the inability of describing the properties of e=
ach clock in the device tree. =A0The clock stuff is much SoC related, which=
 means it could be variable among chips even in a same family. =A0Having cl=
ock properties defined in device tree will make it easier to have an abstra=
cted driver to handle clock operations. =A0That's why device trees are used=
 in the first place, right?

You can do whatever you like for your specific clock source driver.
All the clock binding provides is a connection from a clock consumer
node to a specific named output from a clock provider node.  You can
add whatever properties (or subnodes) you need for the hardware you
are writing a binding for.  This binding doesn't prevent you from
doing anything.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

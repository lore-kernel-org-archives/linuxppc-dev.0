Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
References: <AANLkTimm7G--LQHYBqPB1YCXQb7fSXPDaYsLq0p30DG1@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 8 Aug 2010 23:28:32 -0600
Message-ID: <AANLkTi=3MQBSd_phbSZnRA-wFB7cfa4U_PKND+BgZVhd@mail.gmail.com>
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

On Sun, Aug 8, 2010 at 10:50 PM, Li Yang-R58472 <r58472@freescale.com> wrot=
e:
> It looks like the previous sending didn't hit the mailing list. =A0Resend=
.
>
> Hi Grant,
>
> I have some comment on this proposal.

The email addr you're using isn't subscribed, so mailman held the
message for moderation.  I've approved it now and added you address to
the accept list.

Anyway, I received it and here is my reply:

http://lists.ozlabs.org/pipermail/devicetree-discuss/2010-August/002706.htm=
l

Cheers,
g.

>
>>Subject: Review Request: New proposal for device tree clock binding.
>>
>>Hi Ben (well, hello to everyone, but I'm particularly interested in
>>Ben's feedback),
>>
>>Jeremy and I have been kicking around the clock binding, and we've come
>>up with a new proposal that doesn't feel quite as forced to me.
>>Please take a look and let me know what you think. =A0The link to the
>>binding is below[1], but I've also copied the full text so that you can
>>reply and comment. =A0The rational for the new binding can be found in
>>talk page[2].
>>
>>[1] http://www.devicetree.org/ClockBindings
>>[2] http://www.devicetree.org/Talk:ClockBindings
>>
>>---
>>
>>This page descibes the proposed OF clock bindings. These are a work-in-
>>progress, and are based on some
>>[http://patchwork.ozlabs.org/patch/31551/
>>experimental work by benh].
>>
>>=3D=3DClock providers=3D=3D
>>
>>Sources of clock signal can be represented by any node in the device tree=
.
>>A mandatory "<tt>clock-outputs</tt>" property describes the clock
>>outputs from this device.
>>
>>{|border=3D1
>>!property
>>!format
>>!notes
>>|-
>>|<tt>clock-outputs</tt>
>>|list of strings
>>|specifies output clock signal names.
>>|}
>>
>>For example:
>>
>> =A0 =A0oscillator {
>> =A0 =A0 =A0 =A0clock-outputs =3D "ckil", "ckih";
>> =A0 =A0};
>>
>>- this node defines a device with two clock outputs, the first named
>>"ckil" and the second named "ckih". =A0Consumer nodes always reference
>>clocks by name. =A0The names should reflect the clock output signal names
>>for the device.
>>
>>=3D=3DClock consumers=3D=3D
>>
>>A device connected to a clock signal needs a *-clock property for each
>>clock that it is connected to.
>>
>>{|border=3D1
>>!property
>>!format
>>!notes
>>|-
>>|<tt>*-clock</tt>
>>|1 cell phandle to the clock provider, followed by a string containing
>>the clock output name.
>>|The name of this property should be the name of the clock input
>>signal with a "-clock" suffix.
>>|}
>>
>><tt>*-clock</tt> is named for the signal name for the ''clock input''
>>of the device. it should describe the function of the signal for that
>>device, rather than the name of the system-wide clock line. For
>>example, a UART with two clocks - one for baud-rate clocking, and the
>>other for register clocking - may have clock input properties named
>>"baud-clock" and "register-clock". =A0The property value is a tuple
>>containing the phandle to the clock provider and the name of the clock ou=
tput signal.
>>
>>For example:
>>
>> =A0 =A0uart {
>> =A0 =A0 =A0 =A0baud-clock =3D <&osc>, "ckil";
>> =A0 =A0 =A0 =A0register-clock =3D <&ref>, "bus";
>> =A0 =A0};
>>
>>
>>This represents a device with two clock inputs, named "baud" and
>>"register". The baud clock is connected to the "ckil" output of the "osc"
>>device, and the register clock is connected to the "bus" output of the
>>"ref" device.
>
>
> Instead of having two items to identify a clock, I would suggest to have =
a node for each clock. =A0So that clock can be referenced by one handle. =
=A0Also we can have clock specific information defined in the clock node. =
=A0Here is the example I am planning to use on 85xx PMC.
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0power@e0070{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc854=
8-pmc", "fsl,p2020-pmc";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xe0070 0x20>;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec1_clk: soc-clk@24{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcdr-=
mask =3D <0x00000080>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec2_clk: soc-clk@25{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcdr-=
mask =3D <0x00000040>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etsec3_clk: soc-clk@26{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,pmcdr-=
mask =3D <0x00000020>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enet0: ethernet@24000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master-clock =3D <&etsec1_=
clk>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0......
>
>
> What do you think?
>
> - Leo
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

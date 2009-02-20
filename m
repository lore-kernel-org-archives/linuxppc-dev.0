Return-Path: <mbergandi@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 22A5ADDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 16:00:31 +1100 (EST)
Received: by qyk14 with SMTP id 14so3082196qyk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 21:00:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054D@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
	<2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
	<FD3D453EC8A8D5479E7E063D31E2FA4426866A@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054D@mailsvr>
Date: Fri, 20 Feb 2009 00:00:30 -0500
Message-ID: <1c641bc80902192100w2c46a447ued43a6b98b877676@mail.gmail.com>
Subject: Re: Newby trying to get Ethernet going on MPC83xx series device.
From: Michael Bergandi <mbergandi@gmail.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Content-Type: multipart/alternative; boundary=00c09fa2195d32582f04635288a8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00c09fa2195d32582f04635288a8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Dushara,

Sorry, I'm a late comer here, but I might have an idea.  First off, I don't
see below what
kernel version you are using? I may have missed it somewhere.


> The devices are successfully probed, but I'm getting this error on the
> debug console:
>
> [    7.119389] mdio@24520:00 not found
> [    7.161370] eth0: Could not attach to PHY
> [    7.209600] IP-Config: Failed to open eth0
> [    7.258879] IP-Config: Device `eth0' not found.


I have similar output on my MPC8313E RDB. In my case, eth0 shared lines with
the external USB OTG and its PHY. I modified the resister banks on the board
that essentially cuts off the interrupt to the eth0 PHY. So, I don't expect
it to find it. Here is the kernel output at init time:

24520:01 not found
eth0: Could not attach to PHY


My mdio & Ethernet nodes are as follows (commenting out device_type below is
> an experiment)
>
>                mdio@24520 {
>                        /*device_type = "mdio";*/
>                        compatible = "fsl,gianfar-mdio";
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>                        reg = <24520 20>;


Hmm, well, the first thing I catch is this is an old dts format. Depending
on your kernel version, you
may want to comply with the  dts v1 spec. The v1 spec is much more strict on
the format of the values
that are provided for the properties.

ex. reg = <0x24520 0x20> makes it very clear that these values are hex, not
decimal.

You will notice this ambiguity below with the 'interrupts' properties. Are
the values decimal or hex?
Turns out that the values are hex. You will find dts version specifier "
/dts-v1/; " at the top or just before
the root node in any dts file that meets the v1 spec.


>
>                        phy0: ethernet-phy@0 {
>                                interrupt-parent = <&ipic>;
>                                interrupts = <3 8>;
>                                reg = <0>;
>                                device_type = "ethernet-phy";
>                        };
>                        phy1: ethernet-phy@1 {
>                                interrupt-parent = <&ipic>;
>                                interrupts = <3 8>;
>                                reg = <1>;
>                                device_type = "ethernet-phy";
>                        };
>                };


Are you sure both PHY's use interrupt 3? I would think not.


               enet0: ethernet@24000 {
>                        cell-index = <0>;
>                        device_type = "network";
>                        model = "TSEC";
>                        compatible = "gianfar";
>                        reg = <24000 1000>;
>                        local-mac-address = [ 00 00 00 00 00 00 ];
>                        interrupts = <20 8 21 8 22 8>;
>                        interrupt-parent = <&ipic>;
>                        phy-handle = <&phy0>;
>                        linux,network-index = <0>;
>                };
>
>                enet1: ethernet@25000 {
>                        cell-index = <1>;
>                        device_type = "network";
>                        model = "TSEC";
>                        compatible = "gianfar";
>                        reg = <25000 1000>;
>                        local-mac-address = [ 00 00 00 00 00 00 ];
>                        interrupts = <23 8 24 8 25 8>;
>                        interrupt-parent = <&ipic>;
>                        phy-handle = <&phy1>;
>                        linux,network-index = <1>;
>                        phy-connection-type = "gmii";
>                };


Finally, I don't know which silicon rev that you are using, but I have seen
the enet0 and enet1 interrupts swapped.

As in the very latest silicon may have the interrupt lines switched between
them. You can find a statement to that
affect on this list somewhere. I am using a revB MPC8313E and I specify the
interrupts as you have them here.
However, the dts file for the mpc8313erdb in the 2.6.28 kernel has them
reversed. Presumably for a revC chip.

ex.
enet0: ethernet@24000 {
...
        interrupts = <23 8 24 8 25 8>;
...
};

enet1: ethernet@25000 {
...
        interrupts = <20 8 21 8 22 8>;
...
};



> BTW, I assume CCing all those who replied to me is accepted/expected
> conduct or should I avoid this and just write to the list?


Yes, you should cc those who have replied. It is expected --- well, at least
by me.


Also is top posting ok? I haven't figured out how to enable '>' on bloody
> Microsoft Outlook, for incoming plain text messages.


I'm a little new to this list, but in general top posting is frowned upon.
Unfortunately, I can't help you with the Outlook problem.
I can tell you that not being able to determine what part of a message came
when is extremely annoying. I hope you find a fix
for it. Or, you could try Thunderbird :)

Mike

--00c09fa2195d32582f04635288a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dushara,<br><br>Sorry, I&#39;m a late comer here, but I might have an id=
ea.&nbsp; First off, I don&#39;t see below what <br>kernel version you are =
using? I may have missed it somewhere.<br><br><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
The devices are successfully probed, but I&#39;m getting this error on the =
debug console:<br>
<br>
[ &nbsp; &nbsp;7.119389] mdio@24520:00 not found<br>
[ &nbsp; &nbsp;7.161370] eth0: Could not attach to PHY<br>
[ &nbsp; &nbsp;7.209600] IP-Config: Failed to open eth0<br>
[ &nbsp; &nbsp;7.258879] IP-Config: Device `eth0&#39; not found.</blockquot=
e><div><br>I have similar output on my MPC8313E RDB. In my case, eth0 share=
d lines with the external USB OTG and its PHY. I modified the resister bank=
s on the board that essentially cuts off the interrupt to the eth0 PHY. So,=
 I don&#39;t expect it to find it. Here is the kernel output at init time:<=
br>
<br>24520:01 not found<br>eth0: Could not attach to PHY<br><br><br></div><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
My mdio &amp; Ethernet nodes are as follows (commenting out device_type bel=
ow is an experiment)<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mdio@24520 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;/*device_type =3D &quot;mdio&quot;;*/<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;compatible =3D &quot;fsl,gianfar-mdio&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;#address-cells =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;#size-cells =3D &lt;0&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;reg =3D &lt;24520 20&gt;;</blockquote><div><br>Hmm, well, the firs=
t thing I catch is this is an old dts format. Depending on your kernel vers=
ion, you <br>may want to comply with the&nbsp; dts v1 spec. The v1 spec is =
much more strict on the format of the values<br>
that are provided for the properties. <br><br>ex. reg =3D &lt;0x24520 0x20&=
gt; makes it very clear that these values are hex, not decimal. <br><br>You=
 will notice this ambiguity below with the &#39;interrupts&#39; properties.=
 Are the values decimal or hex?<br>
Turns out that the values are hex. You will find dts version specifier &quo=
t; /dts-v1/; &quot; at the top or just before <br>the root node in any dts =
file that meets the v1 spec.<br><br></div><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;phy0: ethernet-phy@0 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;=
;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt;3 8&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quot;ethernet-phy&quo=
t;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;};<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;phy1: ethernet-phy@1 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;=
;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt;3 8&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device_type =3D &quot;ethernet-phy&quo=
t;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;};<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};</blockquote><div=
>&nbsp;</div><div>Are you sure both PHY&#39;s use interrupt 3? I would thin=
k not.<br>&nbsp;<br><br></div><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">

 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; enet0: ethernet@240=
00 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;cell-index =3D &lt;0&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;device_type =3D &quot;network&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;model =3D &quot;TSEC&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;compatible =3D &quot;gianfar&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;reg =3D &lt;24000 1000&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;local-mac-address =3D [ 00 00 00 00 00 00 ];<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;interrupts =3D &lt;20 8 21 8 22 8&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;phy-handle =3D &lt;&amp;phy0&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;linux,network-index =3D &lt;0&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enet1: ethernet@250=
00 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;cell-index =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;device_type =3D &quot;network&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;model =3D &quot;TSEC&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;compatible =3D &quot;gianfar&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;reg =3D &lt;25000 1000&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;local-mac-address =3D [ 00 00 00 00 00 00 ];<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;interrupts =3D &lt;23 8 24 8 25 8&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;phy-handle =3D &lt;&amp;phy1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;linux,network-index =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;phy-connection-type =3D &quot;gmii&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};</blockquote><div=
><br>Finally, I don&#39;t know which silicon rev that you are using, but I =
have seen the enet0 and enet1 interrupts swapped.<br>&nbsp; <br>As in the v=
ery latest silicon may have the interrupt lines switched between them. You =
can find a statement to that<br>
affect on this list somewhere. I am using a revB MPC8313E and I specify the=
 interrupts as you have them here. <br>However, the dts file for the mpc831=
3erdb in the 2.6.28 kernel has them reversed. Presumably for a revC chip.<b=
r>
<br>ex. <br>enet0: ethernet@24000 {<br>...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; interrupts =3D &lt;23 8 24 8 25 8&gt;;<br>...<br>};<br><br>en=
et1: ethernet@25000 {<br>...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
interrupts =3D &lt;20 8 21 8 22 8&gt;;<br>...<br>};<br><br><br></div><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
BTW, I assume CCing all those who replied to me is accepted/expected conduc=
t or should I avoid this and just write to the list?</blockquote><div><br>Y=
es, you should cc those who have replied. It is expected --- well, at least=
 by me.<br>
&nbsp;<br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">
Also is top posting ok? I haven&#39;t figured out how to enable &#39;&gt;&#=
39; on bloody Microsoft Outlook, for incoming plain text messages.</blockqu=
ote><div><br>I&#39;m a little new to this list, but in general top posting =
is frowned upon. Unfortunately, I can&#39;t help you with the Outlook probl=
em. <br>
I can tell you that not being able to determine what part of a message came=
 when is extremely annoying. I hope you find a fix<br>for it. Or, you could=
 try Thunderbird :)<br><br></div></div>Mike<br>

--00c09fa2195d32582f04635288a8--

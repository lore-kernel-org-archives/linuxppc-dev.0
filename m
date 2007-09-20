Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc3-s19.bay0.hotmail.com (bay0-omc3-s19.bay0.hotmail.com
	[65.54.246.219]) by ozlabs.org (Postfix) with ESMTP id 2D134DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 20:04:39 +1000 (EST)
Message-ID: <BAY101-W293E41707766B662445C23BEBA0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a6942c91-f719-4b6a-8085-039b40ec4936_"
From: - Reyneke <reynekejunk@hotmail.com>
To: <jwboyer@linux.vnet.ibm.com>, <jeynergilcaga@gmail.com>
Subject: 
Date: Thu, 20 Sep 2007 10:04:38 +0000
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_a6942c91-f719-4b6a-8085-039b40ec4936_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>>Where did you get your kernel from?  2.6.19 doesn't have any 440EPx suppo=
rt in it

Linux kernel is from DENX, and yes it has full 440EPx support.

>> In you statement, initialise correctly (i.e. receive and transmit), did =
you use like ping or ftp to do it?
>> What do you mean by the word initialise?


 I think the best response will be to provide a short example via u-boot ou=
tput.



The board has just booted up. Eth1 is connected and has a 1Gb link (as per =
PHY and connected switch LEDS). Eth0 is NOT cabled.





...

ver=3DU-Boot 1.2.0 (Sep 18 2007 - 15:51:19)



=3D> setenv netdev eth1

=3D> setenv ethact ppc_4xx_eth1

=3D> ping 10.1.12.90

Waiting for PHY auto negotiation to complete... done

ENET Speed is 1000 Mbps - FULL duplex connection

Using ppc_4xx_eth1 device

ping failed; host 10.1.12.90 is not alive



<At this point, we plug in a Ethernet cable into eth0 and wait for link sta=
tus>



=3D> ping 10.1.12.90

ENET Speed is 1000 Mbps - FULL duplex connection

Using ppc_4xx_eth1 device

host 10.1.12.90 is alive

=3D>=20





At this point, the Eth0 link can be removed. Eth1 will from now send and re=
ceive as expected.



So, it looks like some kind of initialisation issue. What we would like to =
know is whether anyone else have come across a similar problem.



Other interesting point is that we tried the same test on a AMCC Sequoia (s=
ame type of board, different PHYs). And it worked fine. So it suggest that =
it is ether something we are doing wrong in our board initialisation, or it=
's the EMAC - PHY combination.





On Wed, 19 Sep 2007 13:54:35 +0000
"- Reyneke" <reynekejunk@hotmail.com> wrote:
=20
> HI,
>=20
> We've run into a bit of an odd problem and we are not sure where to go an=
d=20
> look for the cause.
>=20
> We have some 440EPx based hardware with two GIG-Ethernet ports using RGMI=
I=20
> and 2x ET1011C PHY's. Problem is that eth1 will only initialise correctly=
=20
> (i.e. receive and transmit) if eth0 has a link. Eth0 always work OK,=20
> regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e.=20
> initialised) at time of setup. Once initialised, eth0 status is irrelevan=
t.=20
> All this is during Linux boot process.
>=20
> Any ideas?





_________________________________________________________________
Feel like a local wherever you go.
http://www.backofmyhand.com=

--_a6942c91-f719-4b6a-8085-039b40ec4936_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
&gt;&gt;Where did you get your kernel from?  2.6.19 doesn't have any 440EPx=
 support in it<br><br>Linux kernel is from DENX, and yes it has full 440EPx=
 support.<br><br><div>&gt;&gt; In you statement, initialise correctly (i.e.=
 receive and transmit), did you use like ping or ftp to do it?<br></div><di=
v>&gt;&gt; What do you mean by the word initialise?<br><br><br></div><div>&=
nbsp;</div>I think the best response will be to provide a short example via=
 u-boot output.<br>
<br>
The board has just booted up. Eth1 is connected and has a 1Gb link (as per =
PHY and connected switch LEDS). Eth0 is NOT cabled.<br>
<br>
<br>
...<br>
ver=3DU-Boot 1.2.0 (Sep 18 2007 - 15:51:19)<br>
<br>
=3D&gt; setenv netdev eth1<br>
=3D&gt; setenv ethact ppc_4xx_eth1<br>
=3D&gt; ping 10.1.12.90<br>
Waiting for PHY auto negotiation to complete... done<br>
ENET Speed is 1000 Mbps - FULL duplex connection<br>
Using ppc_4xx_eth1 device<br>
ping failed; host 10.1.12.90 is not alive<br>
<br>
&lt;At this point, we plug in a Ethernet cable into eth0 and wait for link =
status&gt;<br>
<br>
=3D&gt; ping 10.1.12.90<br>
ENET Speed is 1000 Mbps - FULL duplex connection<br>
Using ppc_4xx_eth1 device<br>
host 10.1.12.90 is alive<br>
=3D&gt; <br>
<br>
<br>
At this point, the Eth0 link can be removed. Eth1 will from now send and re=
ceive as expected.<br>
<br>
So, it looks like some kind of initialisation issue. What we would like to =
know is whether anyone else have come across a similar problem.<br>
<br>
Other interesting point is that we tried the same test on a AMCC Sequoia (s=
ame type of board, different PHYs). And it worked fine. So it suggest that =
it is ether something we are doing wrong in our board initialisation, or it=
's the EMAC - PHY combination.<br>
<br>
<br><br><pre>On Wed, 19 Sep 2007 13:54:35 +0000<br>"- Reyneke" &lt;reynekej=
unk@hotmail.com&gt; wrote:<br> <br>&gt; HI,<br>&gt; <br>&gt; We've run into=
 a bit of an odd problem and we are not sure where to go and <br>&gt; look =
for the cause.<br>&gt; <br>&gt; We have some 440EPx based hardware with two=
 GIG-Ethernet ports using RGMII <br>&gt; and 2x ET1011C PHY's. Problem is t=
hat eth1 will only initialise correctly <br>&gt; (i.e. receive and transmit=
) if eth0 has a link. Eth0 always work OK, <br>&gt; regardless of eth1 stat=
us. Eth1 will work OK if eth0 has a link (i.e. <br>&gt; initialised) at tim=
e of setup. Once initialised, eth0 status is irrelevant. <br>&gt; All this =
is during Linux boot process.<br>&gt; <br>&gt; Any ideas?</pre><br><br>
<br>
<br /><hr />Do you know a place like the back of your hand? Share local kno=
wledge with  <a href=3D'http://www.backofmyhand.com' target=3D'_new'>BackOf=
MyHand.com</a></body>
</html>=

--_a6942c91-f719-4b6a-8085-039b40ec4936_--

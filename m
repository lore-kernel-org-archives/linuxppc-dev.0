Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth11.prod.mesa1.secureserver.net
	(smtpauth11.prod.mesa1.secureserver.net [64.202.165.33])
	by ozlabs.org (Postfix) with SMTP id DBB97DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Feb 2008 13:33:12 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: HDLC driver - dev_free_skb_irq causes Segfault
Date: Sat, 9 Feb 2008 18:32:16 -0800
Message-ID: <00be01c86b8d$27c2fcb0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00BF_01C86B4A.199FBCB0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_00BF_01C86B4A.199FBCB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

So I am in the process of debugging my newly established HDLC driver.
More or less modeled after a simplified gianfar / ucc_geth idea.

However, after loading, etc. and using the following commands

-> insmod hdlc-8360.ko
-> sethdlc hdlc0 hdlc-eth
-> ifconfig hdlc0 up 192.168.1.100

All is well, and I am seeing IDL interrupts. Great.

Now I go to ping an address like, 
ping 192.168.1.101

I can see that I get the start_xmit function, the IRQ from the QE comes back
and reports the TXBD as successfully sent.

Here is the problem, when I goto free the skb in the tx_handler, I get a 
'Unable to Handle Kernel Paging Request for data at address 0x00000000'
Even though for the life of me, I can't see any pointers that are at address
zero.

I have checked the pointer value I am passing in, and indeed it is the exact
same pointer I am receiving from the original 
start-xmit call..

Are we supposed to copy the skb? And free it immediately in the start_xmit?
Some special way to store the pointer? 

I have tried
txbd->buf = skb->data;
txbd->buf = virt_to_phys(skb->data);
etc.. and various other ways to save that I have seen in  the gianfar and
ucc_geth drivers.

My tx_sk_buff** is identical as alloced the same way. 

Anyone have any ideas?

-Russ




------=_NextPart_000_00BF_01C86B4A.199FBCB0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>HDLC driver - dev_free_skb_irq causes Segfault</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">All,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">So</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">I</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">am in the process of debugging my newl</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">y</FONT><FONT SIZE=3D2 FACE=3D"Arial"> =
established</FONT><FONT SIZE=3D2 FACE=3D"Arial"> HDLC =
driver.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">M</FONT><FONT SIZE=3D2 FACE=3D"Arial">ore</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">or less modeled after a simplified gianfar / =
ucc_geth idea.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">H</FONT><FONT SIZE=3D2 FACE=3D"Arial">owever,</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"> after loading, etc</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&#8230;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> and =
using</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">following =
commands</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">-&gt;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">i</FONT><FONT SIZE=3D2 FACE=3D"Arial">nsmod</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">hdlc-8360.ko</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">-&gt;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">sethdlc</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> hdlc0 =
hdlc-eth</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">-&gt; =
ifconfig hdlc0 up 192.168.1.100</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">All is =
well, and I</FONT> <FONT SIZE=3D2 FACE=3D"Arial">am seeing IDL =
interrupts.</FONT><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">Great.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Now I go =
to ping an address like, </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">ping</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">192.168.1.101</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I can =
see that I get the start_xmit function, the IRQ from the QE comes back =
and reports the TXBD as successfully sent.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Here =
is</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">t</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">he problem, when I goto free the skb</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> in the tx_handler</FONT><FONT SIZE=3D2 FACE=3D"Arial">, =
I get</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">a </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&#8216;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Unable to Handle Kernel</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">P</FONT><FONT SIZE=3D2 FACE=3D"Arial">aging =
Request</FONT><FONT SIZE=3D2 FACE=3D"Arial"> for data at address =
0x00000000</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">E</FONT><FONT SIZE=3D2 FACE=3D"Arial">ven</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">though for the life of me, I =
can</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">t see any pointers that are at address =
zero.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I have =
checked the pointer value I am passing in, and indeed it is the exact =
same pointer I am</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">receiving</FONT><FONT SIZE=3D2 FACE=3D"Arial"> from the =
original </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">start</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">-xmit</FONT><FONT SIZE=3D2 FACE=3D"Arial"> =
call..</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Are we =
s</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">u</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">pposed =
to</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Arial">copy the skb?</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">A</FONT><FONT SIZE=3D2 FACE=3D"Arial">nd</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">free it immediately</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> in</FONT><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">t</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">h</FONT><FONT SIZE=3D2 FACE=3D"Arial">e</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"> start</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">_</FONT><FONT SIZE=3D2 FACE=3D"Arial">xmi</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">t?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Some =
special way to store the pointer?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I have =
tried</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">txbd-&gt;buf =3D skb-&gt;data</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">txbd-&gt;buf =3D</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">virt_to_phys(</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">skb-&gt;data</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">)</FONT><FONT SIZE=3D2 FACE=3D"Arial">;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">etc.. and various other</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">w</FONT><FONT SIZE=3D2 FACE=3D"Arial">a</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">y</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">s</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> to</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">s</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">ave</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">that I =
have</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">seen in</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">t</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">he</FONT><FONT SIZE=3D2 FACE=3D"Arial"> gianfar and =
ucc</FONT><FONT SIZE=3D2 FACE=3D"Arial">_</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">geth drivers</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">M</FONT><FONT SIZE=3D2 FACE=3D"Arial">y</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">tx_sk_buff**</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> is identical as alloced the same way</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&#8230;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">A</FONT><FONT SIZE=3D2 FACE=3D"Arial">nyone</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">have any ideas?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">-Russ</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------=_NextPart_000_00BF_01C86B4A.199FBCB0--

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 914FADE038
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 02:38:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9295B.DBE94329"
Subject: RE: Linux driver for Xilinx ICAP
Date: Wed, 8 Oct 2008 08:38:06 -0700
References: <COL107-W38E2468E159F1CBB304906B23B0@phx.gbl>
	<20081008143431.326B3E1806A@mail96-sin.bigfish.com>
	<COL107-W13F1CD2E656CAB97C189C9B23B0@phx.gbl>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>, "John Linn" <linnj@xilinx.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081008153808.32CE21620068@mail165-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C9295B.DBE94329
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Ming,

That's correct, the current driver is not interrupt driven, but simply poll=
ed.  Interrupts don't really add much except overhead, unless the core can =
DMA as well.
What architecture and core version are you running?
I believe there is a DEBUG define, which will generate some logging message=
s.  It would be helpful if you can turn this on and then look at the result=
ing dmesg.

There are two things to be aware of:
1) xps-hwicap1.00.a is huge..  It's much smaller to use opb-hwicap + plb46-=
opb bridge.  I don't think an updated version has been released, however.
2) I've had problems getting the ICAP interface to properly SYNC, which may=
 be the problem here....  based on your response, we can debug further.

Steve

-----Original Message-----
From: MingLiu [mailto:eemingliu@hotmail.com]
Sent: Wed 10/8/2008 7:47 AM
To: John Linn; linuxppc-embedded@ozlabs.org
Cc: Stephen Neuendorffer
Subject: RE: Linux driver for Xilinx ICAP
 =


Dear John,
Nice to hear from you. If possible, could you please show me your .mhs file=
 concerning to the xps_hwicap core? Mine is listed as below:
 =

BEGIN xps_hwicap PARAMETER INSTANCE =3D xps_hwicap_0 PARAMETER HW_VER =3D 1=
.00.a PARAMETER C_BASEADDR =3D 0x40200000 PARAMETER C_HIGHADDR =3D 0x4020FF=
FF BUS_INTERFACE SPLB =3D plb PORT IP2INTC_Irpt =3D xps_hwicap_0_IP2INTC_Ir=
ptEND
 =

The interrupt signal is connected to the interrupt controller. =

 =

I suspect that the driver in Linux doesn't support interrupt mode for this =
core, since I didn't find interrupt handler registration function in the so=
urce code, like "request_irq", etc.. =

 =

I will appreciate if you can have some comments to me. =

 =

Br
Ming
 =




Subject: RE: Linux driver for Xilinx ICAPDate: Wed, 8 Oct 2008 08:34:28 -06=
00From: John.Linn@xilinx.comTo: eemingliu@hotmail.com; linuxppc-embedded@oz=
labs.orgCC: stephenn@xilinx.com






Hi Ming,
 =

I'm copying our local expert on this core to see his thoughts as I don't ac=
tively use this core myself.
 =

Thanks,
John
 =






From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto:l=
inuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Mi=
ngLiuSent: Wednesday, October 08, 2008 7:48 AMTo: linuxppc-embedded@ozlabs.=
orgSubject: Linux driver for Xilinx ICAP
 =

Dear all,Has someone manage to use the driver for the Xilinx xps_hwicap cor=
e to reconfigure bitstreams? I have enabled the driver in Linux configurati=
on (version 2.6.24 from Xilinx tree). However I failed to use it to reconfi=
gure bitstreams. The operations are listed as follows: # cp partial.bit /de=
v/icap0# No error information is shown, however the partial bitstream is no=
t successfully configured. I checked /proc/devices and the device "icap" ha=
s been successfully registered with the major of 259. But in /proc/interrup=
ts, I didn't find any matching entry of the interrupt for icap core. I trie=
d to reconfigure the PR module with JTAG, and my design works well.  Any hi=
nts for this problem? Is the problem on the interrupt? Thanks so much if so=
meone can help me.  BRMing



Windows Live Writer,??????????,????????? ????!This email and any attachment=
s are intended for the sole use of the named recipient(s) and contain(s) co=
nfidential information that may be proprietary, privileged or copyrighted u=
nder applicable law. If you are not the intended recipient, do not read, co=
py, or forward this email message or any attachments. Delete this email mes=
sage and any attachments immediately. =

_________________________________________________________________
Windows Live Photo gallery ?????????,?????????,????????!
http://get.live.cn/product/photo.html



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C9295B.DBE94329
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7653.38"=
>
<TITLE>RE: Linux driver for Xilinx ICAP</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Ming,<BR>
<BR>
That's correct, the current driver is not interrupt driven, but simply poll=
ed.&nbsp; Interrupts don't really add much except overhead, unless the core=
 can DMA as well.<BR>
What architecture and core version are you running?<BR>
I believe there is a DEBUG define, which will generate some logging message=
s.&nbsp; It would be helpful if you can turn this on and then look at the r=
esulting dmesg.<BR>
<BR>
There are two things to be aware of:<BR>
1) xps-hwicap1.00.a is huge..&nbsp; It's much smaller to use opb-hwicap + p=
lb46-opb bridge.&nbsp; I don't think an updated version has been released, =
however.<BR>
2) I've had problems getting the ICAP interface to properly SYNC, which may=
 be the problem here....&nbsp; based on your response, we can debug further=
.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: MingLiu [<A HREF=3D"mailto:eemingliu@hotmail.com">mailto:eemingliu@ho=
tmail.com</A>]<BR>
Sent: Wed 10/8/2008 7:47 AM<BR>
To: John Linn; linuxppc-embedded@ozlabs.org<BR>
Cc: Stephen Neuendorffer<BR>
Subject: RE: Linux driver for Xilinx ICAP<BR>
<BR>
<BR>
Dear John,<BR>
Nice to hear from you. If possible, could you please show me your .mhs file=
 concerning to the xps_hwicap core? Mine is listed as below:<BR>
<BR>
BEGIN xps_hwicap PARAMETER INSTANCE =3D xps_hwicap_0 PARAMETER HW_VER =3D 1=
.00.a PARAMETER C_BASEADDR =3D 0x40200000 PARAMETER C_HIGHADDR =3D 0x4020FF=
FF BUS_INTERFACE SPLB =3D plb PORT IP2INTC_Irpt =3D xps_hwicap_0_IP2INTC_Ir=
ptEND<BR>
<BR>
The interrupt signal is connected to the interrupt controller.<BR>
<BR>
I suspect that the driver in Linux doesn't support interrupt mode for this =
core, since I didn't find interrupt handler registration function in the so=
urce code, like &quot;request_irq&quot;, etc..<BR>
<BR>
I will appreciate if you can have some comments to me.<BR>
<BR>
Br<BR>
Ming<BR>
<BR>
<BR>
<BR>
<BR>
Subject: RE: Linux driver for Xilinx ICAPDate: Wed, 8 Oct 2008 08:34:28 -06=
00From: John.Linn@xilinx.comTo: eemingliu@hotmail.com; linuxppc-embedded@oz=
labs.orgCC: stephenn@xilinx.com<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
Hi Ming,<BR>
<BR>
I'm copying our local expert on this core to see his thoughts as I don't ac=
tively use this core myself.<BR>
<BR>
Thanks,<BR>
John<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [<A HREF=
=3D"mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org">mai=
lto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org</A>] On Beh=
alf Of MingLiuSent: Wednesday, October 08, 2008 7:48 AMTo: linuxppc-embedde=
d@ozlabs.orgSubject: Linux driver for Xilinx ICAP<BR>
<BR>
Dear all,Has someone manage to use the driver for the Xilinx xps_hwicap cor=
e to reconfigure bitstreams? I have enabled the driver in Linux configurati=
on (version 2.6.24 from Xilinx tree). However I failed to use it to reconfi=
gure bitstreams. The operations are listed as follows: # cp partial.bit /de=
v/icap0# No error information is shown, however the partial bitstream is no=
t successfully configured. I checked /proc/devices and the device &quot;ica=
p&quot; has been successfully registered with the major of 259. But in /pro=
c/interrupts, I didn't find any matching entry of the interrupt for icap co=
re. I tried to reconfigure the PR module with JTAG, and my design works wel=
l.&nbsp; Any hints for this problem? Is the problem on the interrupt? Thank=
s so much if someone can help me.&nbsp; BRMing<BR>
<BR>
<BR>
<BR>
Windows Live Writer,??????????,????????? ????!This email and any attachment=
s are intended for the sole use of the named recipient(s) and contain(s) co=
nfidential information that may be proprietary, privileged or copyrighted u=
nder applicable law. If you are not the intended recipient, do not read, co=
py, or forward this email message or any attachments. Delete this email mes=
sage and any attachments immediately.<BR>
_________________________________________________________________<BR>
Windows Live Photo gallery ?????????,?????????,????????!<BR>
<A HREF=3D"http://get.live.cn/product/photo.html">http://get.live.cn/produc=
t/photo.html</A><BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C9295B.DBE94329--

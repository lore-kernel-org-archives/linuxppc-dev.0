Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[124.219.31.203]) by ozlabs.org (Postfix) with ESMTP id 6A2C7DE178
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:11:40 +1000 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-dev@ozlabs.org>
Subject: MPC8548 eTsec
Date: Mon, 27 Apr 2009 11:55:22 +0800
Message-ID: <5B765F7640274B7AA46FA26F2CE9AED5@alphajay>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_037F_01C9C72F.0E6462A0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_037F_01C9C72F.0E6462A0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Dear All:

I am using linux 2.6.14.5 (with many modification) and MPC8548.
Sometimes(very rare) the nic will boot up with rx problem. (tx is just fine)
I see pkts are all dropped in chip but no any RX or BSY interrupt are ever
raised.
(Receive Drop Counter is increased)

If I down and up the nic, the problem will gone.

Any suggestion is welcome. Thanks.
 
 
                            Jay...
 
Some dumps:
 
eth 3:

root@/# cat /proc/interrupts
           CPU0
 19:          0   OpenPIC   Level     enet_tx
 20:          0   OpenPIC   Level     enet_rx
 21:      12433   OpenPIC   Level     enet_tx  ==> nic with problem, tx good
 22:          0   OpenPIC   Level     enet_rx  ==> nic with problem, no rx
 23:          0   OpenPIC   Level     enet_error
 24:          0   OpenPIC   Level     enet_error
 26:       5604   OpenPIC   Level     serial
 27:       1698   OpenPIC   Level     i2c-mpc, i2c-mpc
 50:          0   OpenPIC   Edge      isr
 51:          0   OpenPIC   Edge      isr
 52:          0   OpenPIC   Edge      isr
 53:          1   OpenPIC   Edge      isr
 54:          1   OpenPIC   Edge      isr
 55:          0   OpenPIC   Edge      isr
 56:          1   OpenPIC   Edge      isr
 57:          0   OpenPIC   Edge      isr
BAD:          0
root@/#

ctrl:
tsec_id         : 0x1240000
ievent          : 0x800000
imask           : 0xF1710083
edis            : 0x0
ecntrl          : 0x1010
minflr          : 0x0
ptv             : 0x0
dmactrl         : 0xC3
tbipa           : 0x1F
tctrl           : 0x6000
tstat           : 0x80008000
dfvlan          : 0x81000000
tbdlen          : 0x0
txic            : 0x82000015
tqueue          : 0x8000
tbdbph          : 0x0
tbptr0          : 0x7E16B470
tbaseh          : 0x0
tbase0          : 0x7E16B000
rctrl           : 0x7C0
rstat           : 0x0
rxic            : 0x0
rqueue          : 0x800080
rbifx           : 0x0
rqfar           : 0x0
rqfcr           : 0xF666
rqfpr           : 0xBFEBFFBE
mrblr           : 0x600
rbdbph          : 0x0
rbptr0          : 0x7E16B800
rbaseh          : 0x0
rbase0          : 0x7E16B800
maccfg1         : 0x3F
maccfg2         : 0x7205
ipgifg          : 0x40605060
hafdup          : 0xA1F037
maxfrm          : 0x600
miimcfg         : 0x7
miimcom         : 0x0
miimadd         : 0x0
miimcon         : 0x0
miimstat        : 0x0
miimind         : 0x0
ifstat          : 0x0
attr            : 0xC0
attreli         : 0x0
rmon:
Transmit and Receive 64-byte Frame Counter         : 25360
Transmit and Receive 65-127 byte Frame Counter     : 12546
Transmit and Receive 128-255 byte Frame Counter    : 0
Transmit and Receive 256-511 byte Frame Counter    : 0
Transmit and Receive 512-1023 byte Frame Counter   : 0
Transmit and Receive 1024-1518 byte Frame Counter  : 0
Transmit and Receive 1519-1522 byte Good VLAN Frame: 0
Receive Byte Counter                               : 2053580
Receive Packet Counter                             : 25475
Receive FCS Error Counter                          : 0
Receive Multicast Packet Counter                   : 0
Receive Broadcast Packet Counter                   : 4
Receive Control Frame Packet Counter               : 0
Receive Pause Frame Packet Counter                 : 0
Receive Unknown OP Code Counter                    : 0
Receive Alignment Error Counter                    : 0
Receive Frame Length Error Counter                 : 0
Receive Code Error Counter                         : 0
Receive Carrier Sense Error Counter                : 0
Receive Undersize Packet Counter                   : 0
Receive Oversize Packet Counter                    : 0
Receive Fragments Counter                          : 0
Receive Jabber Counter                             : 0
Receive Drop Counter                               : 25449
Transmit Byte Counter Counter                      : 795584
Transmit Packet Counter                            : 12431
Transmit Multicast Packet Counter                  : 1
Transmit Broadcast Packet Counter                  : 12430
Transmit Pause Control Frame Counter               : 1
Transmit Deferral Packet Counter                   : 0
Transmit Excessive Deferral Packet Counter         : 0
Transmit Single Collision Packet Counter           : 0
Transmit Multiple Collision Packet Counter         : 0
Transmit Late Collision Packet Counter             : 0
Transmit Excessive Collision Packet Counter        : 0
Transmit Total Collision Counter                   : 0
Transmit Drop Frame Counter                        : 0
Transmit Jabber Frame Counter                      : 0
Transmit FCS Error Counter                         : 0
Transmit Control Frame Counter                     : 1
Transmit Oversize Frame Counter                    : 0
Transmit Undersize Frame Counter                   : 0
Transmit Fragments Frame Counter                   : 0
Carry Register One                                 : 0x0
Carry Register Two                                 : 0x0
Carry Mask Register One                            : 0xFE03FFFF
Carry Mask Register Two                            : 0xFFFFD
extra:
kernel_dropped  : 0
rx_large        : 0
rx_short        : 0
rx_nonoctet     : 0
rx_crcerr       : 0
rx_overrun      : 0
rx_bsy          : 0
rx_babr         : 0
rx_trunc        : 0
eberr           : 0
tx_babt         : 0
tx_underrun     : 0
rx_skbmissing   : 0
tx_timeout      : 0
 

------=_NextPart_000_037F_01C9C72F.0E6462A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>Dear&nbsp;<SPAN=20
class=3D687424403-27042009>All</SPAN>:<BR><SPAN=20
class=3D687424403-27042009></SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D687424403-27042009>I am&nbsp;using linux=20
2.6.14.5 (with many modification) and MPC8548.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D687424403-27042009>Sometimes(very rare)=20
the nic will boot up with rx problem. (tx is just fine)<BR><SPAN=20
class=3D687424403-27042009>I</SPAN> see pkts are all dropped in chip but =
no any RX=20
or BSY interrupt are ever raised.<BR></SPAN></FONT><FONT><FONT =
face=3D&#26032;&#32048;&#26126;&#39636;><FONT=20
size=3D2>(Receive Drop Counter is =
increased)<BR></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>If<SPAN class=3D687424403-27042009>=20
I</SPAN>&nbsp;down and up the nic, the problem will=20
gone.<BR></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT face=3D&#26032;&#32048;&#26126;&#39636;><FONT =
size=3D2>Any suggestion is welcome.=20
Thanks.</FONT></FONT></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D687424403-27042009><FONT =
face=3D&#26032;&#32048;&#26126;&#39636;=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
Jay...</FONT></SPAN></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D687424403-27042009>Some=20
dumps:</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D687424403-27042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>eth =
3:<BR></DIV></FONT>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>
<DIV><A><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>root@/</FONT></A><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2># cat=20
/proc/interrupts<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
CPU0<BR>&nbsp;19:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp;=20
enet_tx<BR>&nbsp;20:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp;=20
enet_rx<BR>&nbsp;21:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12433&nbsp;&nbsp;=20
OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; enet_tx&nbsp; =
=3D=3D&gt; nic with=20
problem, tx=20
good<BR>&nbsp;22:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; =
enet_rx&nbsp;=20
=3D=3D&gt; nic with problem, no=20
rx<BR>&nbsp;23:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp;=20
enet_error<BR>&nbsp;24:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp;=20
enet_error<BR>&nbsp;26:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5604&nbsp;&nbsp;=20
OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp;=20
serial<BR>&nbsp;27:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1698&nbsp;&nbsp; =

OpenPIC&nbsp;&nbsp; Level&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc,=20
i2c-mpc<BR>&nbsp;50:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;51:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;52:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;53:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;54:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;55:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;56:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>&nbsp;57:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp; OpenPIC&nbsp;&nbsp; Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
isr<BR>BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0<BR></FONT><A><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>root@/</FONT></A><FONT face=3D&#26032;&#32048;&#26126;&#39636;=20
size=3D2>#<BR></FONT></FONT></DIV></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;=20
size=3D2>ctrl:<BR>tsec_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 :=20
0x1240000<BR>ievent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 :=20
0x800000<BR>imask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; :=20
0xF1710083<BR>edis&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
: 0x0<BR>ecntrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x1010<BR>minflr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =

0x0<BR>ptv&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
: 0x0<BR>dmactrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0xC3<BR>tbipa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 :=20
0x1F<BR>tctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 :=20
0x6000<BR>tstat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; :=20
0x80008000<BR>dfvlan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x81000000<BR>tbdlen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x0<BR>txic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; :=20
0x82000015<BR>tqueue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x8000<BR>tbdbph&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =

0x0<BR>tbptr0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7E16B470<BR>tbaseh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x0<BR>tbase0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7E16B000<BR>rctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
: =
0x7C0<BR>rstat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x0<BR>rxic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; :=20
0x0<BR>rqueue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x800080<BR>rbifx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; :=20
0x0<BR>rqfar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
:=20
0x0<BR>rqfcr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
:=20
0xF666<BR>rqfpr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; :=20
0xBFEBFFBE<BR>mrblr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
: 0x600<BR>rbdbph&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
:=20
0x0<BR>rbptr0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7E16B800<BR>rbaseh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0x0<BR>rbase0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7E16B800<BR>maccfg1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x3F<BR>maccfg2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7205<BR>ipgifg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =

0x40605060<BR>hafdup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; :=20
0xA1F037<BR>maxfrm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
:=20
0x600<BR>miimcfg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x7<BR>miimcom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>miimadd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>miimcon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>miimstat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>miimind&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>ifstat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>attr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; :=20
0xC0<BR>attreli&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0x0<BR>rmon:<BR>Transmit and Receive 64-byte Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
25360<BR>Transmit and=20
Receive 65-127 byte Frame Counter&nbsp;&nbsp;&nbsp;&nbsp; : =
12546<BR>Transmit=20
and Receive 128-255 byte Frame Counter&nbsp;&nbsp;&nbsp; : 0<BR>Transmit =
and=20
Receive 256-511 byte Frame Counter&nbsp;&nbsp;&nbsp; : 0<BR>Transmit and =
Receive=20
512-1023 byte Frame Counter&nbsp;&nbsp; : 0<BR>Transmit and Receive =
1024-1518=20
byte Frame Counter&nbsp; : 0<BR>Transmit and Receive 1519-1522 byte Good =
VLAN=20
Frame: 0<BR>Receive Byte=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 2053580<BR>Receive Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 25475<BR>Receive FCS Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
: 0<BR>Receive Multicast Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Broadcast Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 4<BR>Receive Control Frame Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Pause Frame Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Unknown OP Code=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Alignment Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Frame Length Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Code Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
: 0<BR>Receive Carrier Sense Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Undersize Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Oversize Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Fragments=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
: 0<BR>Receive Jabber=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Receive Drop=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 25449<BR>Transmit Byte Counter=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 795584<BR>Transmit Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
: 12431<BR>Transmit Multicast Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 1<BR>Transmit Broadcast Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 12430<BR>Transmit Pause Control Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
: 1<BR>Transmit Deferral Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Transmit Excessive Deferral Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<BR>Transmit =
Single=20
Collision Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>Transmit Multiple Collision Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<BR>Transmit =
Late=20
Collision Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
: 0<BR>Transmit Excessive Collision Packet=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<BR>Transmit Total=20
Collision=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Transmit Drop Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

: 0<BR>Transmit Jabber Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Transmit FCS Error=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
: 0<BR>Transmit Control Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 1<BR>Transmit Oversize Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Transmit Undersize Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Transmit Fragments Frame=20
Counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0<BR>Carry Register=20
One&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0x0<BR>Carry Register=20
Two&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
: 0x0<BR>Carry Mask Register=20
One&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
: 0xFE03FFFF<BR>Carry Mask Register=20
Two&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
: 0xFFFFD<BR>extra:<BR>kernel_dropped&nbsp; :=20
0<BR>rx_large&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_short&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_nonoctet&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_crcerr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_overrun&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_bsy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_babr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>rx_trunc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>eberr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =

0<BR>tx_babt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
0<BR>tx_underrun&nbsp;&nbsp;&nbsp;&nbsp; : =
0<BR>rx_skbmissing&nbsp;&nbsp; :=20
0<BR>tx_timeout&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------=_NextPart_000_037F_01C9C72F.0E6462A0--

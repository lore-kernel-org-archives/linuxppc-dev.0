Return-Path: <udira@matrix-defense.co.il>
Received: from EX2K3-HZ.Matrix.IT (bzq-25-126-50.cust.bezeqint.net
	[212.25.126.50]) by ozlabs.org (Postfix) with ESMTP id 62B39679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 23:29:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56AA2.6A51F0D9"
Date: Mon, 6 Jun 2005 16:17:05 +0200
Message-ID: <CD1F942E2840FA4E9F8CC5A780E94495509CA4@EX2K3-HZ.Matrix.IT>
From: "Udi Rasiuk" <udira@matrix-defense.co.il>
To: <linuxppc-embedded@ozlabs.org>
Subject: Subject: PPC8272 - FCC2 transmitter underrun
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

------_=_NextPart_001_01C56AA2.6A51F0D9
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

Subject: PPC8272 - FCC2 transmitter underrun

Description: On a board with PPC8272 we get "transmitter underrun" =
interrupt from the FCC2.

The BD and Buffers are on an external RAM on the 60x.

It looks like getting the READY bit in the current BD with a perfectly =
good Buffer immidiatly brings up the interrupt.

=20
=20
there are two underrun reasons :

1.
If TxBD[L] (last buffer in the frame) is cleared when the end of the BD =
is reached and the
transmitter moves immediately to the next buffer to begin transmission. =
Failure to provide the
next buffer in time causes a transmit underrun.


2.
If the CPM is heavy loaded and (because of bus latency) the SDMA cannot =
fill the FIFO
from external memory, a transmit underrun occurs. =20
=20
But i've stepped with an ice and checked both -looked at the L bit and =
halted the cpu right after the setting of the Ready bit.

------_=_NextPart_001_01C56AA2.6A51F0D9
Content-Type: text/html;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Drtl><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dwindows-1255"></HEAD><BODY>=0A=
<DIV align=3Dleft><FONT face=3D'Arial' color=3D#000000 size=3D2>Subject: =
PPC8272 - FCC2 transmitter =0A=
underrun<BR><BR>Description: On a board with PPC8272 we get "transmitter =0A=
underrun" interrupt from the FCC2.<BR><BR>The BD and Buffers are on an =
external =0A=
RAM on the 60x.<BR><BR>It looks like getting the READY bit in the =
current BD =0A=
with a perfectly good Buffer immidiatly brings up the =0A=
interrupt.<BR></FONT></DIV>=0A=
<DIV align=3Dleft><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV align=3Dleft><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV align=3Dleft><FONT face=3DArial color=3D#000000 size=3D2>there are =
two underrun =0A=
reasons :<BR><BR>1.<BR>If TxBD[L] (last buffer in the frame) is cleared =
when the =0A=
end of the BD is reached and the<BR>transmitter moves immediately to the =
next =0A=
buffer to begin transmission. Failure to provide the<BR>next buffer in =
time =0A=
causes a transmit underrun.<BR><BR><BR>2.<BR>If the CPM is heavy loaded =
and =0A=
(because of bus latency) the SDMA cannot fill the FIFO<BR>from external =
memory, =0A=
a transmit underrun occurs.&nbsp;&nbsp;</FONT></DIV>=0A=
<DIV align=3Dleft><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV align=3Dleft><FONT face=3DArial color=3D#000000 size=3D2>But i've =
stepped with an =0A=
ice and checked both -looked at the L bit and halted the cpu right after =
the =0A=
setting of the Ready bit.</DIV></FONT></BODY></HTML>
------_=_NextPart_001_01C56AA2.6A51F0D9--

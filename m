Return-Path: <nhickman@dtechlabs.com>
Received: from mail.dtechlabs.com (66.239.149.149.ptr.us.xo.net
	[66.239.149.149]) by ozlabs.org (Postfix) with SMTP id A946ADDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 09:06:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B9D7.36746D29"
Subject: mpc8270 & Intel 82551ER on 2.6.17.14
Date: Thu, 28 Jun 2007 18:53:57 -0400
Message-ID: <8140AAF341CC904BA92C3D6A5A1909782A2FA3@ditech-1.ditechllc.com>
From: "Nicholas Hickman" <nhickman@dtechlabs.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C7B9D7.36746D29
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I am having trouble getting two 82551ER Ethernet controllers running in
Linux.  I am able to scan the PCI bus and see the devices and I was even
able to program the EEPROM from U-boot. =20
=20
In the kernel I mapped the IRQ's through /arch/ppc/m82xx_pci.c.  I've
been using the e100 drive that comes with the 2.6.17.14 kernel and have
also tried the driver directly from Intel.  Both give the same results.
The PCI scan shows the correct output for how the device should be
configured.
=20
The situation is when I use the ethtool with the driver loaded and eth0
not configured with ifconfig I get this:
SCB Status Word (Lower Word)             0x0000
      RU Status:               Idle
      CU Status:               Idle
      ---- Interrupts Pending ----
      Flow Control Pause:                no
      Early Receive:                     no
      Software Generated Interrupt:      no
      MDI Done:                          no
      RU Not In Ready State:             no
      CU Not in Active State:            no
      RU Received Frame:                 no
      CU Completed Command:              no
SCB Command Word (Upper Word)            0x0100
      RU Command:              No Command
      CU Command:              No Command
      Software Generated Interrupt:      no
      ---- Interrupts Masked ----
      ALL Interrupts:                    yes
      Flow Control Pause:                no
      Early Receive:                     no
      RU Not In Ready State:             no
      CU Not in Active State:            no
      RU Received Frame:                 no
      CU Completed Command:              no
MDI/MDI-X Status:                        MDI
=20

With eth0 configured using the command "ifconfig eth0 192.168.1.7
netmask 255.255.255.0 up" I get this:
SCB Status Word (Lower Word)             0x6450
      RU Status:               Ready
      CU Status:               Suspended
      ---- Interrupts Pending ----
      Flow Control Pause:                no
      Early Receive:                     no
      Software Generated Interrupt:      yes
      MDI Done:                          no
      RU Not In Ready State:             no
      CU Not in Active State:            yes
      RU Received Frame:                 yes
      CU Completed Command:              no
SCB Command Word (Upper Word)            0x0000
      RU Command:              No Command
      CU Command:              No Command
      Software Generated Interrupt:      no
      ---- Interrupts Masked ----
      ALL Interrupts:                    no
      Flow Control Pause:                no
      Early Receive:                     no
      RU Not In Ready State:             no
      CU Not in Active State:            no
      RU Received Frame:                 no
      CU Completed Command:              no
MDI/MDI-X Status:                        MDI
=20
=20
=20
If I issue a PING out of the port and sniff the traffic on the
destination PC I see the ARP requests and I send the reply, but the
embedded machine sees nothing.  If I use ethtool or even ifconfig to
view the statistics on the port they both show that there are no packets
in or out.
=20
I have no idea where to go with this.  It seems like the PCI bus is
working, but possibly not the Interrupt handler.
=20
=20
=20

Nicholas Hickman
Applications Engineer
DTech Labs, Inc.


=20

------_=_NextPart_001_01C7B9D7.36746D29
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>I am having trouble getting two 82551ER =
Ethernet=20
controllers running in Linux.&nbsp; I am able to scan the PCI bus and =
see the=20
devices and I was even able to program the EEPROM from U-boot.&nbsp;=20
</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>In the kernel I mapped the IRQ's =
through=20
/arch/ppc/m82xx_pci.c.&nbsp; I've been using the e100 drive that comes =
with the=20
2.6.17.14 kernel and have also tried the driver directly from =
Intel.&nbsp; Both=20
give the same results.&nbsp; The PCI scan shows the correct output for =
how the=20
device should be configured.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The situation is when I use the ethtool =
with the=20
driver loaded and eth0 not configured with ifconfig I get this:<BR>SCB =
Status=20
Word (Lower=20
Word)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
0x0000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Idle<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Idle<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---- Interrupts Pending=20
----<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flow Control=20
Pause:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Early=20
Receive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software Generated=20
Interrupt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
MDI=20
Done:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Not In Ready=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Not in Active=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Received=20
Frame:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Completed=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
no<BR>SCB Command Word (Upper=20
Word)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x0100<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
No Command<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
No Command<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software Generated=20
Interrupt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
---- Interrupts Masked ----<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALL=20
Interrupts:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
yes<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flow Control=20
Pause:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Early=20
Receive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Not In Ready=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Not in Active=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Received=20
Frame:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Completed=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
no<BR>MDI/MDI-X=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

MDI</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>With eth0 configured using the command "ifconfig eth0 =
192.168.1.7=20
netmask 255.255.255.0 up" I get this:<BR>SCB Status Word (Lower=20
Word)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
0x6450<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Ready<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Suspended<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---- Interrupts Pending=20
----<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flow Control=20
Pause:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Early=20
Receive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software Generated=20
Interrupt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
yes<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
MDI=20
Done:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Not In Ready=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Not in Active=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

yes<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Received=20
Frame:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
yes<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Completed=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
no<BR>SCB Command Word (Upper=20
Word)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x0000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
No Command<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
No Command<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software Generated=20
Interrupt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
---- Interrupts Masked ----<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALL=20
Interrupts:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flow Control=20
Pause:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Early=20
Receive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Not In Ready=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Not in Active=20
State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RU Received=20
Frame:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
no<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU Completed=20
Command:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
no<BR>MDI/MDI-X=20
Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

MDI</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>If I issue a PING out of the port and sniff the traffic on the =
destination=20
PC I see the ARP requests and I send the reply, but the embedded machine =
sees=20
nothing.&nbsp; If I use ethtool or even ifconfig to view the statistics =
on the=20
port they both show that there are no packets in or out.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have no idea where to go with this.&nbsp; It seems like the PCI =
bus is=20
working, but possibly not the Interrupt handler.</DIV>
<DIV>&nbsp;</DIV>
<DIV></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<P class=3DMsoNormal><STRONG><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Calibri','sans-serif'">Nicholas=20
Hickman<BR></SPAN></STRONG><SPAN style=3D"FONT-SIZE: 8pt">Applications=20
Engineer<BR></SPAN><STRONG><SPAN=20
style=3D"FONT-SIZE: 8pt; FONT-FAMILY: 'Calibri','sans-serif'">DTech =
Labs,=20
Inc</SPAN></STRONG><SPAN style=3D"FONT-SIZE: 8pt">.<BR></SPAN></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7B9D7.36746D29--

Return-Path: <Exchange.Admin@plexus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C91995.852F1408"
Subject: FW: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine
	checkexception
Date: Thu, 18 Sep 2008 08:50:33 -0500
Message-ID: <EB1085FDCA2C0D47832130CBDF9B36A00571CE0D@CO-MAIL-001.ms1.plexus.com>
From: "Exchange Admin" <Exchange.Admin@plexus.com>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91995.852F1408
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C91995.852F1408"


------_=_NextPart_002_01C91995.852F1408
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20

________________________________

From: linuxppc-embedded-bounces+mf.low=3Dplexus.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+mf.low=3Dplexus.com@ozlabs.org] On =
Behalf Of joachim.bader@diehl-aerospace.de
Sent: Monday, September 15, 2008 9:56 AM
To: Linuxppc-embedded@ozlabs.org
Subject: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine =
checkexception



Hello everybody,=20

I am trying to put into operation a proprietary board using a freescale =
MPC8641D. I use U-boot 1.3.0 and Linux kernel 2.6.25-11.=20
On one PCIe-bus I have a PEX8518 followed by a PEX8114. A USB-controller =
is connected to the 8114.=20


    +--------------------------+=20
    |                          |=20
    |       MPC 8641 D         |=20
    |                          |=20
    +--------------------------+=20
                  |=20
               PEX8518 <----------------- PCIe switch=20
                  |=20
               PEX8114 <----------------- PCIe to PCI bridge=20
                  |=20
               ISP1562 <----------------- USB controller=20

The PCIe-components are scanned correctly, resources (mem and IO) are =
assigned (correctly as far as I understand),=20
but on the first read access to a control register of the usb-device the =
kernel generates "Oops: Machine check, sig: 7 [#1]".=20
Writing to the same register does not produce an "Oops".=20

The PCIe bus is defined in dts file as follows (dump from U-boot):=20

    pcie@d4008000 {=20
        cell-index =3D <0>;=20
        compatible =3D "fsl,mpc8641-pcie";=20
        device_type =3D "pci";=20
        #interrupt-cells =3D <1>;=20
        #size-cells =3D <2>;=20
        #address-cells =3D <3>;=20
        reg =3D <1000>;=20
        bus-range =3D <4>;=20
        ranges =3D [02 00 00 00 00 00 00 00 40 00 00 00 40 00 00 00 00 =
00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 c0 00 00 00 00 =
00 00 00 00 10 00 00];=20
        clock-frequency =3D <1fca055>;=20
        interrupt-parent =3D <40000>;=20
        interrupts =3D <2>;=20
        interrupt-map-mask =3D [00 00 ff 00 00 00 00 00 00 00 00 00 00 =
00 00 07];=20
        interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
01 00 04 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 02 00 04 00 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 03 00 04 00 00 00 00 00 02 00 00 00 01 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 03 00 00 00 =
01];=20
        pcie@0 {=20
            reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00];=20
            #size-cells =3D <2>;=20
            #address-cells =3D <3>;=20
            device_type =3D "pci";=20
            ranges =3D [02 00 00 00 00 00 00 00 40 00 00 00 02 00 00 00 =
00 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 =
c0 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 =
00];=20
        };=20
    };=20
    pcie@d4009000 {=20
        cell-index =3D <1>;=20
        compatible =3D "fsl,mpc8641-pcie";=20
        device_type =3D "pci";=20
        #interrupt-cells =3D <1>;=20
        #size-cells =3D <2>;=20
        #address-cells =3D <3>;=20
        reg =3D <1000>;=20
        bus-range =3D <6>;=20
        ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 00 =
00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 c0 10 00 00 00 =
00 00 00 00 10 00 00];=20
        clock-frequency =3D <1fca055>;=20
        interrupt-parent =3D <40000>;=20
        interrupts =3D <2>;=20
        interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 00 00 00 00 =
00 00 07];=20
        interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
01 00 04 00 00 00 00 00 04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 02 00 04 00 00 00 00 00 05 00 00 00 01 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 03 00 04 00 00 00 00 00 06 00 00 00 01 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 07 00 00 00 =
01];=20
        pcie@0 {=20
            reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00];=20
            #size-cells =3D <2>;=20
            #address-cells =3D <3>;=20
            device_type =3D "pci";=20
            ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 02 00 00 00 =
00 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 =
c0 10 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 00 00 00 00 00 10 00 =
00];=20
        };=20
    };=20

and here the output from kernel:=20

quirk_usb_handoff_ohci: resource start =3D 0x80000000, len =3D =
0x00001000=20
quirk_usb_handoff_ohci: base =3D 0xe1056000, offset =3D 0x00000004=20
Machine check in kernel mode.=20
Caused by (from SRR1=3D149030): Transfer error ack signal=20
Oops: Machine check, sig: 7 [#1]=20
TAURUS=20
NIP: c0297f4c LR: c0297f44 CTR: c00115d0=20
REGS: df821e60 TRAP: 0200   Not tainted  (2.6.25.11)=20
MSR: 00149030 <EE,ME,IR,DR>  CR: 24000022  XER: 00000000=20
TASK =3D df805410[1] 'swapper' THREAD: df820000=20
GPR00: c0297f44 df821f10 df805410 00000042 00000001 00000001 00000000 =
00020000=20
GPR08: 00000036 c0333fe4 00006b61 c0360000 44000028 f7fbfffc 0fffac00 =
ffffffff=20
GPR16: 00800000 007fff00 df821f78 c02d0000 c0330000 c0330000 00000000 =
0fff5464=20
GPR24: c0330000 c02d0000 00000000 00000000 e1056000 df841218 df841218 =
e1056004=20
NIP [c0297f4c] 0xc0297f4c=20
LR [c0297f44] 0xc0297f44=20
Call Trace:=20
[df821f10] [c0297f44] 0xc0297f44 (unreliable)=20
[df821f40] [c01617dc] pci_fixup_device+0xec/0x140=20
[df821f60] [c0295ae0] 0xc0295ae0=20
[df821f70] [c030c198] kernel_init+0x9c/0x290=20
[df821ff0] [c0010a6c] kernel_thread+0x44/0x60=20
Instruction dump:=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 97996e90be8a1237 ]---=20
Kernel panic - not syncing: Attempted to kill init!=20
Rebooting in 180 seconds..=20

where resource start =3D 0x80000000 is the physical address of the USB =
controller, base =3D 0xe1056000 is the virtual address.=20

Does anyone know this kind of problem and can give me a hint.=20

Kind Regards,=20
Joachim=20


--=20
Dipl.-Ing. Joachim Bader
Research & Technology
Cockpit and Display Systems

Diehl Aerospace GmbH
An der Sandelmuehle 13
D-60439 Frankfurt
Phone +49-69-5805-1270
Fax       +49-69-5805-1400
e-mail:  joachim.bader@diehl-aerospace.de
http://www.diehl-aerospace.de=20


_________________________________________________________________________=
______________________________________________
Der Inhalt dieser E-Mail ist f=FCr den Absender rechtlich nicht =
verbindlich.=20
Informieren Sie uns bitte, wenn Sie diese E-Mail f=E4lschlicherweise =
erhalten haben (Fax: +49-69-5805-1399). Bitte l=F6schen Sie in diesem =
Fall die Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us =
accordingly (Fax: +49-69-5805-1399). In such case you are requested to =
erase the message. Any use of such e-mail message is strictly =
prohibited.



------_=_NextPart_002_01C91995.852F1408
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16705" name=3DGENERATOR></HEAD>
<BODY>
<DIV>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B>=20
linuxppc-embedded-bounces+mf.low=3Dplexus.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+mf.low=3Dplexus.com@ozlabs.org] <B>On =
Behalf Of=20
</B>joachim.bader@diehl-aerospace.de<BR><B>Sent:</B> Monday, September =
15, 2008=20
9:56 AM<BR><B>To:</B> Linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
U-Boot=20
1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine=20
checkexception<BR></FONT><BR></DIV>
<DIV></DIV><BR><FONT face=3Dsans-serif size=3D2>Hello everybody,</FONT>=20
<BR><BR><FONT face=3Dsans-serif size=3D2>I am trying to put into =
operation a=20
proprietary board using a freescale MPC8641D. I use U-boot 1.3.0 and =
Linux=20
kernel 2.6.25-11.</FONT> <BR><FONT face=3Dsans-serif size=3D2>On one =
PCIe-bus I have=20
a PEX8518 followed by a PEX8114. A USB-controller is connected to the=20
8114.</FONT> <BR><BR><BR><FONT face=3D"Courier New" size=3D2>&nbsp; =
&nbsp;=20
+--------------------------+</FONT> <BR><FONT face=3D"Courier New" =
size=3D2>&nbsp;=20
&nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
&nbsp; &nbsp; &nbsp;|</FONT> <BR><FONT face=3D"Courier New" =
size=3D2>&nbsp; &nbsp; |=20
&nbsp; &nbsp; &nbsp; MPC 8641 D &nbsp; &nbsp; &nbsp; &nbsp; |</FONT> =
<BR><FONT=20
face=3D"Courier New" size=3D2>&nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</FONT> =
<BR><FONT=20
face=3D"Courier New" size=3D2>&nbsp; &nbsp; =
+--------------------------+</FONT>=20
<BR><FONT face=3D"Courier New" size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; |</FONT> <BR><FONT face=3D"Courier New" =
size=3D2>&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PEX8518 &lt;----------------- =
PCIe=20
switch</FONT> <BR><FONT face=3D"Courier New" size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |</FONT> <BR><FONT face=3D"Courier =
New"=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PEX8114=20
&lt;----------------- PCIe to PCI bridge</FONT> <BR><FONT =
face=3D"Courier New"=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
|</FONT>=20
<BR><FONT face=3D"Courier New" size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp;ISP1562 &lt;----------------- USB controller</FONT> =
<BR><BR><FONT=20
face=3Dsans-serif size=3D2>The PCIe-components are scanned correctly, =
resources (mem=20
and IO) are assigned (correctly as far as I understand),</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>but on the first read access to a control =
register of the=20
usb-device the kernel generates "Oops: Machine check, sig: 7 =
[#1]".</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>Writing to the same register does =
not produce=20
an "Oops".</FONT> <BR><BR><FONT face=3Dsans-serif size=3D2>The PCIe bus =
is defined=20
in dts file as follows (dump from U-boot):</FONT> <BR><BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; pcie@d4008000 {</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; cell-index =3D &lt;0&gt;;</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; compatible =3D=20
"fsl,mpc8641-pcie";</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; =
&nbsp; &nbsp;=20
&nbsp; device_type =3D "pci";</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; #interrupt-cells =3D &lt;1&gt;;</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; #size-cells =3D=20
&lt;2&gt;;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
#address-cells =3D &lt;3&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; reg =3D &lt;1000&gt;;</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; bus-range =3D &lt;4&gt;;</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; ranges =3D [02 00 =
00 00 00 00=20
00 00 40 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 =
00 00 c0=20
00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00];</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; clock-frequency =3D =
&lt;1fca055&gt;;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
interrupt-parent =3D=20
&lt;40000&gt;;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp;=20
&nbsp; interrupts =3D &lt;2&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; interrupt-map-mask =3D [00 00 ff 00 00 00 00 00 00 =
00 00 00=20
00 00 00 07];</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp;=20
&nbsp; interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
01 00 04 00=20
00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
02 00 04=20
00 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 03 00=20
04 00 00 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 04=20
00 04 00 00 00 00 00 03 00 00 00 01];</FONT> <BR><FONT face=3Dsans-serif =

size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; pcie@0 {</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D [00 00 00 00 =
00 00 00 00=20
00 00 00 00 00 00 00 00 00 00 00 00];</FONT> <BR><FONT face=3Dsans-serif =

size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #size-cells =3D =
&lt;2&gt;;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
#address-cells =3D &lt;3&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; device_type =3D "pci";</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
ranges =3D [02 00=20
00 00 00 00 00 00 40 00 00 00 02 00 00 00 00 00 00 00 40 00 00 00 00 00 =
00 00 40=20
00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 01 00 00 00 00 00 00 00 c0 =
00 00 00=20
00 00 00 00 00 10 00 00];</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp; &nbsp;=20
&nbsp; &nbsp; };</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; =
&nbsp; };</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; pcie@d4009000 =
{</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; cell-index =3D=20
&lt;1&gt;;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
compatible =3D "fsl,mpc8641-pcie";</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; device_type =3D "pci";</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; #interrupt-cells =3D =
&lt;1&gt;;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
#size-cells =3D=20
&lt;2&gt;;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
#address-cells =3D &lt;3&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; reg =3D &lt;1000&gt;;</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; bus-range =3D &lt;6&gt;;</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; ranges =3D [02 00 =
00 00 00 00=20
00 00 80 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 =
00 00 c0=20
10 00 00 c0 10 00 00 00 00 00 00 00 10 00 00];</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; clock-frequency =3D =
&lt;1fca055&gt;;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
interrupt-parent =3D=20
&lt;40000&gt;;</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp;=20
&nbsp; interrupts =3D &lt;2&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 =
00 00 00=20
00 00 00 07];</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp;=20
&nbsp; interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
01 00 04 00=20
00 00 00 00 04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
02 00 04=20
00 00 00 00 00 05 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 03 00=20
04 00 00 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 04=20
00 04 00 00 00 00 00 07 00 00 00 01];</FONT> <BR><FONT face=3Dsans-serif =

size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; pcie@0 {</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D [00 00 00 00 =
00 00 00 00=20
00 00 00 00 00 00 00 00 00 00 00 00];</FONT> <BR><FONT face=3Dsans-serif =

size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #size-cells =3D =
&lt;2&gt;;</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;=20
#address-cells =3D &lt;3&gt;;</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; device_type =3D "pci";</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
ranges =3D [02 00=20
00 00 00 00 00 00 80 00 00 00 02 00 00 00 00 00 00 00 80 00 00 00 00 00 =
00 00 40=20
00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 01 00 00 00 00 00 00 00 c0 =
10 00 00=20
00 00 00 00 00 10 00 00];</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp; &nbsp;=20
&nbsp; &nbsp; };</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; =
&nbsp; };</FONT>=20
<BR><BR><FONT face=3Dsans-serif size=3D2>and here the output from =
kernel:</FONT>=20
<BR><BR><FONT face=3Dsans-serif size=3D2>quirk_usb_handoff_ohci: =
resource start =3D=20
0x80000000, len =3D 0x00001000</FONT> <BR><FONT face=3Dsans-serif=20
size=3D2>quirk_usb_handoff_ohci: base =3D 0xe1056000, offset =3D =
0x00000004</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>Machine check in kernel =
mode.</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>Caused by (from SRR1=3D149030): Transfer =
error ack=20
signal</FONT> <BR><FONT face=3Dsans-serif size=3D2>Oops: Machine check, =
sig: 7=20
[#1]</FONT> <BR><FONT face=3Dsans-serif size=3D2>TAURUS</FONT> <BR><FONT =

face=3Dsans-serif size=3D2>NIP: c0297f4c LR: c0297f44 CTR: =
c00115d0</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>REGS: df821e60 TRAP: 0200 &nbsp; Not tainted=20
&nbsp;(2.6.25.11)</FONT> <BR><FONT face=3Dsans-serif size=3D2>MSR: =
00149030=20
&lt;EE,ME,IR,DR&gt; &nbsp;CR: 24000022 &nbsp;XER: 00000000</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>TASK =3D df805410[1] 'swapper' THREAD: =
df820000</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>GPR00: c0297f44 df821f10 df805410 =
00000042=20
00000001 00000001 00000000 00020000</FONT> <BR><FONT face=3Dsans-serif=20
size=3D2>GPR08: 00000036 c0333fe4 00006b61 c0360000 44000028 f7fbfffc =
0fffac00=20
ffffffff</FONT> <BR><FONT face=3Dsans-serif size=3D2>GPR16: 00800000 =
007fff00=20
df821f78 c02d0000 c0330000 c0330000 00000000 0fff5464</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>GPR24: c0330000 c02d0000 00000000 00000000 =
e1056000=20
df841218 df841218 e1056004</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>NIP=20
[c0297f4c] 0xc0297f4c</FONT> <BR><FONT face=3Dsans-serif size=3D2>LR =
[c0297f44]=20
0xc0297f44</FONT> <BR><FONT face=3Dsans-serif size=3D2>Call =
Trace:</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>[df821f10] [c0297f44] 0xc0297f44 =
(unreliable)</FONT>=20
<BR><FONT face=3Dsans-serif size=3D2>[df821f40] [c01617dc]=20
pci_fixup_device+0xec/0x140</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>[df821f60]=20
[c0295ae0] 0xc0295ae0</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>[df821f70]=20
[c030c198] kernel_init+0x9c/0x290</FONT> <BR><FONT face=3Dsans-serif=20
size=3D2>[df821ff0] [c0010a6c] kernel_thread+0x44/0x60</FONT> <BR><FONT=20
face=3Dsans-serif size=3D2>Instruction dump:</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX</FONT> <BR><FONT face=3Dsans-serif size=3D2>XXXXXXXX XXXXXXXX =
XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>---[ end trace 97996e90be8a1237 ]---</FONT> <BR><FONT =
face=3Dsans-serif=20
size=3D2>Kernel panic - not syncing: Attempted to kill init!</FONT> =
<BR><FONT=20
face=3Dsans-serif size=3D2>Rebooting in 180 seconds..</FONT> =
<BR><BR><FONT=20
face=3Dsans-serif size=3D2>where resource start =3D 0x80000000 is the =
physical address=20
of the USB controller, base =3D 0xe1056000 is the virtual =
address.</FONT>=20
<BR><BR><FONT face=3Dsans-serif size=3D2>Does anyone know this kind of =
problem and=20
can give me a hint.</FONT> <BR><BR><FONT face=3Dsans-serif size=3D2>Kind =

Regards,</FONT> <BR><FONT face=3Dsans-serif size=3D2>Joachim</FONT>=20
<BR><BR><BR><FONT face=3Dsans-serif size=3D2>-- <BR>Dipl.-Ing. Joachim=20
Bader<BR>Research &amp; Technology<BR>Cockpit and Display =
Systems<BR><BR>Diehl=20
Aerospace GmbH<BR>An der Sandelmuehle 13<BR>D-60439 Frankfurt<BR>Phone=20
+49-69-5805-1270<BR>Fax &nbsp; &nbsp; &nbsp; +49-69-5805-1400<BR>e-mail: =

&nbsp;joachim.bader@diehl-aerospace.de<BR>http://www.diehl-aerospace.de</=
FONT>=20
<BR><BR><BR><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">___________________________________________________=
____________________________________________________________________</SPA=
N><BR><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">Der=20
Inhalt dieser E-Mail ist f=FCr den Absender rechtlich nicht verbindlich. =

</SPAN><BR><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">Informieren=20
Sie uns bitte, wenn Sie diese E-Mail f=E4lschlicherweise erhalten haben =
(Fax:=20
+49-69-5805-1399). Bitte l=F6schen Sie in diesem Fall die Nachricht. =
Jede Form der=20
weiteren Benutzung ist untersagt.</SPAN><BR><BR><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">The=20
content of this e-mail is not legally binding upon the =
sender.</SPAN><BR><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">If=20
this e-mail was transmitted to you by error, then please inform us =
accordingly=20
(Fax: +49-69-5805-1399). In such case you are requested to erase the =
message.=20
Any use of such e-mail message is strictly=20
prohibited.</SPAN><BR><BR></BODY></HTML>

------_=_NextPart_002_01C91995.852F1408--

------_=_NextPart_001_01C91995.852F1408
Content-Type: text/plain;
	name="ATT2697149.txt"
Content-Transfer-Encoding: base64
Content-Description: ATT2697149.txt
Content-Disposition: inline;
	filename="ATT2697149.txt"

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkxpbnV4cHBj
LWVtYmVkZGVkIG1haWxpbmcgbGlzdA0KTGludXhwcGMtZW1iZWRkZWRAb3psYWJzLm9yZw0KaHR0
cHM6Ly9vemxhYnMub3JnL21haWxtYW4vbGlzdGluZm8vbGludXhwcGMtZW1iZWRkZWQ=

------_=_NextPart_001_01C91995.852F1408--

Return-Path: <Kevin.Dockan@plexus.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C917B9.3EFB9A75"
Subject: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine checkexception
Date: Tue, 16 Sep 2008 00:01:14 -0500
Message-ID: <C23D99018D2D774E8BF7B052C0009F1F0297BAA6@CO-MAIL-001.ms1.plexus.com>
From: "Kevin Dockan" <Kevin.Dockan@plexus.com>
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

------_=_NextPart_001_01C917B9.3EFB9A75
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


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



------_=_NextPart_001_01C917B9.3EFB9A75
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine =
checkexception</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello everybody, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am trying to put into operation a =
proprietary board using a freescale MPC8641D. I use U-boot 1.3.0 and =
Linux kernel 2.6.25-11. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">On one PCIe-bus I have a PEX8518 =
followed by a PEX8114. A USB-controller is connected to the 8114. =
</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 +--------------------------+ =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0| </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 | =A0 =A0 =A0 MPC 8641 D =A0 =
=A0 =A0 =A0 | </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0| </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 +--------------------------+ =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PEX8518 =
&lt;----------------- PCIe switch </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PEX8114 =
&lt;----------------- PCIe to PCI bridge </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ISP1562 =
&lt;----------------- USB controller </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The PCIe-components are scanned =
correctly, resources (mem and IO) are assigned (correctly as far as I =
understand), </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">but on the first read access to a =
control register of the usb-device the kernel generates &quot;Oops: =
Machine check, sig: 7 [#1]&quot;. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Writing to the same register does not =
produce an &quot;Oops&quot;. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The PCIe bus is defined in dts file as =
follows (dump from U-boot): </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 pcie@d4008000 { </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 cell-index =3D =
&lt;0&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 compatible =3D =
&quot;fsl,mpc8641-pcie&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 device_type =3D =
&quot;pci&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #interrupt-cells =3D =
&lt;1&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #size-cells =3D =
&lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #address-cells =3D =
&lt;3&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 reg =3D &lt;1000&gt;; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 bus-range =3D =
&lt;4&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 ranges =3D [02 00 00 =
00 00 00 00 00 40 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 =
00 00 00 00 00 c0 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00]; =
</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 clock-frequency =3D =
&lt;1fca055&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-parent =3D =
&lt;40000&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupts =3D =
&lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-map-mask =3D =
[00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 07]; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-map =3D [00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00 00 00 =
00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00 00 00 =
00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 =
04 00 00 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 04 00 04 00 00 00 00 00 03 00 00 00 01]; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 pcie@0 { </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 reg =3D [00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 #size-cells =
=3D &lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 #address-cells =
=3D &lt;3&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 device_type =
=3D &quot;pci&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 ranges =3D [02 =
00 00 00 00 00 00 00 40 00 00 00 02 00 00 00 00 00 00 00 40 00 00 00 00 =
00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 01 00 00 00 00 =
00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00]; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 }; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 }; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 pcie@d4009000 { </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 cell-index =3D =
&lt;1&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 compatible =3D =
&quot;fsl,mpc8641-pcie&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 device_type =3D =
&quot;pci&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #interrupt-cells =3D =
&lt;1&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #size-cells =3D =
&lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 #address-cells =3D =
&lt;3&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 reg =3D &lt;1000&gt;; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 bus-range =3D =
&lt;6&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 ranges =3D [02 00 00 =
00 00 00 00 00 80 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 =
00 00 00 00 00 c0 10 00 00 c0 10 00 00 00 00 00 00 00 10 00 00]; =
</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 clock-frequency =3D =
&lt;1fca055&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-parent =3D =
&lt;40000&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupts =3D =
&lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-map-mask =3D =
[00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00 07]; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 interrupt-map =3D [00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00 04 00 =
00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00 00 00 =
00 00 05 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 =
04 00 00 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 04 00 04 00 00 00 00 00 07 00 00 00 01]; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 pcie@0 { </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 reg =3D [00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 #size-cells =
=3D &lt;2&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 #address-cells =
=3D &lt;3&gt;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 device_type =
=3D &quot;pci&quot;; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 =A0 =A0 ranges =3D [02 =
00 00 00 00 00 00 00 80 00 00 00 02 00 00 00 00 00 00 00 80 00 00 00 00 =
00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 01 00 00 00 00 =
00 00 00 c0 10 00 00 00 00 00 00 00 10 00 00]; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 =A0 =A0 }; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">=A0 =A0 }; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">and here the output from kernel: =
</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">quirk_usb_handoff_ohci: resource start =
=3D 0x80000000, len =3D 0x00001000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">quirk_usb_handoff_ohci: base =3D =
0xe1056000, offset =3D 0x00000004 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Machine check in kernel mode. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Caused by (from SRR1=3D149030): =
Transfer error ack signal </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oops: Machine check, sig: 7 [#1] =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TAURUS </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP: c0297f4c LR: c0297f44 CTR: =
c00115d0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">REGS: df821e60 TRAP: 0200 =A0 Not =
tainted =A0(2.6.25.11) </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MSR: 00149030 &lt;EE,ME,IR,DR&gt; =
=A0CR: 24000022 =A0XER: 00000000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TASK =3D df805410[1] 'swapper' THREAD: =
df820000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR00: c0297f44 df821f10 df805410 =
00000042 00000001 00000001 00000000 00020000 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR08: 00000036 c0333fe4 00006b61 =
c0360000 44000028 f7fbfffc 0fffac00 ffffffff </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR16: 00800000 007fff00 df821f78 =
c02d0000 c0330000 c0330000 00000000 0fff5464 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR24: c0330000 c02d0000 00000000 =
00000000 e1056000 df841218 df841218 e1056004 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP [c0297f4c] 0xc0297f4c </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">LR [c0297f44] 0xc0297f44 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Call Trace: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[df821f10] [c0297f44] 0xc0297f44 =
(unreliable) </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[df821f40] [c01617dc] =
pci_fixup_device+0xec/0x140 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[df821f60] [c0295ae0] 0xc0295ae0 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[df821f70] [c030c198] =
kernel_init+0x9c/0x290 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[df821ff0] [c0010a6c] =
kernel_thread+0x44/0x60 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Instruction dump: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">---[ end trace 97996e90be8a1237 ]--- =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kernel panic - not syncing: Attempted =
to kill init! </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Rebooting in 180 seconds.. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">where resource start =3D 0x80000000 is =
the physical address of the USB controller, base =3D 0xe1056000 is the =
virtual address. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Does anyone know this kind of problem =
and can give me a hint. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Kind Regards, </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Joachim </FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">-- </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Dipl.-Ing. Joachim Bader</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Research &amp; Technology</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Cockpit and Display Systems</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Diehl Aerospace GmbH</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">An der Sandelmuehle 13</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">D-60439 Frankfurt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Phone +49-69-5805-1270</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Fax =A0 =A0 =A0 =
+49-69-5805-1400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">e-mail: =
=A0joachim.bader@diehl-aerospace.de</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"><A =
HREF=3D"http://www.diehl-aerospace.de">http://www.diehl-aerospace.de</A> =
</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">__________________________________________________________=
_____________________________________________________________</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Der Inhalt dieser E-Mail ist f=FCr den =
Absender rechtlich nicht verbindlich. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Informieren Sie uns bitte, wenn Sie =
diese E-Mail f=E4lschlicherweise erhalten haben (Fax: +49-69-5805-1399). =
Bitte l=F6schen Sie in diesem Fall die Nachricht. Jede Form der weiteren =
Benutzung ist untersagt.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The content of this e-mail is not =
legally binding upon the sender.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">If this e-mail was transmitted to you =
by error, then please inform us accordingly (Fax: +49-69-5805-1399). In =
such case you are requested to erase the message. Any use of such e-mail =
message is strictly prohibited.</FONT></P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C917B9.3EFB9A75--

Return-Path: <joachim.bader@diehl-aerospace.de>
To: Linuxppc-embedded@ozlabs.org
Subject: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine check
	exception
MIME-Version: 1.0
From: joachim.bader@diehl-aerospace.de
Message-ID: <OFB9993B58.656F2E9A-ONC12574C5.00503B61-C12574C5.0052039C@diehl-gruppe.de>
Date: Mon, 15 Sep 2008 16:55:30 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0052039AC12574C5_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 0052039AC12574C5_=
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable

Hello everybody,

I am trying to put into operation a proprietary board using a freescale=20
MPC8641D. I use U-boot 1.3.0 and Linux kernel 2.6.25-11.
On one PCIe-bus I have a PEX8518 followed by a PEX8114. A USB-controller=20
is connected to the 8114.


    +--------------------------+
    |                          |
    |       MPC 8641 D         |
    |                          |
    +--------------------------+
                  |
               PEX8518 <----------------- PCIe switch
                  |
               PEX8114 <----------------- PCIe to PCI bridge
                  |
               ISP1562 <----------------- USB controller

The PCIe-components are scanned correctly, resources (mem and IO) are=20
assigned (correctly as far as I understand),
but on the first read access to a control register of the usb-device the=20
kernel generates "Oops: Machine check, sig: 7 [#1]".
Writing to the same register does not produce an "Oops".

The PCIe bus is defined in dts file as follows (dump from U-boot):

    pcie@d4008000 {
        cell-index =3D <0>;
        compatible =3D "fsl,mpc8641-pcie";
        device_type =3D "pci";
        #interrupt-cells =3D <1>;
        #size-cells =3D <2>;
        #address-cells =3D <3>;
        reg =3D <1000>;
        bus-range =3D <4>;
        ranges =3D [02 00 00 00 00 00 00 00 40 00 00 00 40 00 00 00 00 00 0=
0=20
00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 c0 00 00 00 00 00 00 00=
=20
00 10 00 00];
        clock-frequency =3D <1fca055>;
        interrupt-parent =3D <40000>;
        interrupts =3D <2>;
        interrupt-map-mask =3D [00 00 ff 00 00 00 00 00 00 00 00 00 00 00 0=
0=20
07];
        interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01=
=20
00 04 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00=
=20
00 00 02 00 04 00 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00=
=20
00 00 00 00 00 03 00 04 00 00 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00=
=20
00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 03 00 00 00 01];
        pcie@0 {
            reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
=20
00 00];
            #size-cells =3D <2>;
            #address-cells =3D <3>;
            device_type =3D "pci";
            ranges =3D [02 00 00 00 00 00 00 00 40 00 00 00 02 00 00 00 00=
=20
00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00=
=20
00 00 01 00 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00];
        };
    };
    pcie@d4009000 {
        cell-index =3D <1>;
        compatible =3D "fsl,mpc8641-pcie";
        device_type =3D "pci";
        #interrupt-cells =3D <1>;
        #size-cells =3D <2>;
        #address-cells =3D <3>;
        reg =3D <1000>;
        bus-range =3D <6>;
        ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 00 00 0=
0=20
00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 c0 10 00 00 00 00 00 00=
=20
00 10 00 00];
        clock-frequency =3D <1fca055>;
        interrupt-parent =3D <40000>;
        interrupts =3D <2>;
        interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 00 00 00 00 00 0=
0=20
07];
        interrupt-map =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01=
=20
00 04 00 00 00 00 00 04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00=
=20
00 00 02 00 04 00 00 00 00 00 05 00 00 00 01 00 00 00 00 00 00 00 00 00 00=
=20
00 00 00 00 00 03 00 04 00 00 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00=
=20
00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 07 00 00 00 01];
        pcie@0 {
            reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
=20
00 00];
            #size-cells =3D <2>;
            #address-cells =3D <3>;
            device_type =3D "pci";
            ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 02 00 00 00 00=
=20
00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10=
=20
00 00 01 00 00 00 00 00 00 00 c0 10 00 00 00 00 00 00 00 10 00 00];
        };
    };

and here the output from kernel:

quirk_usb_handoff_ohci: resource start =3D 0x80000000, len =3D 0x00001000
quirk_usb_handoff_ohci: base =3D 0xe1056000, offset =3D 0x00000004
Machine check in kernel mode.
Caused by (from SRR1=3D149030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
TAURUS
NIP: c0297f4c LR: c0297f44 CTR: c00115d0
REGS: df821e60 TRAP: 0200   Not tainted  (2.6.25.11)
MSR: 00149030 <EE,ME,IR,DR>  CR: 24000022  XER: 00000000
TASK =3D df805410[1] 'swapper' THREAD: df820000
GPR00: c0297f44 df821f10 df805410 00000042 00000001 00000001 00000000=20
00020000
GPR08: 00000036 c0333fe4 00006b61 c0360000 44000028 f7fbfffc 0fffac00=20
ffffffff
GPR16: 00800000 007fff00 df821f78 c02d0000 c0330000 c0330000 00000000=20
0fff5464
GPR24: c0330000 c02d0000 00000000 00000000 e1056000 df841218 df841218=20
e1056004
NIP [c0297f4c] 0xc0297f4c
LR [c0297f44] 0xc0297f44
Call Trace:
[df821f10] [c0297f44] 0xc0297f44 (unreliable)
[df821f40] [c01617dc] pci_fixup_device+0xec/0x140
[df821f60] [c0295ae0] 0xc0295ae0
[df821f70] [c030c198] kernel_init+0x9c/0x290
[df821ff0] [c0010a6c] kernel_thread+0x44/0x60
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 97996e90be8a1237 ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

where resource start =3D 0x80000000 is the physical address of the USB=20
controller, base =3D 0xe1056000 is the virtual address.

Does anyone know this kind of problem and can give me a hint.

Kind Regards,
Joachim


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
http://www.diehl-aerospace.de



___________________________________________________________________________=
____________________________________________
Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht verbindl=
ich.=20
Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erh=
alten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem Fall =
die Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us accor=
dingly (Fax: +49-69-5805-1399). In such case you are requested to erase the=
 message. Any use of such e-mail message is strictly prohibited.

--=_alternative 0052039AC12574C5_=
Content-Type: text/html; charset="utf-8"
content-transfer-encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello everybody,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am trying to put into operation a
proprietary board using a freescale MPC8641D. I use U-boot 1.3.0 and Linux
kernel 2.6.25-11.</font>
<br><font size=3D2 face=3D"sans-serif">On one PCIe-bus I have a PEX8518 fol=
lowed
by a PEX8114. A USB-controller is connected to the 8114.</font>
<br>
<br>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; +--------------------=
------+</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; | &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</fon=
t>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; | &nbsp; &nbsp; &nbsp;
MPC 8641 D &nbsp; &nbsp; &nbsp; &nbsp; |</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; | &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|</fon=
t>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; +--------------------=
------+</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; |</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;PEX8518 &lt;----------------- PCIe switch</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; |</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;PEX8114 &lt;----------------- PCIe to PCI bridge</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; |</font>
<br><font size=3D2 face=3D"Courier New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;ISP1562 &lt;----------------- USB controller</font>
<br>
<br><font size=3D2 face=3D"sans-serif">The PCIe-components are scanned corr=
ectly,
resources (mem and IO) are assigned (correctly as far as I understand),</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">but on the first read access to a co=
ntrol
register of the usb-device the kernel generates &quot;Oops: Machine check,
sig: 7 [#1]&quot;.</font>
<br><font size=3D2 face=3D"sans-serif">Writing to the same register does not
produce an &quot;Oops&quot;.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">The PCIe bus is defined in dts file
as follows (dump from U-boot):</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; pcie@d4008000 {</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cell-ind=
ex
=3D &lt;0&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; compatib=
le
=3D &quot;fsl,mpc8641-pcie&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; device_t=
ype
=3D &quot;pci&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #interru=
pt-cells
=3D &lt;1&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #size-ce=
lls
=3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #address=
-cells
=3D &lt;3&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; reg =3D =
&lt;1000&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus-range
=3D &lt;4&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; ranges =
=3D
[02 00 00 00 00 00 00 00 40 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00
01 00 00 00 00 00 00 00 c0 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00];</=
font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; clock-fr=
equency
=3D &lt;1fca055&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-parent
=3D &lt;40000&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
ts
=3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-map-mask
=3D [00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 07];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-map
=3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00
00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00
00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
03 00 04 00 00 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 04 00 04 00 00 00 00 00 03 00 00 00 01];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; pcie@0 {=
</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00];</fon=
t>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
#size-cells =3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
#address-cells =3D &lt;3&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
device_type =3D &quot;pci&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
ranges =3D [02 00 00 00 00 00 00 00 40 00 00 00 02 00 00 00 00 00 00 00 40
00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 01
00 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; };</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; };</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; pcie@d4009000 {</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cell-ind=
ex
=3D &lt;1&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; compatib=
le
=3D &quot;fsl,mpc8641-pcie&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; device_t=
ype
=3D &quot;pci&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #interru=
pt-cells
=3D &lt;1&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #size-ce=
lls
=3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; #address=
-cells
=3D &lt;3&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; reg =3D =
&lt;1000&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus-range
=3D &lt;6&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; ranges =
=3D
[02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00
01 00 00 00 00 00 00 00 c0 10 00 00 c0 10 00 00 00 00 00 00 00 10 00 00];</=
font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; clock-fr=
equency
=3D &lt;1fca055&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-parent
=3D &lt;40000&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
ts
=3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-map-mask
=3D [00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00 07];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; interrup=
t-map
=3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00
04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00
00 00 00 00 05 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
03 00 04 00 00 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 04 00 04 00 00 00 00 00 07 00 00 00 01];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; pcie@0 {=
</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
reg =3D [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00];</fon=
t>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
#size-cells =3D &lt;2&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
#address-cells =3D &lt;3&gt;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
device_type =3D &quot;pci&quot;;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;
ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 02 00 00 00 00 00 00 00 80
00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 01
00 00 00 00 00 00 00 c0 10 00 00 00 00 00 00 00 10 00 00];</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; };</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; };</font>
<br>
<br><font size=3D2 face=3D"sans-serif">and here the output from kernel:</fo=
nt>
<br>
<br><font size=3D2 face=3D"sans-serif">quirk_usb_handoff_ohci: resource sta=
rt
=3D 0x80000000, len =3D 0x00001000</font>
<br><font size=3D2 face=3D"sans-serif">quirk_usb_handoff_ohci: base =3D 0xe=
1056000,
offset =3D 0x00000004</font>
<br><font size=3D2 face=3D"sans-serif">Machine check in kernel mode.</font>
<br><font size=3D2 face=3D"sans-serif">Caused by (from SRR1=3D149030): Tran=
sfer
error ack signal</font>
<br><font size=3D2 face=3D"sans-serif">Oops: Machine check, sig: 7 [#1]</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">TAURUS</font>
<br><font size=3D2 face=3D"sans-serif">NIP: c0297f4c LR: c0297f44 CTR: c001=
15d0</font>
<br><font size=3D2 face=3D"sans-serif">REGS: df821e60 TRAP: 0200 &nbsp; Not
tainted &nbsp;(2.6.25.11)</font>
<br><font size=3D2 face=3D"sans-serif">MSR: 00149030 &lt;EE,ME,IR,DR&gt; &n=
bsp;CR:
24000022 &nbsp;XER: 00000000</font>
<br><font size=3D2 face=3D"sans-serif">TASK =3D df805410[1] 'swapper' THREA=
D:
df820000</font>
<br><font size=3D2 face=3D"sans-serif">GPR00: c0297f44 df821f10 df805410 00=
000042
00000001 00000001 00000000 00020000</font>
<br><font size=3D2 face=3D"sans-serif">GPR08: 00000036 c0333fe4 00006b61 c0=
360000
44000028 f7fbfffc 0fffac00 ffffffff</font>
<br><font size=3D2 face=3D"sans-serif">GPR16: 00800000 007fff00 df821f78 c0=
2d0000
c0330000 c0330000 00000000 0fff5464</font>
<br><font size=3D2 face=3D"sans-serif">GPR24: c0330000 c02d0000 00000000 00=
000000
e1056000 df841218 df841218 e1056004</font>
<br><font size=3D2 face=3D"sans-serif">NIP [c0297f4c] 0xc0297f4c</font>
<br><font size=3D2 face=3D"sans-serif">LR [c0297f44] 0xc0297f44</font>
<br><font size=3D2 face=3D"sans-serif">Call Trace:</font>
<br><font size=3D2 face=3D"sans-serif">[df821f10] [c0297f44] 0xc0297f44 (un=
reliable)</font>
<br><font size=3D2 face=3D"sans-serif">[df821f40] [c01617dc] pci_fixup_devi=
ce+0xec/0x140</font>
<br><font size=3D2 face=3D"sans-serif">[df821f60] [c0295ae0] 0xc0295ae0</fo=
nt>
<br><font size=3D2 face=3D"sans-serif">[df821f70] [c030c198] kernel_init+0x=
9c/0x290</font>
<br><font size=3D2 face=3D"sans-serif">[df821ff0] [c0010a6c] kernel_thread+=
0x44/0x60</font>
<br><font size=3D2 face=3D"sans-serif">Instruction dump:</font>
<br><font size=3D2 face=3D"sans-serif">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX</font>
<br><font size=3D2 face=3D"sans-serif">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX</font>
<br><font size=3D2 face=3D"sans-serif">---[ end trace 97996e90be8a1237 ]---=
</font>
<br><font size=3D2 face=3D"sans-serif">Kernel panic - not syncing: Attempted
to kill init!</font>
<br><font size=3D2 face=3D"sans-serif">Rebooting in 180 seconds..</font>
<br>
<br><font size=3D2 face=3D"sans-serif">where resource start =3D 0x80000000 =
is
the physical address of the USB controller, base =3D 0xe1056000 is the virt=
ual
address.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Does anyone know this kind of problem
and can give me a hint.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Kind Regards,</font>
<br><font size=3D2 face=3D"sans-serif">Joachim</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">-- <br>
Dipl.-Ing. Joachim Bader<br>
Research &amp; Technology<br>
Cockpit and Display Systems<br>
<br>
Diehl Aerospace GmbH<br>
An der Sandelmuehle 13<br>
D-60439 Frankfurt<br>
Phone +49-69-5805-1270<br>
Fax &nbsp; &nbsp; &nbsp; +49-69-5805-1400<br>
e-mail: &nbsp;joachim.bader@diehl-aerospace.de<br>
http://www.diehl-aerospace.de</font>
<br>
<br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">______________________________________________________________________=
_________________________________________________</span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht ver=
bindlich. </span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweis=
e erhalten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem =
Fall die Nachricht. Jede Form der weiteren Benutzung ist untersagt.</span><=
br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">The content of this e-mail is not legally binding upon the sender.</sp=
an><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">If this e-mail was transmitted to you by error, then please inform us =
accordingly (Fax: +49-69-5805-1399). In such case you are requested to eras=
e the message. Any use of such e-mail message is strictly prohibited.</span=
><br>
<br>
--=_alternative 0052039AC12574C5_=--

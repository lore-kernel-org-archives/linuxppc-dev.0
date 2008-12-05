Return-Path: <gianfranco.casanova@alice.it>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by ozlabs.org (Postfix) with ESMTP id 60A7FDDDE6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 02:17:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C956EC.9202E3BF"
Subject: R: usb/eth DTS nodes for custom board based on mpc5200
Date: Fri, 5 Dec 2008 16:16:06 +0100
Message-ID: <47602D18F269934AB73B7E550804A1E002137987@FBCMST09V03.fbc.local>
References: <504269.31435.qm@web23108.mail.ird.yahoo.com>
	<fa686aa40812050640m4b4afe2egef638ca950cff041@mail.gmail.com>
From: <gianfranco.casanova@alice.it>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	<s104259@yahoo.it>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C956EC.9202E3BF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Grant

we have already tested what you are suggesting, but nothing happens.

I'm supposing the problem comes from interrupts.

In fact USB is still alive, every 5 sec. we can see some timeout =
messages.

(from previous post)

root@RadioNav: ~ #[   24.027842] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   29.199841] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   34.307841] usb 1-2: khubd timed out on ep0in =
len=3D0/64
root@RadioNav: ~ #[   34.382786] ppc-of-ohci f0001000.usb: GetStatus =
roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS
root@RadioNav: ~ #[   34.446789] usb 1-2: device descriptor read/64, =
error -110
root@RadioNav: ~ #
root@RadioNav: ~ #cat /proc/interrupts
           CPU0
134:       5689  MPC52xx Peripherals Edge      ohci_hcd:usb1
139:        207  MPC52xx Peripherals Edge      mpc52xx_psc_uart
143:          0  MPC52xx Peripherals Edge      i2c-mpc
144:          0  MPC52xx Peripherals Edge      i2c-mpc
BAD:          0

Ideas :( ??
Thanks J

P.S. Using lite5200 EVB USB works well using almost same drivers.

-----Messaggio originale-----
Da: linuxppc-dev-bounces+gianfranco.casanova=3Dalice.it@ozlabs.org per =
conto di Grant Likely
Inviato: ven 05/12/2008 15.40
A: s104259@yahoo.it
Cc: linuxppc-dev; devicetree-discuss@ozlabs.org
Oggetto: Re: usb/eth DTS nodes for custom board based on mpc5200
=20
On Fri, Dec 5, 2008 at 4:22 AM, Angelo <s104259@yahoo.it> wrote:
> Hi all.
>
> I'd like to know if it's necessary to modify my DTS.
>
> On my board I have:
> * u-boot 1.2.0
> * kernel 2.6.21
> * arch=3Dpowerpc
> * dts based on lite5200b.dts
> * USB port (USB2) configured on the Ethernet port
>
> Is it necessary to combine Ethernet and usb nodes into the device tree
> source?

No.  Configuring the Ethernet pins for USB IO is just a pin routing
board setup task.  You do need to make sure U-Boot sets up the
port_config register correctly, but it doesn't impact the device tree.
 You don't need to change any of the values in the USB node.

However, if the Ethernet device is unused then you should remove the
Ethernet node from your device tree.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev


------_=_NextPart_001_01C956EC.9202E3BF
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.27">
<TITLE>R: usb/eth DTS nodes for custom board based on mpc5200</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Grant<BR>
<BR>
we have already tested what you are suggesting, but nothing happens.<BR>
<BR>
I'm supposing the problem comes from interrupts.<BR>
<BR>
In fact USB is still alive, every 5 sec. we can see some timeout =
messages.<BR>
<BR>
(from previous post)<BR>
<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 24.027842] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 29.199841] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.307841] usb 1-2: khubd timed out on =
ep0in len=3D0/64<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.382786] ppc-of-ohci f0001000.usb: =
GetStatus roothub.portstatus [1] =3D 0x00100103 PRSC PPS PES CCS<BR>
root@RadioNav: ~ #[&nbsp;&nbsp; 34.446789] usb 1-2: device descriptor =
read/64, error -110<BR>
root@RadioNav: ~ #<BR>
root@RadioNav: ~ #cat /proc/interrupts<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<BR>
134:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5689&nbsp; MPC52xx Peripherals =
Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ohci_hcd:usb1<BR>
139:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 207&nbsp; MPC52xx =
Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc52xx_psc_uart<BR>
143:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
144:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; =
MPC52xx Peripherals Edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c-mpc<BR>
BAD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>
<BR>
Ideas :( ??<BR>
Thanks J<BR>
<BR>
P.S. Using lite5200 EVB USB works well using almost same drivers.<BR>
<BR>
-----Messaggio originale-----<BR>
Da: linuxppc-dev-bounces+gianfranco.casanova=3Dalice.it@ozlabs.org per =
conto di Grant Likely<BR>
Inviato: ven 05/12/2008 15.40<BR>
A: s104259@yahoo.it<BR>
Cc: linuxppc-dev; devicetree-discuss@ozlabs.org<BR>
Oggetto: Re: usb/eth DTS nodes for custom board based on mpc5200<BR>
<BR>
On Fri, Dec 5, 2008 at 4:22 AM, Angelo &lt;s104259@yahoo.it&gt; =
wrote:<BR>
&gt; Hi all.<BR>
&gt;<BR>
&gt; I'd like to know if it's necessary to modify my DTS.<BR>
&gt;<BR>
&gt; On my board I have:<BR>
&gt; * u-boot 1.2.0<BR>
&gt; * kernel 2.6.21<BR>
&gt; * arch=3Dpowerpc<BR>
&gt; * dts based on lite5200b.dts<BR>
&gt; * USB port (USB2) configured on the Ethernet port<BR>
&gt;<BR>
&gt; Is it necessary to combine Ethernet and usb nodes into the device =
tree<BR>
&gt; source?<BR>
<BR>
No.&nbsp; Configuring the Ethernet pins for USB IO is just a pin =
routing<BR>
board setup task.&nbsp; You do need to make sure U-Boot sets up the<BR>
port_config register correctly, but it doesn't impact the device =
tree.<BR>
&nbsp;You don't need to change any of the values in the USB node.<BR>
<BR>
However, if the Ethernet device is unused then you should remove the<BR>
Ethernet node from your device tree.<BR>
<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
_______________________________________________<BR>
Linuxppc-dev mailing list<BR>
Linuxppc-dev@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C956EC.9202E3BF--

Return-Path: <Jani.Sarkijarvi@elektrobit.com>
Received: from smtpgw1fi.elektrobit.com (smtpgw1fi.elektrobit.com
	[192.194.253.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtpgw1fi.elektrobit.com",
	Issuer "Elektrobit Group" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DC943DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 20:35:39 +1000 (EST)
Received: from fioues07.ebgroup.elektrobit.com
	(fioues07.ebgroup.elektrobit.com [172.16.33.117])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.6) with ESMTP id
	m8JAPqaX002030
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 13:25:52 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91A42.17A72927"
Subject: TQM5200 I2C Second bus
Date: Fri, 19 Sep 2008 13:25:52 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C01A179F3@fioues08.ebgroup.elektrobit.com>
From: <Jani.Sarkijarvi@elektrobit.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format...

------_=_NextPart_001_01C91A42.17A72927
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm using TQM5200 (MPC5200) chip with linux-2.6-denx. Problem is to get sec=
ond I2c bus to work (/dev/i2c-0) . /dev/i2c-1 seems to be internal bus and =
I can read ex. lm75 temperature sensor, also I can see traffic in oscillosc=
ope (only error is "I2C: No RXAK", but it seems to be working). My .dts set=
up is:


 i2c@3d00 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
                        reg =3D <0x3d00 0x40>; // mapped to /dev/i2c-0
                        cell-index =3D <0>;
                        interrupts =3D <2 16 0>; //neather <2 15 0> is not =
working says: I2C: MAL
                        interrupt-parent =3D <&mpc5200_pic>;
                        fsl5200-clocking;

                };

                i2c@3d40 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>; // mapped to /dev/i2c-1
                        compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
                        reg =3D <0x3d40 0x40>;
                        cell-index =3D <1>;
                        interrupts =3D <2 16 0>;
                        interrupt-parent =3D <&mpc5200_pic>;
                        fsl5200-clocking;
                        rtc@68 {
                                device_type =3D "rtc";
                                compatible =3D "dallas,ds1307";
                                reg =3D <0x68>;
                        };

                };

And kernel says in boot:
[    1.270973] i2c /dev entries driver
[    1.275664] i2c-core: driver [dev_driver] registered
[    1.276395] i2c-adapter i2c-0: adapter [MPC adapter] registered
[    1.277066] i2c-dev: adapter [MPC adapter] registered as minor 0
[    1.277802] i2c-adapter i2c-1: adapter [MPC adapter] registered
[    1.277975] i2c 1-0068: uevent
[    1.278415] i2c-adapter i2c-1: client [ds1307] registered with bus id 1-=
0068
[    1.279042] i2c-dev: adapter [MPC adapter] registered as minor 1


And:
# ls -la /dev/i2c-*
crwxrwxrwx  1 root root 89, 0 Aug 13  2008 /dev/i2c-0
crwxrwxrwx  1 root root 89, 1 Aug 14  2008 /dev/i2c-1
#

If I try read something from /dev/i2c-0, it says:
# dmesg
[ 2628.107343] i2c-adapter i2c-0: ioctl, cmd=3D0x703, arg=3D0x01
[ 2628.107880] i2c-dev: i2c-0 reading 2 bytes.
[ 2628.107934] i2c-adapter i2c-0: master_xfer[0] R, addr=3D0x01, len=3D2
[ 2628.107956] Doing read 2 bytes to 0x01 - 1 of 1 messages
[ 2629.105411] I2C: wait timeout

Any ideas?

Best Regards,=20
Jani S=E4rkij=E4rvi




----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------_=_NextPart_001_01C91A42.17A72927
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24">
<TITLE>TQM5200 I2C Second bus</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I'm using TQM5200 (MPC5200) chip with linux-2.6-denx. Problem is to get sec=
ond I2c bus to work (/dev/i2c-0) . /dev/i2c-1 seems to be internal bus and =
I can read ex. lm75 temperature sensor, also I can see traffic in oscillosc=
ope (only error is &quot;I2C: No RXAK&quot;, but it seems to be working). M=
y .dts setup is:<BR>
<BR>
<BR>
&nbsp;i2c@3d00 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-ce=
lls =3D &lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells=
 =3D &lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =
=3D &quot;fsl,mpc5200-i2c&quot;,&quot;fsl-i2c&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt=
;0x3d00 0x40&gt;; // mapped to /dev/i2c-0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =
=3D &lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =
=3D &lt;2 16 0&gt;; //neather &lt;2 15 0&gt; is not working says: I2C: MAL<=
BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-p=
arent =3D &lt;&amp;mpc5200_pic&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl5200-clo=
cking;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; i2c@3d40 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-ce=
lls =3D &lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells=
 =3D &lt;0&gt;; // mapped to /dev/i2c-1<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =
=3D &quot;fsl,mpc5200-i2c&quot;,&quot;fsl-i2c&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt=
;0x3d40 0x40&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =
=3D &lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =
=3D &lt;2 16 0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-p=
arent =3D &lt;&amp;mpc5200_pic&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl5200-clo=
cking;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc@68 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;rtc&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;dallas,ds1307&quo=
t;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x68&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<BR>
<BR>
And kernel says in boot:<BR>
[&nbsp;&nbsp;&nbsp; 1.270973] i2c /dev entries driver<BR>
[&nbsp;&nbsp;&nbsp; 1.275664] i2c-core: driver [dev_driver] registered<BR>
[&nbsp;&nbsp;&nbsp; 1.276395] i2c-adapter i2c-0: adapter [MPC adapter] regi=
stered<BR>
[&nbsp;&nbsp;&nbsp; 1.277066] i2c-dev: adapter [MPC adapter] registered as =
minor 0<BR>
[&nbsp;&nbsp;&nbsp; 1.277802] i2c-adapter i2c-1: adapter [MPC adapter] regi=
stered<BR>
[&nbsp;&nbsp;&nbsp; 1.277975] i2c 1-0068: uevent<BR>
[&nbsp;&nbsp;&nbsp; 1.278415] i2c-adapter i2c-1: client [ds1307] registered=
 with bus id 1-0068<BR>
[&nbsp;&nbsp;&nbsp; 1.279042] i2c-dev: adapter [MPC adapter] registered as =
minor 1<BR>
<BR>
<BR>
And:<BR>
# ls -la /dev/i2c-*<BR>
crwxrwxrwx&nbsp; 1 root root 89, 0 Aug 13&nbsp; 2008 /dev/i2c-0<BR>
crwxrwxrwx&nbsp; 1 root root 89, 1 Aug 14&nbsp; 2008 /dev/i2c-1<BR>
#<BR>
<BR>
If I try read something from /dev/i2c-0, it says:<BR>
# dmesg<BR>
[ 2628.107343] i2c-adapter i2c-0: ioctl, cmd=3D0x703, arg=3D0x01<BR>
[ 2628.107880] i2c-dev: i2c-0 reading 2 bytes.<BR>
[ 2628.107934] i2c-adapter i2c-0: master_xfer[0] R, addr=3D0x01, len=3D2<BR>
[ 2628.107956] Doing read 2 bytes to 0x01 - 1 of 1 messages<BR>
[ 2629.105411] I2C: wait timeout<BR>
<BR>
Any ideas?<BR>
<BR>
Best Regards,<BR>
Jani S=E4rkij=E4rvi<BR>
<BR>
<BR>
</FONT>
</P>

<pre>
----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.
</pre>

</BODY>
</HTML>
------_=_NextPart_001_01C91A42.17A72927--

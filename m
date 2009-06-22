Return-Path: <lada.podivin@gmail.com>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 3BABEB7134
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 02:48:40 +1000 (EST)
Received: by bwz26 with SMTP id 26so3755293bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 09:48:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1@ATLMBX.verint.corp.verintsystems.com>
References: <579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1@ATLMBX.verint.corp.verintsystems.com>
Date: Mon, 22 Jun 2009 18:48:34 +0200
Message-ID: <e35801cc0906220948v22a13e2fxfcae52d51e69c310@mail.gmail.com>
Subject: Re: ppc405ex GPIO mapping
From: Lada Podivin <lada.podivin@gmail.com>
To: "Cote, Sylvain" <Sylvain.Cote@verint.com>
Content-Type: multipart/alternative; boundary=001636c5aa7c1fc0d4046cf2a5ab
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c5aa7c1fc0d4046cf2a5ab
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have the same board and I had a similar problem. I use 2.6.30, so I don't
know whether 2.6.25 supports the following - however, here's my suggestion.
Set these options in your kernel config: CONFIG_GPIOLIB=y and
CONFIG_PPC4xx_GPIO=y. Before compilation do "export
KCPPFLAGS=-DARCH_NR_GPIOS=32" - you have to let the kernel know, that your
GPIO has 32 pins (default value is 255) and compile the kernel.

Then change the line

compatible = "ibm,gpio-405ex";

to

compatible = "ibm,ppc4xx-gpio";

Ok! After this long journey you shoul be able to work with your GPIO pins
with functions like gpio_set_value() - from include/linux/gpio.h.
Documentation of these functions can be seen at
http://www.mjmwired.net/kernel/Documentation/gpio.txt

So, this is my solution. Maybe there are better ones, but this works well
for me :)

Best,
Lada Podivin

--001636c5aa7c1fc0d4046cf2a5ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have the same board and I had a similar problem. I use 2.6.30,=
 so I don&#39;t know whether 2.6.25 supports the following - however, here&=
#39;s my suggestion. Set these options in your kernel config: CONFIG_GPIOLI=
B=3Dy and CONFIG_PPC4xx_GPIO=3Dy. Before compilation do &quot;export KCPPFL=
AGS=3D-DARCH_NR_GPIOS=3D32&quot; - you have to let the kernel know, that yo=
ur GPIO has 32 pins (default value is 255) and compile the kernel.<br>
<br>Then change the line <font face=3D"Arial" size=3D"2"><span style=3D"fon=
t-size: 10pt; font-family: Arial;" lang=3D"FR"><br><br>compatible =3D
&quot;ibm,gpio-405ex&quot;; <br><br>to<br><br>compatible =3D &quot;ibm,ppc4=
xx-gpio&quot;;<br><br>Ok! After this long journey you shoul be able to work=
 with your GPIO pins with functions like gpio_set_value() - from include/li=
nux/gpio.h.=A0 Documentation of these functions can be seen at <a href=3D"h=
ttp://www.mjmwired.net/kernel/Documentation/gpio.txt">http://www.mjmwired.n=
et/kernel/Documentation/gpio.txt</a><br>
<br>So, this is my solution. Maybe there are better ones, but this works we=
ll for me :)<br><br>Best,<br>Lada Podivin<br></span></font>=20

--001636c5aa7c1fc0d4046cf2a5ab--

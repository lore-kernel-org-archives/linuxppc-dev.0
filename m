Return-Path: <dceravigupta@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 28E96B6F14
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 23:27:17 +1000 (EST)
Received: by pxi17 with SMTP id 17so57001pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 06:27:16 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Aug 2010 18:57:16 +0530
Message-ID: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
Subject: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00163645915a540ff7048d8c3522
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163645915a540ff7048d8c3522
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to device driver development. I am trying to access the GPIO of
MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28.9 and
enable support for mpc8xxx_gpio.c. On boot up, it successfully detect two
gpio controllers. Now my question is how I am going to use it to communicate
with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c file to
do whatever I want to do with gpios or I can use the standard gpio API
provided in kernel ( gpio_request()/gpio_free() ). I also tries the standard
kernel API, but it fails. Here is my code :

#include <linux/module.h>
#include <linux/errno.h>  /* error codes */
#include <linux/gpio.h>

static __init int sample_module_init(void)
{
  int ret;

  int i;
  for (i=1; i<32; i++) {
    ret = gpio_request(i, "Sample Driver");
    if (ret) {
      printk(KERN_WARNING "sample_driver: unable to request GPIO_PG%d\n",
i);
      //return ret;
    }
  }

  return 0;
}

static __exit void sample_module_exit(void)
{
  gpio_free(9);
}

MODULE_LICENSE("GPL");

module_init(sample_module_init);
module_exit(sample_module_exit);

It give the following O/P:

[  617.075329] sample_driver: unable to request GPIO_PG1
[  617.080418] sample_driver: unable to request GPIO_PG2
[  617.085470] sample_driver: unable to request GPIO_PG3
[  617.090522] sample_driver: unable to request GPIO_PG4
[  617.095574] sample_driver: unable to request GPIO_PG5
[  617.100625] sample_driver: unable to request GPIO_PG6
[  617.105676] sample_driver: unable to request GPIO_PG7
[  617.110727] sample_driver: unable to request GPIO_PG8
[  617.115779] sample_driver: unable to request GPIO_PG9
[  617.120830] sample_driver: unable to request GPIO_PG10
[  617.125968] sample_driver: unable to request GPIO_PG11
[  617.131106] sample_driver: unable to request GPIO_PG12
[  617.136245] sample_driver: unable to request GPIO_PG13
[  617.141383] sample_driver: unable to request GPIO_PG14
[  617.146521] sample_driver: unable to request GPIO_PG15
[  617.151660] sample_driver: unable to request GPIO_PG16
[  617.156798] sample_driver: unable to request GPIO_PG17
[  617.161936] sample_driver: unable to request GPIO_PG18
[  617.167074] sample_driver: unable to request GPIO_PG19
[  617.172213] sample_driver: unable to request GPIO_PG20
[  617.177351] sample_driver: unable to request GPIO_PG21
[  617.182489] sample_driver: unable to request GPIO_PG22
[  617.187628] sample_driver: unable to request GPIO_PG23
[  617.192767] sample_driver: unable to request GPIO_PG24
[  617.197905] sample_driver: unable to request GPIO_PG25
[  617.203042] sample_driver: unable to request GPIO_PG26
[  617.208182] sample_driver: unable to request GPIO_PG27
[  617.213319] sample_driver: unable to request GPIO_PG28
[  617.218458] sample_driver: unable to request GPIO_PG29
[  617.223597] sample_driver: unable to request GPIO_PG30
[  617.228735] sample_driver: unable to request GPIO_PG31
[  617.233873] sample_driver: unable to request GPIO_PG32

Can someone provide me a sample code or something else. Actually I am trying
to set the GPIO pin no. 9 to active low as it is connected to a LED on
board.

Thanks in advance
Ravi Gupta

--00163645915a540ff7048d8c3522
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to device driver development. I am trying to access the=
 GPIO of MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28=
.9 and enable support for mpc8xxx_gpio.c. On boot up, it successfully detec=
t two gpio controllers. Now my question is how I am going to use it to comm=
unicate with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c =
file to do whatever I want to do with gpios or I can use the standard gpio =
API provided in kernel ( gpio_request()/gpio_free() ). I also tries the sta=
ndard kernel API, but it fails. Here is my code :<br>
<br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/errno.h&gt;=A0 /*=
 error codes */<br>#include &lt;linux/gpio.h&gt;<br><br>static __init int s=
ample_module_init(void)<br>{<br>=A0 int ret;<br><br>=A0 int i;<br>=A0 for (=
i=3D1; i&lt;32; i++) {<br>
=A0=A0=A0 ret =3D gpio_request(i, &quot;Sample Driver&quot;);<br>=A0=A0=A0 =
if (ret) {<br>=A0=A0=A0=A0=A0 printk(KERN_WARNING &quot;sample_driver: unab=
le to request GPIO_PG%d\n&quot;, i); <br>=A0=A0=A0=A0=A0 //return ret;<br>=
=A0=A0=A0 }=A0=A0 <br>=A0 }<br><br>=A0 return 0;<br>
}<br><br>static __exit void sample_module_exit(void)<br>{<br>=A0 gpio_free(=
9);<br>}<br><br>MODULE_LICENSE(&quot;GPL&quot;);<br><br>module_init(sample_=
module_init);<br>module_exit(sample_module_exit);<br><br>It give the follow=
ing O/P:<br>
<br>[=A0 617.075329] sample_driver: unable to request GPIO_PG1<br>[=A0 617.=
080418] sample_driver: unable to request GPIO_PG2<br>[=A0 617.085470] sampl=
e_driver: unable to request GPIO_PG3<br>[=A0 617.090522] sample_driver: una=
ble to request GPIO_PG4<br>
[=A0 617.095574] sample_driver: unable to request GPIO_PG5<br>[=A0 617.1006=
25] sample_driver: unable to request GPIO_PG6<br>[=A0 617.105676] sample_dr=
iver: unable to request GPIO_PG7<br>[=A0 617.110727] sample_driver: unable =
to request GPIO_PG8<br>
[=A0 617.115779] sample_driver: unable to request GPIO_PG9<br>[=A0 617.1208=
30] sample_driver: unable to request GPIO_PG10<br>[=A0 617.125968] sample_d=
river: unable to request GPIO_PG11<br>[=A0 617.131106] sample_driver: unabl=
e to request GPIO_PG12<br>
[=A0 617.136245] sample_driver: unable to request GPIO_PG13<br>[=A0 617.141=
383] sample_driver: unable to request GPIO_PG14<br>[=A0 617.146521] sample_=
driver: unable to request GPIO_PG15<br>[=A0 617.151660] sample_driver: unab=
le to request GPIO_PG16<br>
[=A0 617.156798] sample_driver: unable to request GPIO_PG17<br>[=A0 617.161=
936] sample_driver: unable to request GPIO_PG18<br>[=A0 617.167074] sample_=
driver: unable to request GPIO_PG19<br>[=A0 617.172213] sample_driver: unab=
le to request GPIO_PG20<br>
[=A0 617.177351] sample_driver: unable to request GPIO_PG21<br>[=A0 617.182=
489] sample_driver: unable to request GPIO_PG22<br>[=A0 617.187628] sample_=
driver: unable to request GPIO_PG23<br>[=A0 617.192767] sample_driver: unab=
le to request GPIO_PG24<br>
[=A0 617.197905] sample_driver: unable to request GPIO_PG25<br>[=A0 617.203=
042] sample_driver: unable to request GPIO_PG26<br>[=A0 617.208182] sample_=
driver: unable to request GPIO_PG27<br>[=A0 617.213319] sample_driver: unab=
le to request GPIO_PG28<br>
[=A0 617.218458] sample_driver: unable to request GPIO_PG29<br>[=A0 617.223=
597] sample_driver: unable to request GPIO_PG30<br>[=A0 617.228735] sample_=
driver: unable to request GPIO_PG31<br>[=A0 617.233873] sample_driver: unab=
le to request GPIO_PG32<br>
<br>Can someone provide me a sample code or something else. Actually I am t=
rying to set the GPIO pin no. 9 to active low as it is connected to a LED o=
n board. <br><br>Thanks in advance<br>Ravi Gupta<br>

--00163645915a540ff7048d8c3522--

Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 5F46CB70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 19:59:12 +1000 (EST)
Received: by pwj5 with SMTP id 5so616752pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 02:59:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100811164527.GA19793@oksana.dev.rtsoft.ru>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
	<20100811164527.GA19793@oksana.dev.rtsoft.ru>
Date: Fri, 13 Aug 2010 15:29:11 +0530
Message-ID: <AANLkTi=H1sKaGL8cHm9LAZm1tzm88dvkReXk12hmkWLj@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: multipart/mixed; boundary=001636457dded4137b048db18832
Cc: linuxppc-dev@ozlabs.org, MJ embd <mj.embd@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636457dded4137b048db18832
Content-Type: multipart/alternative; boundary=001636457dded41372048db18830

--001636457dded41372048db18830
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 11, 2010 at 10:15 PM, Anton Vorontsov <cbouatmailru@gmail.com>wrote:

> Hi,
>
> On Wed, Aug 11, 2010 at 06:57:16PM +0530, Ravi Gupta wrote:
> > I am new to device driver development. I am trying to access the GPIO of
> > MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28.9 and
> > enable support for mpc8xxx_gpio.c. On boot up, it successfully detect two
> > gpio controllers. Now my question is how I am going to use it to
> communicate
> > with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c file
> to
> > do whatever I want to do with gpios or I can use the standard gpio API
> > provided in kernel ( gpio_request()/gpio_free() ). I also tries the
> standard
> > kernel API, but it fails. Here is my code :
>
> No, you don't have to modify anything, and yes, you can
> use standard kernel GPIO API.
>
> > #include <linux/module.h>
> > #include <linux/errno.h>  /* error codes */
> > #include <linux/gpio.h>
> >
> > static __init int sample_module_init(void)
> > {
> >   int ret;
> >
> >   int i;
> >   for (i=1; i<32; i++) {
> >     ret = gpio_request(i, "Sample Driver");
>
> Before issing gpio_request() you must get GPIO number from the
> of_get_gpio() or of_get_gpio_flags() calls (the _flags variant
> will also retreive flags such as 'active-low').
>
> The calls assume that you have gpio = <> specifier in the
> device tree, see arch/powerpc/boot/dts/mpc8377_rdb.dts's
> "leds" node as an example.
>
> As you want GPIO LEDs, you can use drivers/leds/leds-gpio.c
> (see of_gpio_leds_probe() call, it gets gpio numbers via
> of_get_gpio_flags() and then requests them via gpio_request()).
>
> Also see
>
> Documentation/powerpc/dts-bindings/gpio/gpio.txt
> Documentation/powerpc/dts-bindings/gpio/led.txt
>
> >     if (ret) {
> >       printk(KERN_WARNING "sample_driver: unable to request GPIO_PG%d\n",
> > i);
> >       //return ret;
> >     }
> >   }
> >
> >   return 0;
> > }
>
>
> On Wed, Aug 11, 2010 at 07:49:40PM +0530, Ravi Gupta wrote:
> > Also, when I try to export a gpio in sysfs
> >
> > echo 9 > /sys/class/gpio/export
>
> The gpio numbers are global, i.e. GPIO controller base + GPIO
> number within the controller.
>
> [...]
> > drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip192
>
> So, if you want GPIO9 within gpiochip192, you should issue
> "echo 201 > export".
>
> Thanks,
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>

Hi Anton,

Thanks for the reply.
I had added the entries for gpio pin 9 for both controllers(I was not sure
with controller's pin is connected to LED, but now I know it is pin no. 233
i.e 224+9) in the mpc8377_rdb.dts file. Below is a portion of my dts file, I
have attached the complete dts file as attachment.

immr@e0000000 {
    #address-cells = <1>;
    #size-cells = <1>;
    device_type = "soc";
    compatible = "simple-bus";
    ranges = <0x0 0xe0000000 0x00100000>;
    reg = <0xe0000000 0x00000200>;
    bus-frequency = <0>;

    wdt@200 {
        device_type = "watchdog";
        compatible = "mpc83xx_wdt";
        reg = <0x200 0x100>;
    };

    gpio1: gpio-controller@c00 {
        #gpio-cells = <2>;
        compatible = "fsl,mpc8377-gpio", "fsl,mpc8349-gpio";
        reg = <0xc00 0x100>;
        interrupts = <74 0x8>;
        interrupt-parent = <&ipic>;
        gpio-controller;
    };

    gpio2: gpio-controller@d00 {
        #gpio-cells = <2>;
        compatible = "fsl,mpc8377-gpio", "fsl,mpc8349-gpio";
        reg = <0xd00 0x100>;
        interrupts = <75 0x8>;
        interrupt-parent = <&ipic>;
        gpio-controller;
    };

   * led@0 {
        compatible = "gpio-leds";
        label = "hdd";
        gpios = <&gpio1 9 0>;
    };

    led@1 {
        compatible = "gpio-leds";
        label = "rom";
        gpios = <&gpio2 9 0>;
    };*
    .
    .
    .
    .
};


Also I have enabled drivers/leds/leds-gpio.c in my kernel. To test whether
the leds entires in dts file get attached to leds-gpio driver, I added
printks in the probe function of the driver.

static int gpio_led_probe(struct platform_device *pdev)
{
  struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
  struct gpio_led *cur_led;
  struct gpio_led_data *leds_data, *led_dat;
  int i, ret = 0;

  *printk(KERN_INFO "led: inside gpio_led_probe.\n");*

  ....
}

But I couldn't see "led: inside gpio_led_probe." message in dmesg. I checked
sysfs and I can see entries of leds. Here is contents of sysfs on my
machine.

# ls /sys/devices/ -la
drwxr-xr-x    7 root     root            0 Jan  1 01:58 .
drwxr-xr-x   12 root     root            0 Jan  1 00:00 ..
drwxr-xr-x   22 root     root            0 Jan  1 01:58 *e0000000.immr*
drwxr-xr-x    5 root     root            0 Jan  1 01:58 e0005000.localbus
drwxr-xr-x    4 root     root            0 Jan  1 01:58 pci0000:00
drwxr-xr-x    9 root     root            0 Jan  1 01:58 platform
drwxr-xr-x    8 root     root            0 Jan  1 01:58 system


# ls /sys/devices/e0000000.immr/
bus                           e0004600.serial       *led1.0*
devspec                    e0007000.spi           *led2.1*
e0000200.wdt            e00082a8.dma         modalias
e0000700.interrupt-    e0018000.sata         name
e0000b00.power        e0019000.sata         power
e0000c00.gpio-contr  e0023000.usb          sleep-nexus.2
e0000d00.gpio-contr  e0024000.ethernet    subsystem
e0003100.i2c            e0025000.ethernet    uevent
e0004500.serial        e0030000.crypto

Is there something that I am doing wrong? Please suggest.

Thanks in Advance
Ravi Gupta

--001636457dded41372048db18830
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Wed, Aug 11, 2010 at 10:15 PM, Anton Voro=
ntsov <span dir=3D"ltr">&lt;<a href=3D"mailto:cbouatmailru@gmail.com" targe=
t=3D"_blank">cbouatmailru@gmail.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px so=
lid rgb(204, 204, 204); padding-left: 1ex;">



Hi,<br>
<div><br>
On Wed, Aug 11, 2010 at 06:57:16PM +0530, Ravi Gupta wrote:<br>
&gt; I am new to device driver development. I am trying to access the GPIO =
of<br>
&gt; MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28.9 a=
nd<br>
&gt; enable support for mpc8xxx_gpio.c. On boot up, it successfully detect =
two<br>
&gt; gpio controllers. Now my question is how I am going to use it to commu=
nicate<br>
&gt; with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c fil=
e to<br>
&gt; do whatever I want to do with gpios or I can use the standard gpio API=
<br>
&gt; provided in kernel ( gpio_request()/gpio_free() ). I also tries the st=
andard<br>
&gt; kernel API, but it fails. Here is my code :<br>
<br>
</div>No, you don&#39;t have to modify anything, and yes, you can<br>
use standard kernel GPIO API.<br>
<div><br>
&gt; #include &lt;linux/module.h&gt;<br>
&gt; #include &lt;linux/errno.h&gt; =A0/* error codes */<br>
&gt; #include &lt;linux/gpio.h&gt;<br>
&gt;<br>
&gt; static __init int sample_module_init(void)<br>
&gt; {<br>
&gt; =A0 int ret;<br>
&gt;<br>
&gt; =A0 int i;<br>
&gt; =A0 for (i=3D1; i&lt;32; i++) {<br>
&gt; =A0 =A0 ret =3D gpio_request(i, &quot;Sample Driver&quot;);<br>
<br>
</div>Before issing gpio_request() you must get GPIO number from the<br>
of_get_gpio() or of_get_gpio_flags() calls (the _flags variant<br>
will also retreive flags such as &#39;active-low&#39;).<br>
<br>
The calls assume that you have gpio =3D &lt;&gt; specifier in the<br>
device tree, see arch/powerpc/boot/dts/mpc8377_rdb.dts&#39;s<br>
&quot;leds&quot; node as an example.<br>
<br>
As you want GPIO LEDs, you can use drivers/leds/leds-gpio.c<br>
(see of_gpio_leds_probe() call, it gets gpio numbers via<br>
of_get_gpio_flags() and then requests them via gpio_request()).<br>
<br>
Also see<br>
<br>
Documentation/powerpc/dts-bindings/gpio/gpio.txt<br>
Documentation/powerpc/dts-bindings/gpio/led.txt<br>
<div><br>
&gt; =A0 =A0 if (ret) {<br>
&gt; =A0 =A0 =A0 printk(KERN_WARNING &quot;sample_driver: unable to request=
 GPIO_PG%d\n&quot;,<br>
&gt; i);<br>
&gt; =A0 =A0 =A0 //return ret;<br>
&gt; =A0 =A0 }<br>
&gt; =A0 }<br>
&gt;<br>
&gt; =A0 return 0;<br>
&gt; }<br>
<br>
<br>
</div><div>On Wed, Aug 11, 2010 at 07:49:40PM +0530, Ravi Gupta wrote:<br>
</div><div>&gt; Also, when I try to export a gpio in sysfs<br>
&gt;<br>
&gt; echo 9 &gt; /sys/class/gpio/export<br>
<br>
</div>The gpio numbers are global, i.e. GPIO controller base + GPIO<br>
number within the controller.<br>
<br>
[...]<br>
<div>&gt; drwxr-xr-x =A0 =A03 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Ja=
n =A01 00:00 gpiochip192<br>
<br>
</div>So, if you want GPIO9 within gpiochip192, you should issue<br>
&quot;echo 201 &gt; export&quot;.<br>
<br>
Thanks,<br>
<font color=3D"#888888"><br>
--<br>
Anton Vorontsov<br>
email: <a href=3D"mailto:cbouatmailru@gmail.com" target=3D"_blank">cbouatma=
ilru@gmail.com</a><br>
irc://<a href=3D"http://irc.freenode.net/bd2" target=3D"_blank">irc.freenod=
e.net/bd2</a><br>
</font></blockquote></div><br>Hi Anton,<br><br>Thanks for the reply.<br>I h=
ad added the entries for=20
gpio pin 9 for both controllers(I was not sure with controller&#39;s pin is=
=20
connected to LED, but now I know it is pin no. 233 i.e 224+9) in the=20
mpc8377_rdb.dts file. Below is a portion of my dts file, I have attached
 the complete dts file as attachment.<br><br>immr@e0000000 {<br>=A0=A0=A0 #=
address-cells =3D &lt;1&gt;;<br>=A0=A0=A0 #size-cells =3D &lt;1&gt;;<br>=A0=
=A0=A0 device_type =3D &quot;soc&quot;;<br>=A0=A0=A0 compatible =3D &quot;s=
imple-bus&quot;;<br>=A0=A0=A0 ranges =3D &lt;0x0 0xe0000000 0x00100000&gt;;=
<br>
=A0=A0=A0 reg =3D &lt;0xe0000000 0x00000200&gt;;<br>=A0=A0=A0 bus-frequency=
 =3D &lt;0&gt;;<br><br>=A0=A0=A0 wdt@200 {<br>=A0=A0=A0=A0=A0=A0=A0 device_=
type =3D &quot;watchdog&quot;;<br>=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quo=
t;mpc83xx_wdt&quot;;<br>=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt;0x200 0x100&gt;;<=
br>
=A0=A0=A0 };<br><br>=A0=A0=A0 gpio1: gpio-controller@c00 {<br>=A0=A0=A0=A0=
=A0=A0=A0 #gpio-cells =3D &lt;2&gt;;<br>=A0=A0=A0=A0=A0=A0=A0 compatible =
=3D &quot;fsl,mpc8377-gpio&quot;, &quot;fsl,mpc8349-gpio&quot;;<br>=A0=A0=
=A0=A0=A0=A0=A0 reg =3D &lt;0xc00 0x100&gt;;<br>=A0=A0=A0=A0=A0=A0=A0 inter=
rupts =3D &lt;74 0x8&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>=A0=A0=A0=
=A0=A0=A0=A0 gpio-controller;=A0 <br>=A0=A0=A0 };<br><br>=A0=A0=A0 gpio2: g=
pio-controller@d00 {<br>=A0=A0=A0=A0=A0=A0=A0 #gpio-cells =3D &lt;2&gt;;<br=
>=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quot;fsl,mpc8377-gpio&quot;, &quot;f=
sl,mpc8349-gpio&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt;0xd00 0x100&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=
 interrupts =3D &lt;75 0x8&gt;;<br>=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =
=3D &lt;&amp;ipic&gt;;<br>=A0=A0=A0=A0=A0=A0=A0 gpio-controller;<br>=A0=A0=
=A0 };<br><br>=A0=A0=A0<b> led@0 {<br>
=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quot;gpio-leds&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 label =3D &quot;hdd&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 gpios =3D &lt;&amp;gpio1 9 0&gt;;<br>
=A0=A0=A0 };<br>
  <br>
=A0=A0=A0 led@1 {<br>
=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quot;gpio-leds&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 label =3D &quot;rom&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 gpios =3D &lt;&amp;gpio2 9 0&gt;;<br>
=A0=A0=A0 };</b><br>=A0=A0=A0 .<br>=A0=A0=A0 .<br>=A0=A0=A0 .<br>=A0=A0=A0 =
.<br>};<br><br><br>Also I=20
have enabled drivers/leds/leds-gpio.c in my kernel. To test whether the=20
leds entires in dts file get attached to leds-gpio driver, I added=20
printks in the probe function of the driver.<br><br>static int gpio_led_pro=
be(struct platform_device *pdev)<br>{<br>=A0 struct gpio_led_platform_data =
*pdata =3D pdev-&gt;dev.platform_data;<br>=A0 struct gpio_led *cur_led;<br>=
=A0 struct gpio_led_data *leds_data, *led_dat;<br>
=A0 int i, ret =3D 0;<br><br>=A0 <b>printk(KERN_INFO &quot;led: inside gpio=
_led_probe.\n&quot;);</b><br><br>=A0 ....<br>}<br><br>But
 I couldn&#39;t see &quot;led: inside gpio_led_probe.&quot; message in dmes=
g. I=20
checked sysfs and I can see entries of leds. Here is contents of sysfs=20
on my machine.<br><br># ls /sys/devices/ -la<br>drwxr-xr-x=A0=A0=A0 7 root=
=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 01:58 .<br>dr=
wxr-xr-x=A0=A0 12 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =
Jan=A0 1 00:00 ..<br>drwxr-xr-x=A0=A0 22 root=A0=A0=A0=A0 root=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 01:58 <b>e0000000.immr</b><br>
drwxr-xr-x=A0=A0=A0 5 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 Jan=A0 1 01:58 e0005000.localbus<br>drwxr-xr-x=A0=A0=A0 4 root=A0=A0=
=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 01:58 pci0000:00<br=
>drwxr-xr-x=A0=A0=A0 9 root=A0=A0=A0=A0 root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 Jan=A0 1 01:58 platform<br>drwxr-xr-x=A0=A0=A0 8 root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 Jan=A0 1 01:58 system<br>
<br><br># ls /sys/devices/e0000000.immr/<br>bus=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0 e0004600.serial=A0=A0=A0=
=A0=A0=A0 <b>led1.0</b><br>devspec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0 e0007000.spi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <b>led2.1</b><b=
r>e0000200.wdt=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e00082a8.dma=A0=A0=A0=A0=A0=
=A0=A0=A0 modalias<br>
e0000700.interrupt-=A0=A0=A0 e0018000.sata=A0=A0=A0=A0=A0=A0=A0=A0 name<br>=
e0000b00.power=A0=A0=A0=A0=A0=A0=A0 e0019000.sata=A0=A0=A0=A0=A0=A0=A0=A0 p=
ower<br>e0000c00.gpio-contr=A0 e0023000.usb=A0=A0=A0=A0=A0=A0=A0=A0=A0 slee=
p-nexus.2<br>e0000d00.gpio-contr=A0 e0024000.ethernet=A0=A0=A0 subsystem<br=
>
e0003100.i2c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e0025000.ethernet=A0=A0=A0 ue=
vent<br>e0004500.serial=A0=A0=A0=A0 =A0=A0 e0030000.crypto<br><br>Is there =
something that I am doing wrong? Please suggest.<br><br>Thanks in Advance<b=
r>
Ravi Gupta<br>

--001636457dded41372048db18830--

--001636457dded4137b048db18832
Content-Type: application/octet-stream; name="mpc8377_rdb.dts"
Content-Disposition: attachment; filename="mpc8377_rdb.dts"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcsv6txo0

LyoKICogTVBDODM3N0UgUkRCIERldmljZSBUcmVlIFNvdXJjZQogKgogKiBDb3B5cmlnaHQgMjAw
NywgMjAwOCBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBJbmMuCiAqCiAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29yIG1vZGlmeSBp
dAogKiB1bmRlciAgdGhlIHRlcm1zIG9mICB0aGUgR05VIEdlbmVyYWwgIFB1YmxpYyBMaWNlbnNl
IGFzIHB1Ymxpc2hlZCBieSB0aGUKICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyAgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgIExpY2Vuc2UsIG9yIChhdCB5b3VyCiAqIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCiAqLwoKL2R0cy12MS87CgovIHsKCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgz
NzdyZGIiOwoJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cgkjc2l6ZS1jZWxscyA9IDwxPjsKCglhbGlh
c2VzIHsKCQlldGhlcm5ldDAgPSAmZW5ldDA7CgkJZXRoZXJuZXQxID0gJmVuZXQxOwoJCXNlcmlh
bDAgPSAmc2VyaWFsMDsKCQlzZXJpYWwxID0gJnNlcmlhbDE7CgkJcGNpMCA9ICZwY2kwOwoJCXBj
aTEgPSAmcGNpMTsKCQlwY2kyID0gJnBjaTI7Cgl9OwoKCWNwdXMgewoJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+OwoJCSNzaXplLWNlbGxzID0gPDA+OwoKCQlQb3dlclBDLDgzNzdAMCB7CgkJCWRldmlj
ZV90eXBlID0gImNwdSI7CgkJCXJlZyA9IDwweDA+OwoJCQlkLWNhY2hlLWxpbmUtc2l6ZSA9IDwz
Mj47CgkJCWktY2FjaGUtbGluZS1zaXplID0gPDMyPjsKCQkJZC1jYWNoZS1zaXplID0gPDMyNzY4
PjsKCQkJaS1jYWNoZS1zaXplID0gPDMyNzY4PjsKCQkJdGltZWJhc2UtZnJlcXVlbmN5ID0gPDA+
OwoJCQlidXMtZnJlcXVlbmN5ID0gPDA+OwoJCQljbG9jay1mcmVxdWVuY3kgPSA8MD47CgkJfTsK
CX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJCXJlZyA9IDwweDAwMDAw
MDAwIDB4MTAwMDAwMDA+OwkvLyAyNTZNQiBhdCAwCgl9OwoKCWxvY2FsYnVzQGUwMDA1MDAwIHsK
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsKCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQljb21wYXRpYmxl
ID0gImZzbCxtcGM4Mzc3LWVsYmMiLCAiZnNsLGVsYmMiLCAic2ltcGxlLWJ1cyI7CgkJcmVnID0g
PDB4ZTAwMDUwMDAgMHgxMDAwPjsKCQlpbnRlcnJ1cHRzID0gPDc3IDB4OD47CgkJaW50ZXJydXB0
LXBhcmVudCA9IDwmaXBpYz47CgoJCS8vIENTMCBhbmQgQ1MxIGFyZSBzd2FwcGVkIHdoZW4KCQkv
LyBib290aW5nIGZyb20gbmFuZCwgYnV0IHRoZQoJCS8vIGFkZHJlc3NlcyBhcmUgdGhlIHNhbWUu
CgkJcmFuZ2VzID0gPDB4MCAweDAgMHhmZTAwMDAwMCAweDAwODAwMDAwCgkJICAgICAgICAgIDB4
MSAweDAgMHhlMDYwMDAwMCAweDAwMDA4MDAwCgkJICAgICAgICAgIDB4MiAweDAgMHhmMDAwMDAw
MCAweDAwMDIwMDAwCgkJICAgICAgICAgIDB4MyAweDAgMHhmYTAwMDAwMCAweDAwMDA4MDAwPjsK
CgkJZmxhc2hAMCwwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0g
PDE+OwoJCQljb21wYXRpYmxlID0gImNmaS1mbGFzaCI7CgkJCXJlZyA9IDwweDAgMHgwIDB4ODAw
MDAwPjsKCQkJYmFuay13aWR0aCA9IDwyPjsKCQkJZGV2aWNlLXdpZHRoID0gPDE+OwoJCX07CgoJ
CW5hbmRAMSwwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0gPDE+
OwoJCQljb21wYXRpYmxlID0gImZzbCxtcGM4Mzc3LWZjbS1uYW5kIiwKCQkJICAgICAgICAgICAg
ICJmc2wsZWxiYy1mY20tbmFuZCI7CgkJCXJlZyA9IDwweDEgMHgwIDB4ODAwMD47CgoJCQl1LWJv
b3RAMCB7CgkJCQlyZWcgPSA8MHgwIDB4MTAwMDAwPjsKCQkJCXJlYWQtb25seTsKCQkJfTsKCgkJ
CWtlcm5lbEAxMDAwMDAgewoJCQkJcmVnID0gPDB4MTAwMDAwIDB4MzAwMDAwPjsKCQkJfTsKCQkJ
ZnNANDAwMDAwIHsKCQkJCXJlZyA9IDwweDQwMDAwMCAweDFjMDAwMDA+OwoJCQl9OwoJCX07Cgl9
OwoKCWltbXJAZTAwMDAwMDAgewoJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCSNzaXplLWNlbGxz
ID0gPDE+OwoJCWRldmljZV90eXBlID0gInNvYyI7CgkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVz
IjsKCQlyYW5nZXMgPSA8MHgwIDB4ZTAwMDAwMDAgMHgwMDEwMDAwMD47CgkJcmVnID0gPDB4ZTAw
MDAwMDAgMHgwMDAwMDIwMD47CgkJYnVzLWZyZXF1ZW5jeSA9IDwwPjsKCgkJd2R0QDIwMCB7CgkJ
CWRldmljZV90eXBlID0gIndhdGNoZG9nIjsKCQkJY29tcGF0aWJsZSA9ICJtcGM4M3h4X3dkdCI7
CgkJCXJlZyA9IDwweDIwMCAweDEwMD47CgkJfTsKCgkJZ3BpbzE6IGdwaW8tY29udHJvbGxlckBj
MDAgewoJCQkjZ3Bpby1jZWxscyA9IDwyPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODM3Ny1n
cGlvIiwgImZzbCxtcGM4MzQ5LWdwaW8iOwoJCQlyZWcgPSA8MHhjMDAgMHgxMDA+OwoJCQlpbnRl
cnJ1cHRzID0gPDc0IDB4OD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8JmlwaWM+OwoJCQlncGlv
LWNvbnRyb2xsZXI7CgkJCQoJCQoJCX07CgoJCWdwaW8yOiBncGlvLWNvbnRyb2xsZXJAZDAwIHsK
CQkJI2dwaW8tY2VsbHMgPSA8Mj47CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctZ3BpbyIs
ICJmc2wsbXBjODM0OS1ncGlvIjsKCQkJcmVnID0gPDB4ZDAwIDB4MTAwPjsKCQkJaW50ZXJydXB0
cyA9IDw3NSAweDg+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQkJZ3Bpby1jb250
cm9sbGVyOwoJCX07CgoJCWxlZEAwIHsKCQkJY29tcGF0aWJsZSA9ICJncGlvLWxlZHMiOwoJCQls
YWJlbCA9ICJoZGQiOwoJCQlncGlvcyA9IDwmZ3BpbzEgOSAwPjsgCgkJfTsKCgkJbGVkQDEgewoJ
CQljb21wYXRpYmxlID0gImdwaW8tbGVkcyI7CgkJCWxhYmVsID0gInJvbSI7CgkJCWdwaW9zID0g
PCZncGlvMiA5IDA+OyAKCQl9OwoKCQlzbGVlcC1uZXh1cyB7CgkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsK
CQkJc2xlZXAgPSA8JnBtYyAweDBjMDAwMDAwPjsKCQkJcmFuZ2VzOwoKCQkJaTJjQDMwMDAgewoJ
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJCWNlbGwt
aW5kZXggPSA8MD47CgkJCQljb21wYXRpYmxlID0gImZzbC1pMmMiOwoJCQkJcmVnID0gPDB4MzAw
MCAweDEwMD47CgkJCQlpbnRlcnJ1cHRzID0gPDE0IDB4OD47CgkJCQlpbnRlcnJ1cHQtcGFyZW50
ID0gPCZpcGljPjsKCQkJCWRmc3JyOwoKCQkJCWR0dEA0OCB7CgkJCQkJY29tcGF0aWJsZSA9ICJu
YXRpb25hbCxsbTc1IjsKCQkJCQlyZWcgPSA8MHg0OD47CgkJCQl9OwoKCQkJCWF0MjRANTAgewoJ
CQkJCWNvbXBhdGlibGUgPSAiYXQyNCwyNGMyNTYiOwoJCQkJCXJlZyA9IDwweDUwPjsKCQkJCX07
CgoJCQkJcnRjQDY4IHsKCQkJCQljb21wYXRpYmxlID0gImRhbGxhcyxkczEzMzkiOwoJCQkJCXJl
ZyA9IDwweDY4PjsKCQkJCX07CgoJCQkJbWN1X3BpbzogbWN1QGEgewoJCQkJCSNncGlvLWNlbGxz
ID0gPDI+OwoJCQkJCWNvbXBhdGlibGUgPSAiZnNsLG1jOXMwOHFnOC1tcGM4Mzc3ZXJkYiIsCgkJ
CQkJCSAgICAgImZzbCxtY3UtbXBjODM0OWVtaXR4IjsKCQkJCQlyZWcgPSA8MHgwYT47CgkJCQkJ
Z3Bpby1jb250cm9sbGVyOwoJCQkJfTsKCQkJfTsKCgkJCXNkaGNpQDJlMDAwIHsKCQkJCWNvbXBh
dGlibGUgPSAiZnNsLG1wYzgzNzctZXNkaGMiLCAiZnNsLGVzZGhjIjsKCQkJCXJlZyA9IDwweDJl
MDAwIDB4MTAwMD47CgkJCQlpbnRlcnJ1cHRzID0gPDQyIDB4OD47CgkJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZpcGljPjsKCQkJCXNkaGNpLHdwLWludmVydGVkOwoJCQkJLyogRmlsbGVkIGluIGJ5
IFUtQm9vdCAqLwoJCQkJY2xvY2stZnJlcXVlbmN5ID0gPDExMTExMTExMT47CgkJCX07CgkJfTsK
CgkJaTJjQDMxMDAgewoJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8
MD47CgkJCWNlbGwtaW5kZXggPSA8MT47CgkJCWNvbXBhdGlibGUgPSAiZnNsLWkyYyI7CgkJCXJl
ZyA9IDwweDMxMDAgMHgxMDA+OwoJCQlpbnRlcnJ1cHRzID0gPDE1IDB4OD47CgkJCWludGVycnVw
dC1wYXJlbnQgPSA8JmlwaWM+OwoJCQlkZnNycjsKCQl9OwoKCQlzcGlANzAwMCB7CgkJCWNlbGwt
aW5kZXggPSA8MD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLHNwaSI7CgkJCXJlZyA9IDwweDcwMDAg
MHgxMDAwPjsKCQkJaW50ZXJydXB0cyA9IDwxNiAweDg+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0g
PCZpcGljPjsKCQkJbW9kZSA9ICJjcHUiOwoJCX07CgoJCWRtYUA4MmE4IHsKCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQljb21wYXRpYmxlID0gImZzbCxt
cGM4Mzc3LWRtYSIsICJmc2wsZWxvLWRtYSI7CgkJCXJlZyA9IDwweDgyYTggND47CgkJCXJhbmdl
cyA9IDwwIDB4ODEwMCAweDFhOD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8JmlwaWM+OwoJCQlp
bnRlcnJ1cHRzID0gPDcxIDg+OwoJCQljZWxsLWluZGV4ID0gPDA+OwoJCQlkbWEtY2hhbm5lbEAw
IHsKCQkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctZG1hLWNoYW5uZWwiLCAiZnNsLGVsby1k
bWEtY2hhbm5lbCI7CgkJCQlyZWcgPSA8MCAweDgwPjsKCQkJCWNlbGwtaW5kZXggPSA8MD47CgkJ
CQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQkJCWludGVycnVwdHMgPSA8NzEgOD47CgkJ
CX07CgkJCWRtYS1jaGFubmVsQDgwIHsKCQkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctZG1h
LWNoYW5uZWwiLCAiZnNsLGVsby1kbWEtY2hhbm5lbCI7CgkJCQlyZWcgPSA8MHg4MCAweDgwPjsK
CQkJCWNlbGwtaW5kZXggPSA8MT47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQkJ
CWludGVycnVwdHMgPSA8NzEgOD47CgkJCX07CgkJCWRtYS1jaGFubmVsQDEwMCB7CgkJCQljb21w
YXRpYmxlID0gImZzbCxtcGM4Mzc3LWRtYS1jaGFubmVsIiwgImZzbCxlbG8tZG1hLWNoYW5uZWwi
OwoJCQkJcmVnID0gPDB4MTAwIDB4ODA+OwoJCQkJY2VsbC1pbmRleCA9IDwyPjsKCQkJCWludGVy
cnVwdC1wYXJlbnQgPSA8JmlwaWM+OwoJCQkJaW50ZXJydXB0cyA9IDw3MSA4PjsKCQkJfTsKCQkJ
ZG1hLWNoYW5uZWxAMTgwIHsKCQkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctZG1hLWNoYW5u
ZWwiLCAiZnNsLGVsby1kbWEtY2hhbm5lbCI7CgkJCQlyZWcgPSA8MHgxODAgMHgyOD47CgkJCQlj
ZWxsLWluZGV4ID0gPDM+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmaXBpYz47CgkJCQlpbnRl
cnJ1cHRzID0gPDcxIDg+OwoJCQl9OwoJCX07CgoJCXVzYkAyMzAwMCB7CgkJCWNvbXBhdGlibGUg
PSAiZnNsLXVzYjItZHIiOwoJCQlyZWcgPSA8MHgyMzAwMCAweDEwMDA+OwoJCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8
JmlwaWM+OwoJCQlpbnRlcnJ1cHRzID0gPDM4IDB4OD47CgkJCXBoeV90eXBlID0gInVscGkiOwoJ
CQlzbGVlcCA9IDwmcG1jIDB4MDBjMDAwMDA+OwoJCX07CgoJCWVuZXQwOiBldGhlcm5ldEAyNDAw
MCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQkJY2Vs
bC1pbmRleCA9IDwwPjsKCQkJZGV2aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCW1vZGVsID0gImVU
U0VDIjsKCQkJY29tcGF0aWJsZSA9ICJnaWFuZmFyIjsKCQkJcmVnID0gPDB4MjQwMDAgMHgxMDAw
PjsKCQkJcmFuZ2VzID0gPDB4MCAweDI0MDAwIDB4MTAwMD47CgkJCWxvY2FsLW1hYy1hZGRyZXNz
ID0gWyAwMCAwMCAwMCAwMCAwMCAwMCBdOwoJCQlpbnRlcnJ1cHRzID0gPDMyIDB4OCAzMyAweDgg
MzQgMHg4PjsKCQkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJtaWkiOwoJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZpcGljPjsKCQkJdGJpLWhhbmRsZSA9IDwmdGJpMD47CgkJCXBoeS1oYW5kbGUgPSA8
JnBoeTI+OwoJCQlzbGVlcCA9IDwmcG1jIDB4YzAwMDAwMDA+OwoJCQlmc2wsbWFnaWMtcGFja2V0
OwoKCQkJbWRpb0A1MjAgewoJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCQkjc2l6ZS1jZWxs
cyA9IDwwPjsKCQkJCWNvbXBhdGlibGUgPSAiZnNsLGdpYW5mYXItbWRpbyI7CgkJCQlyZWcgPSA8
MHg1MjAgMHgyMD47CgoJCQkJcGh5MjogZXRoZXJuZXQtcGh5QDIgewoJCQkJCWludGVycnVwdC1w
YXJlbnQgPSA8JmlwaWM+OwoJCQkJCWludGVycnVwdHMgPSA8MTcgMHg4PjsKCQkJCQlyZWcgPSA8
MHgyPjsKCQkJCQlkZXZpY2VfdHlwZSA9ICJldGhlcm5ldC1waHkiOwoJCQkJfTsKCgkJCQl0Ymkw
OiB0YmktcGh5QDExIHsKCQkJCQlyZWcgPSA8MHgxMT47CgkJCQkJZGV2aWNlX3R5cGUgPSAidGJp
LXBoeSI7CgkJCQl9OwoJCQl9OwoJCX07CgoJCWVuZXQxOiBldGhlcm5ldEAyNTAwMCB7CgkJCSNh
ZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQkJY2VsbC1pbmRleCA9
IDwxPjsKCQkJZGV2aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCW1vZGVsID0gImVUU0VDIjsKCQkJ
Y29tcGF0aWJsZSA9ICJnaWFuZmFyIjsKCQkJcmVnID0gPDB4MjUwMDAgMHgxMDAwPjsKCQkJcmFu
Z2VzID0gPDB4MCAweDI1MDAwIDB4MTAwMD47CgkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWyAwMCAw
MCAwMCAwMCAwMCAwMCBdOwoJCQlpbnRlcnJ1cHRzID0gPDM1IDB4OCAzNiAweDggMzcgMHg4PjsK
CQkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJtaWkiOwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZp
cGljPjsKCQkJZml4ZWQtbGluayA9IDwxIDEgMTAwMCAwIDA+OwoJCQl0YmktaGFuZGxlID0gPCZ0
YmkxPjsKCQkJc2xlZXAgPSA8JnBtYyAweDMwMDAwMDAwPjsKCQkJZnNsLG1hZ2ljLXBhY2tldDsK
CgkJCW1kaW9ANTIwIHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2VsbHMg
PSA8MD47CgkJCQljb21wYXRpYmxlID0gImZzbCxnaWFuZmFyLXRiaSI7CgkJCQlyZWcgPSA8MHg1
MjAgMHgyMD47CgoJCQkJdGJpMTogdGJpLXBoeUAxMSB7CgkJCQkJcmVnID0gPDB4MTE+OwoJCQkJ
CWRldmljZV90eXBlID0gInRiaS1waHkiOwoJCQkJfTsKCQkJfTsKCQl9OwoKCQlzZXJpYWwwOiBz
ZXJpYWxANDUwMCB7CgkJCWNlbGwtaW5kZXggPSA8MD47CgkJCWRldmljZV90eXBlID0gInNlcmlh
bCI7CgkJCWNvbXBhdGlibGUgPSAibnMxNjU1MCI7CgkJCXJlZyA9IDwweDQ1MDAgMHgxMDA+OwoJ
CQljbG9jay1mcmVxdWVuY3kgPSA8MD47CgkJCWludGVycnVwdHMgPSA8OSAweDg+OwoJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQl9OwoKCQlzZXJpYWwxOiBzZXJpYWxANDYwMCB7CgkJ
CWNlbGwtaW5kZXggPSA8MT47CgkJCWRldmljZV90eXBlID0gInNlcmlhbCI7CgkJCWNvbXBhdGli
bGUgPSAibnMxNjU1MCI7CgkJCXJlZyA9IDwweDQ2MDAgMHgxMDA+OwoJCQljbG9jay1mcmVxdWVu
Y3kgPSA8MD47CgkJCWludGVycnVwdHMgPSA8MTAgMHg4PjsKCQkJaW50ZXJydXB0LXBhcmVudCA9
IDwmaXBpYz47CgkJfTsKCgkJY3J5cHRvQDMwMDAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsc2Vj
My4wIiwgImZzbCxzZWMyLjQiLCAiZnNsLHNlYzIuMiIsCgkJCQkgICAgICJmc2wsc2VjMi4xIiwg
ImZzbCxzZWMyLjAiOwoJCQlyZWcgPSA8MHgzMDAwMCAweDEwMDAwPjsKCQkJaW50ZXJydXB0cyA9
IDwxMSAweDg+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQkJZnNsLG51bS1jaGFu
bmVscyA9IDw0PjsKCQkJZnNsLGNoYW5uZWwtZmlmby1sZW4gPSA8MjQ+OwoJCQlmc2wsZXhlYy11
bml0cy1tYXNrID0gPDB4OWZlPjsKCQkJZnNsLGRlc2NyaXB0b3ItdHlwZXMtbWFzayA9IDwweDNh
YjBlYmY+OwoJCQlzbGVlcCA9IDwmcG1jIDB4MDMwMDAwMDA+OwoJCX07CgoJCXNhdGFAMTgwMDAg
ewoJCQljb21wYXRpYmxlID0gImZzbCxtcGM4Mzc3LXNhdGEiLCAiZnNsLHBxLXNhdGEiOwoJCQly
ZWcgPSA8MHgxODAwMCAweDEwMDA+OwoJCQlpbnRlcnJ1cHRzID0gPDQ0IDB4OD47CgkJCWludGVy
cnVwdC1wYXJlbnQgPSA8JmlwaWM+OwoJCQlzbGVlcCA9IDwmcG1jIDB4MDAwMDAwYzA+OwoJCX07
CgoJCXNhdGFAMTkwMDAgewoJCQljb21wYXRpYmxlID0gImZzbCxtcGM4Mzc3LXNhdGEiLCAiZnNs
LHBxLXNhdGEiOwoJCQlyZWcgPSA8MHgxOTAwMCAweDEwMDA+OwoJCQlpbnRlcnJ1cHRzID0gPDQ1
IDB4OD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8JmlwaWM+OwoJCQlzbGVlcCA9IDwmcG1jIDB4
MDAwMDAwMzA+OwoJCX07CgoJCS8qIElQSUMKCQkgKiBpbnRlcnJ1cHRzIGNlbGwgPSA8aW50ciAj
LCBzZW5zZT4KCQkgKiBzZW5zZSB2YWx1ZXMgbWF0Y2ggbGludXggSU9SRVNPVVJDRV9JUlFfKiBk
ZWZpbmVzOgoJCSAqIHNlbnNlID09IDg6IExldmVsLCBsb3cgYXNzZXJ0aW9uCgkJICogc2Vuc2Ug
PT0gMjogRWRnZSwgaGlnaC10by1sb3cgY2hhbmdlCgkJICovCgkJaXBpYzogaW50ZXJydXB0LWNv
bnRyb2xsZXJANzAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsaXBpYyI7CgkJCWludGVycnVwdC1j
b250cm9sbGVyOwoJCQkjYWRkcmVzcy1jZWxscyA9IDwwPjsKCQkJI2ludGVycnVwdC1jZWxscyA9
IDwyPjsKCQkJcmVnID0gPDB4NzAwIDB4MTAwPjsKCQl9OwoKCQlwbWM6IHBvd2VyQGIwMCB7CgkJ
CWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctcG1jIiwgImZzbCxtcGM4MzQ5LXBtYyI7CgkJCXJl
ZyA9IDwweGIwMCAweDEwMCAweGEwMCAweDEwMD47CgkJCWludGVycnVwdHMgPSA8ODAgMHg4PjsK
CQkJaW50ZXJydXB0LXBhcmVudCA9IDwmaXBpYz47CgkJfTsKCX07CgoJcGNpMDogcGNpQGUwMDA4
NTAwIHsKCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3PjsKCQlpbnRlcnJ1cHQt
bWFwID0gPAoJCQkJLyogSVJRNSA9IDIxID0gMHgxNSwgSVJRNiA9IDB4MTYsIElSUTcgPSAyMyA9
IDB4MTcgKi8KCgkJCQkvKiBJRFNFTCBBRDE0IElSUTYgaW50YSAqLwoJCQkJIDB4NzAwMCAweDAg
MHgwIDB4MSAmaXBpYyAyMiAweDgKCgkJCQkvKiBJRFNFTCBBRDE1IElSUTUgaW50YSwgSVJRNiBp
bnRiLCBJUlE3IGludGQgKi8KCQkJCSAweDc4MDAgMHgwIDB4MCAweDEgJmlwaWMgMjEgMHg4CgkJ
CQkgMHg3ODAwIDB4MCAweDAgMHgyICZpcGljIDIyIDB4OAoJCQkJIDB4NzgwMCAweDAgMHgwIDB4
NCAmaXBpYyAyMyAweDgKCgkJCQkvKiBJRFNFTCBBRDI4IElSUTcgaW50YSwgSVJRNSBpbnRiIElS
UTYgaW50YyovCgkJCQkgMHhFMDAwIDB4MCAweDAgMHgxICZpcGljIDIzIDB4OAoJCQkJIDB4RTAw
MCAweDAgMHgwIDB4MiAmaXBpYyAyMSAweDgKCQkJCSAweEUwMDAgMHgwIDB4MCAweDMgJmlwaWMg
MjIgMHg4PjsKCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpcGljPjsKCQlpbnRlcnJ1cHRzID0gPDY2
IDB4OD47CgkJYnVzLXJhbmdlID0gPDAgMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMHgwIDB4
OTAwMDAwMDAgMHg5MDAwMDAwMCAweDAgMHgxMDAwMDAwMAoJCSAgICAgICAgICAweDQyMDAwMDAw
IDB4MCAweDgwMDAwMDAwIDB4ODAwMDAwMDAgMHgwIDB4MTAwMDAwMDAKCQkgICAgICAgICAgMHgw
MTAwMDAwMCAweDAgMHgwMDAwMDAwMCAweGUwMzAwMDAwIDB4MCAweDAwMTAwMDAwPjsKCQlzbGVl
cCA9IDwmcG1jIDB4MDAwMTAwMDA+OwoJCWNsb2NrLWZyZXF1ZW5jeSA9IDw2NjY2NjY2Nj47CgkJ
I2ludGVycnVwdC1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwyPjsKCQkjYWRkcmVzcy1j
ZWxscyA9IDwzPjsKCQlyZWcgPSA8MHhlMDAwODUwMCAweDEwMAkJLyogaW50ZXJuYWwgcmVnaXN0
ZXJzICovCgkJICAgICAgIDB4ZTAwMDgzMDAgMHg4PjsJCS8qIGNvbmZpZyBzcGFjZSBhY2Nlc3Mg
cmVnaXN0ZXJzICovCgkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODM0OS1wY2kiOwoJCWRldmljZV90
eXBlID0gInBjaSI7Cgl9OwoKCXBjaTE6IHBjaWVAZTAwMDkwMDAgewoJCSNhZGRyZXNzLWNlbGxz
ID0gPDM+OwoJCSNzaXplLWNlbGxzID0gPDI+OwoJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJ
ZGV2aWNlX3R5cGUgPSAicGNpIjsKCQljb21wYXRpYmxlID0gImZzbCxtcGM4Mzc3LXBjaWUiLCAi
ZnNsLG1wYzgzMTQtcGNpZSI7CgkJcmVnID0gPDB4ZTAwMDkwMDAgMHgwMDAwMTAwMD47CgkJcmFu
Z2VzID0gPDB4MDIwMDAwMDAgMCAweGE4MDAwMDAwIDB4YTgwMDAwMDAgMCAweDEwMDAwMDAwCgkJ
ICAgICAgICAgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwIDB4YjgwMDAwMDAgMCAweDAwODAwMDAw
PjsKCQlidXMtcmFuZ2UgPSA8MCAyNTU+OwoJCWludGVycnVwdC1tYXAtbWFzayA9IDwweGY4MDAg
MCAwIDc+OwoJCWludGVycnVwdC1tYXAgPSA8MCAwIDAgMSAmaXBpYyAxIDgKCQkJCSAwIDAgMCAy
ICZpcGljIDEgOAoJCQkJIDAgMCAwIDMgJmlwaWMgMSA4CgkJCQkgMCAwIDAgNCAmaXBpYyAxIDg+
OwoJCXNsZWVwID0gPCZwbWMgMHgwMDMwMDAwMD47CgkJY2xvY2stZnJlcXVlbmN5ID0gPDA+OwoK
CQlwY2llQDAgewoJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsKCQkJI3NpemUtY2VsbHMgPSA8Mj47
CgkJCWRldmljZV90eXBlID0gInBjaSI7CgkJCXJlZyA9IDwwIDAgMCAwIDA+OwoJCQlyYW5nZXMg
PSA8MHgwMjAwMDAwMCAwIDB4YTgwMDAwMDAKCQkJCSAgMHgwMjAwMDAwMCAwIDB4YTgwMDAwMDAK
CQkJCSAgMCAweDEwMDAwMDAwCgkJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwCgkJCQkgIDB4
MDEwMDAwMDAgMCAweDAwMDAwMDAwCgkJCQkgIDAgMHgwMDgwMDAwMD47CgkJfTsKCX07CgoJcGNp
MjogcGNpZUBlMDAwYTAwMCB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJI3NpemUtY2VsbHMg
PSA8Mj47CgkJI2ludGVycnVwdC1jZWxscyA9IDwxPjsKCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJ
CWNvbXBhdGlibGUgPSAiZnNsLG1wYzgzNzctcGNpZSIsICJmc2wsbXBjODMxNC1wY2llIjsKCQly
ZWcgPSA8MHhlMDAwYTAwMCAweDAwMDAxMDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAwIDB4
YzgwMDAwMDAgMHhjODAwMDAwMCAwIDB4MTAwMDAwMDAKCQkJICAweDAxMDAwMDAwIDAgMHgwMDAw
MDAwMCAweGQ4MDAwMDAwIDAgMHgwMDgwMDAwMD47CgkJYnVzLXJhbmdlID0gPDAgMjU1PjsKCQlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3PjsKCQlpbnRlcnJ1cHQtbWFwID0gPDAg
MCAwIDEgJmlwaWMgMiA4CgkJCQkgMCAwIDAgMiAmaXBpYyAyIDgKCQkJCSAwIDAgMCAzICZpcGlj
IDIgOAoJCQkJIDAgMCAwIDQgJmlwaWMgMiA4PjsKCQlzbGVlcCA9IDwmcG1jIDB4MDAwYzAwMDA+
OwoJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsKCgkJcGNpZUAwIHsKCQkJI2FkZHJlc3MtY2VsbHMg
PSA8Mz47CgkJCSNzaXplLWNlbGxzID0gPDI+OwoJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJCQly
ZWcgPSA8MCAwIDAgMCAwPjsKCQkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGM4MDAwMDAwCgkJ
CQkgIDB4MDIwMDAwMDAgMCAweGM4MDAwMDAwCgkJCQkgIDAgMHgxMDAwMDAwMAoJCQkJICAweDAx
MDAwMDAwIDAgMHgwMDAwMDAwMAoJCQkJICAweDAxMDAwMDAwIDAgMHgwMDAwMDAwMAoJCQkJICAw
IDB4MDA4MDAwMDA+OwoJCX07Cgl9Owp9Owo=
--001636457dded4137b048db18832--

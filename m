Return-Path: <henk.stegeman@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id 84144DDDB4
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 02:55:09 +1100 (EST)
Received: by fxm4 with SMTP id 4so5776558fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:55:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
References: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
	<fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
	<ae4f76fd0902130240g72b3cdf1l21b8f7ec8ad17e76@mail.gmail.com>
	<fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
Date: Fri, 13 Feb 2009 16:52:49 +0100
Message-ID: <ae4f76fd0902130752s36e8d6fajd7d27ac64521b8ea@mail.gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001636457c722e6cba0462ced4e4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636457c722e6cba0462ced4e4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks Greg,

I'm having success more success with the driver now,

The device gets nicely probed and the probe function gets the properties
from the device tree,

The following patch from Anton Vorontsov:

http://kerneltrap.org/mailarchive/linux-kernel/2008/5/23/1922744

Was very useful  as example for adding the of support to my 'own' spi slave
driver.

(Thanks Anton,)

Henk.

On Fri, Feb 13, 2009 at 4:19 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Fri, Feb 13, 2009 at 3:40 AM, Henk Stegeman <henk.stegeman@gmail.com>
> wrote:
> > I'm busy adding support for slave deviced behind mpc52xx-psc-spi.
> > One complication I have is that my SPI slave device has an interrupt
> output
> > to the CPU.
> > My idea is to add it as a gpios property in the slave device's
> > configuration:
> >
> >         spi@2400 {        // PSC3 (SPI IF to the IO-controller )
> >             device_type = "spi";
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> >             compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
> >             cell-index = <2>;
> >             reg = <0x2400 0x100>;
> >             interrupts = <2 3 0>;
> >             interrupt-parent = <&mpc5200_pic>;
> >             gpios = <&gpt4 0 0>;
> >
> >             io-controller@0 {
> >                 compatible = "microkey,smc4000io";
> >                 spi-max-frequency = <1000000>;
> >                 reg = <0>;
> >                 // gpios: first is IRQ to cpu
> >                 gpios = <&gpt6 0 0>;
> >             };
>
> There is a better way to do this, and driver support for it is
> currently merged into Ben Herrenschmidt's -next tree.
>
> Do this instead:
>         io-controller@0 {
>                compatible = "microkey,smc4000io";
>                spi-max-frequency = <1000000>;
>                reg = <0>;
>                 interrupt-controller = < &gpt6 >;     // Use GPT6 as
> the IRQ controller
>                interrupts = < 1 >;    // And make it rising edge.
>        };
>
> Then add these two properties to the GPT node:
>
>        interrupt-controller;
>        #interrupt-cells = <1>;
>
> Then you can use normal irq_of_parse_and_map() to set up your handler.
>
> > How should I then register my spi slave driver? My smc4000io_probe
> function
> > gets called correctly by of_spi support but when I register as follows:
> >
> > static struct spi_driver smc4000io_driver = {
> >     .driver = {
> >         .name    = "smc4000io",
> >         .bus    = &spi_bus_type,
> >         .owner    = THIS_MODULE,
> >     },
> >     .probe        = smc4000io_probe,
> >     .remove        = __devexit_p(smc4000io_remove),
> > };
> >
> > static int __init smc4000io_init(void)
> > {
> >     return spi_register_driver(&smc4000io_driver);
> > }
> >
> > static void __exit smc4000io_exit(void)
> > {
> >     spi_unregister_driver(&smc4000io_driver);
> > }
> >
> > module_init(smc4000io_init);
>
> Yes, this is right.  The psc_spi driver automatically registers all
> spi children that it finds in the device tree onto the SPI bus.
> Therefore registering an spi_driver() is the right thing to do.
>
> > But when I do:
> >
> > static struct of_platform_driver smc4000_spi_of_driver = {
> >     .name = "smc4000io",
> >     .match_table = smc4000io_of_match,
> >     .probe = smc4000io_of_probe,
> >     .remove        = __devexit_p(smc4000io_of_remove),
> > };
> >
> > static int __init smc4000io_init(void)
> > {
> >     return of_register_platform_driver(&smc4000_spi_of_driver);
> > }
> > module_init(smc4000io_init);
> >
> > Then my smc4000io_of_probe function never gets called.
>
> Correct.  of_platform_driver isn't useful in this case because the
> device cannot exist independently of the SPI bus.  Plus an
> of_platform_device doesn't provide any information about the SPI bus
> itself.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

--001636457c722e6cba0462ced4e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Greg,<br><br>I&#39;m having success more success with the driver now=
,<br><br>The device gets nicely probed and the probe function gets the prop=
erties from the device tree,<br><br>The following patch from Anton Vorontso=
v:<br>
<br><a href=3D"http://kerneltrap.org/mailarchive/linux-kernel/2008/5/23/192=
2744">http://kerneltrap.org/mailarchive/linux-kernel/2008/5/23/1922744</a><=
br><br>Was very useful&nbsp; as example for adding the of support to my &#3=
9;own&#39; spi slave driver.<br>
<br>(Thanks Anton,)<br><br>Henk.<br><br><div class=3D"gmail_quote">On Fri, =
Feb 13, 2009 at 4:19 PM, Grant Likely <span dir=3D"ltr">&lt;<a href=3D"mail=
to:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2=
E3d">On Fri, Feb 13, 2009 at 3:40 AM, Henk Stegeman &lt;<a href=3D"mailto:h=
enk.stegeman@gmail.com">henk.stegeman@gmail.com</a>&gt; wrote:<br>

&gt; I&#39;m busy adding support for slave deviced behind mpc52xx-psc-spi.<=
br>
&gt; One complication I have is that my SPI slave device has an interrupt o=
utput<br>
&gt; to the CPU.<br>
&gt; My idea is to add it as a gpios property in the slave device&#39;s<br>
&gt; configuration:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; spi@2400 { &nbsp; &nbsp; &nbsp; &nbsp;// P=
SC3 (SPI IF to the IO-controller )<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; device_type =3D &quot;spi&qu=
ot;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #address-cells =3D &lt;1&gt;=
;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #size-cells =3D &lt;0&gt;;<b=
r>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible =3D &quot;fsl,mpc=
5200-psc-spi&quot;,&quot;fsl,mpc5200b-psc-spi&quot;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cell-index =3D &lt;2&gt;;<br=
>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D &lt;0x2400 0x100&gt;=
;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; interrupts =3D &lt;2 3 0&gt;=
;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; interrupt-parent =3D &lt;&am=
p;mpc5200_pic&gt;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gpios =3D &lt;&amp;gpt4 0 0&=
gt;;<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; io-controller@0 {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible =3D=
 &quot;microkey,smc4000io&quot;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spi-max-freque=
ncy =3D &lt;1000000&gt;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D &lt;0&=
gt;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // gpios: firs=
t is IRQ to cpu<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gpios =3D &lt;=
&amp;gpt6 0 0&gt;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
<br>
</div>There is a better way to do this, and driver support for it is<br>
currently merged into Ben Herrenschmidt&#39;s -next tree.<br>
<br>
Do this instead:<br>
<div class=3D"Ih2E3d"> &nbsp; &nbsp; &nbsp; &nbsp;io-controller@0 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quo=
t;microkey,smc4000io&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;spi-max-frequency =
=3D &lt;1000000&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0&gt;;<=
br>
</div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupt-con=
troller =3D &lt; &amp;gpt6 &gt;; &nbsp; &nbsp; // Use GPT6 as<br>
the IRQ controller<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;interrupts =3D &lt;=
 1 &gt;; &nbsp; &nbsp;// And make it rising edge.<br>
 &nbsp; &nbsp; &nbsp; &nbsp;};<br>
<br>
Then add these two properties to the GPT node:<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;interrupt-controller;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;#interrupt-cells =3D &lt;1&gt;;<br>
<br>
Then you can use normal irq_of_parse_and_map() to set up your handler.<br>
<div class=3D"Ih2E3d"><br>
&gt; How should I then register my spi slave driver? My smc4000io_probe fun=
ction<br>
&gt; gets called correctly by of_spi support but when I register as follows=
:<br>
&gt;<br>
&gt; static struct spi_driver smc4000io_driver =3D {<br>
&gt; &nbsp; &nbsp; .driver =3D {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; .name &nbsp; &nbsp;=3D &quot;smc4000io&quo=
t;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; .bus &nbsp; &nbsp;=3D &amp;spi_bus_type,<b=
r>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; .owner &nbsp; &nbsp;=3D THIS_MODULE,<br>
&gt; &nbsp; &nbsp; },<br>
&gt; &nbsp; &nbsp; .probe &nbsp; &nbsp; &nbsp; &nbsp;=3D smc4000io_probe,<b=
r>
&gt; &nbsp; &nbsp; .remove &nbsp; &nbsp; &nbsp; &nbsp;=3D __devexit_p(smc40=
00io_remove),<br>
&gt; };<br>
&gt;<br>
&gt; static int __init smc4000io_init(void)<br>
&gt; {<br>
&gt; &nbsp; &nbsp; return spi_register_driver(&amp;smc4000io_driver);<br>
&gt; }<br>
&gt;<br>
&gt; static void __exit smc4000io_exit(void)<br>
&gt; {<br>
&gt; &nbsp; &nbsp; spi_unregister_driver(&amp;smc4000io_driver);<br>
&gt; }<br>
&gt;<br>
&gt; module_init(smc4000io_init);<br>
<br>
</div>Yes, this is right. &nbsp;The psc_spi driver automatically registers =
all<br>
spi children that it finds in the device tree onto the SPI bus.<br>
Therefore registering an spi_driver() is the right thing to do.<br>
<div class=3D"Ih2E3d"><br>
&gt; But when I do:<br>
&gt;<br>
&gt; static struct of_platform_driver smc4000_spi_of_driver =3D {<br>
&gt; &nbsp; &nbsp; .name =3D &quot;smc4000io&quot;,<br>
&gt; &nbsp; &nbsp; .match_table =3D smc4000io_of_match,<br>
&gt; &nbsp; &nbsp; .probe =3D smc4000io_of_probe,<br>
&gt; &nbsp; &nbsp; .remove &nbsp; &nbsp; &nbsp; &nbsp;=3D __devexit_p(smc40=
00io_of_remove),<br>
&gt; };<br>
&gt;<br>
&gt; static int __init smc4000io_init(void)<br>
&gt; {<br>
&gt; &nbsp; &nbsp; return of_register_platform_driver(&amp;smc4000_spi_of_d=
river);<br>
&gt; }<br>
&gt; module_init(smc4000io_init);<br>
&gt;<br>
&gt; Then my smc4000io_of_probe function never gets called.<br>
<br>
</div>Correct. &nbsp;of_platform_driver isn&#39;t useful in this case becau=
se the<br>
device cannot exist independently of the SPI bus. &nbsp;Plus an<br>
of_platform_device doesn&#39;t provide any information about the SPI bus<br=
>
itself.<br>
<div><div></div><div class=3D"Wj3C7c"><br>
g.<br>
<br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</div></div></blockquote></div><br>

--001636457c722e6cba0462ced4e4--

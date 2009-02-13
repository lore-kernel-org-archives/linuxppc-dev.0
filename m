Return-Path: <henk.stegeman@gmail.com>
Received: from mail-bw0-f216.google.com (mail-bw0-f216.google.com
	[209.85.218.216]) by ozlabs.org (Postfix) with ESMTP id 16350DDFAC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 21:48:08 +1100 (EST)
Received: by bwz12 with SMTP id 12so3110018bwz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 02:48:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
References: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
	<fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
Date: Fri, 13 Feb 2009 11:40:31 +0100
Message-ID: <ae4f76fd0902130240g72b3cdf1l21b8f7ec8ad17e76@mail.gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016364587e85365d60462ca77f3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016364587e85365d60462ca77f3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I'm busy adding support for slave deviced behind mpc52xx-psc-spi.
One complication I have is that my SPI slave device has an interrupt output
to the CPU.
My idea is to add it as a gpios property in the slave device's
configuration:

        spi@2400 {        // PSC3 (SPI IF to the IO-controller )
            device_type = "spi";
            #address-cells = <1>;
            #size-cells = <0>;
            compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
            cell-index = <2>;
            reg = <0x2400 0x100>;
            interrupts = <2 3 0>;
            interrupt-parent = <&mpc5200_pic>;
            gpios = <&gpt4 0 0>;

            io-controller@0 {
                compatible = "microkey,smc4000io";
                spi-max-frequency = <1000000>;
                reg = <0>;
                // gpios: first is IRQ to cpu
                gpios = <&gpt6 0 0>;
            };
        };


Are there better/easier ways to do this?

How should I then register my spi slave driver? My smc4000io_probe function
gets called correctly by of_spi support but when I register as follows:

static struct spi_driver smc4000io_driver = {
    .driver = {
        .name    = "smc4000io",
        .bus    = &spi_bus_type,
        .owner    = THIS_MODULE,
    },
    .probe        = smc4000io_probe,
    .remove        = __devexit_p(smc4000io_remove),
};

static int __init smc4000io_init(void)
{
    return spi_register_driver(&smc4000io_driver);
}

static void __exit smc4000io_exit(void)
{
    spi_unregister_driver(&smc4000io_driver);
}

module_init(smc4000io_init);

But when I do:

static struct of_platform_driver smc4000_spi_of_driver = {
    .name = "smc4000io",
    .match_table = smc4000io_of_match,
    .probe = smc4000io_of_probe,
    .remove        = __devexit_p(smc4000io_of_remove),
};

static int __init smc4000io_init(void)
{
    return of_register_platform_driver(&smc4000_spi_of_driver);
}
module_init(smc4000io_init);

Then my smc4000io_of_probe function never gets called.

Thanks in advance,

Henk.






On Wed, Oct 29, 2008 at 3:45 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Wed, Oct 29, 2008 at 7:43 AM, Henk Stegeman <henk.stegeman@gmail.com>
> wrote:
> > ..
> > ..
> > In my dts
> >
> > I have my chipselect defined as follows:
> >
> >         gpt4: timer@640 {    // General Purpose Timer GPT4 in GPIO mode
> for
> > SMC4000IO chip select.
> >             compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> >             cell-index = <4>;
> >             reg = <0x640 0x10>;
> >             interrupts = <1 13 0>;
> >             interrupt-parent = <&mpc5200_pic>;
> >             gpio-controller;
> >             #gpio-cells = <2>;
> >         };
> >
> > I found the gpio in
> > # cat /sys/class/gpio/gpiochip215/label
> > /soc5200@f0000000/timer@640
> >
> > The spi controller is defined like this:
> >
> >         spi@2400 {
> >             device_type = "spi";
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> >             compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
> >             cell-index = <2>;
> >             reg = <2400 100>;
> >             interrupts = <2 3 0>;
> >             interrupt-parent = <&mpc5200_pic>;
> >             gpios = <&gpt4 0 0>;
> >
> >             io-controller@0 {
> >                 compatible = "microkey,smc4000io";
> >                 spi-max-frequency = <1000000>;
> >                 reg = <0>;
> >             };
> >         };
> >
> > At bootup linux (2.6.27) reports:
> >
> > mpc52xx-psc-spi f0000960.spi: probe called without platform data, no
> > (de)activate_cs function will be called.
> >
> > Is my assumption wrong that the gpios property is the way to map
> chipselects
> > to the spi driver?
>
> Yes, that is the way you should work specify the chip selects, but the
> driver hasn't been updated to support it yet.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

--0016364587e85365d60462ca77f3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m busy adding support for slave deviced behind mpc52xx-psc-spi.<br>On=
e complication I have is that my SPI slave device has an interrupt output t=
o the CPU.<br>My idea is to add it as a gpios property in the slave device&=
#39;s configuration:<br>
<br><div style=3D"margin-left: 40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; spi@2400 {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PSC3 (SPI IF =
to the IO-controller )<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; device_type =3D &quot;spi&quot;;<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #siz=
e-cells =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatib=
le =3D &quot;fsl,mpc5200-psc-spi&quot;,&quot;fsl,mpc5200b-psc-spi&quot;;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-in=
dex =3D &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; reg =3D &lt;0x2400 0x100&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;2 3 0&gt;;<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-p=
arent =3D &lt;&amp;mpc5200_pic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpios =
=3D &lt;&amp;gpt4 0 0&gt;;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; io-controller@0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =
=3D &quot;microkey,smc4000io&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi-max-frequency =
=3D &lt;1000000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; // gpios: first is IRQ to cpu<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpios =3D =
&lt;&amp;gpt6 0 0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br></=
div><br><br>Are there better/easier ways to do this?<br><br>How should I th=
en register my spi slave driver? My smc4000io_probe function gets called co=
rrectly by of_spi support but when I register as follows:<br>
<br><div style=3D"margin-left: 80px;">static struct spi_driver smc4000io_dr=
iver =3D {<br>&nbsp;&nbsp;&nbsp; .driver =3D {<br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp; =3D &quot;smc4000io&quot;,<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; .bus&nbsp;&nbsp;&nbsp; =3D &amp;spi_bus_type,=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp;&nbsp; =3D THIS=
_MODULE,<br>
&nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; .probe&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; =3D smc4000io_probe,<br>&nbsp;&nbsp;&nbsp; .remove&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; =3D __devexit_p(smc4000io_remove),<br>};<br><br>s=
tatic int __init smc4000io_init(void)<br>{<br>&nbsp;&nbsp;&nbsp; return spi=
_register_driver(&amp;smc4000io_driver);<br>}<br>
<br>static void __exit smc4000io_exit(void)<br>{<br>&nbsp;&nbsp;&nbsp; spi_=
unregister_driver(&amp;smc4000io_driver);<br>}<br><br>module_init(smc4000io=
_init);<br></div><br>But when I do:<br><br><div style=3D"margin-left: 80px;=
">static struct of_platform_driver smc4000_spi_of_driver =3D {<br>
&nbsp;&nbsp;&nbsp; .name =3D &quot;smc4000io&quot;,<br>&nbsp;&nbsp;&nbsp; .=
match_table =3D smc4000io_of_match,<br>&nbsp;&nbsp;&nbsp; .probe =3D smc400=
0io_of_probe,<br>&nbsp;&nbsp;&nbsp; .remove&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; =3D __devexit_p(smc4000io_of_remove),<br>};<br><br>static int __init =
smc4000io_init(void)<br>
{<br>&nbsp;&nbsp;&nbsp; return of_register_platform_driver(&amp;smc4000_spi=
_of_driver);<br>}<br>module_init(smc4000io_init);<br></div><br>Then my smc4=
000io_of_probe function never gets called.<br><br>Thanks in advance,<br><br=
>Henk.<br><br>
<br><br><br><br><br><div class=3D"gmail_quote">On Wed, Oct 29, 2008 at 3:45=
 PM, Grant Likely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secr=
etlab.ca">grant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">On Wed, Oct 29, 2008 at 7:43 AM, Henk=
 Stegeman &lt;<a href=3D"mailto:henk.stegeman@gmail.com">henk.stegeman@gmai=
l.com</a>&gt; wrote:<br>
&gt; ..<br>
&gt; ..<br>
&gt; In my dts<br>
&gt;<br>
&gt; I have my chipselect defined as follows:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; gpt4: timer@640 { &nbsp; &nbsp;// General =
Purpose Timer GPT4 in GPIO mode for<br>
&gt; SMC4000IO chip select.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible =3D &quot;fsl,mpc=
5200b-gpt-gpio&quot;,&quot;fsl,mpc5200-gpt-gpio&quot;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cell-index =3D &lt;4&gt;;<br=
>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D &lt;0x640 0x10&gt;;<=
br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; interrupts =3D &lt;1 13 0&gt=
;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; interrupt-parent =3D &lt;&am=
p;mpc5200_pic&gt;;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gpio-controller;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #gpio-cells =3D &lt;2&gt;;<b=
r>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
&gt;<br>
&gt; I found the gpio in<br>
&gt; # cat /sys/class/gpio/gpiochip215/label<br>
&gt; /soc5200@f0000000/timer@640<br>
&gt;<br>
&gt; The spi controller is defined like this:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; spi@2400 {<br>
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
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg =3D &lt;2400 100&gt;;<br=
>
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
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
&gt;<br>
&gt; At bootup linux (2.6.27) reports:<br>
&gt;<br>
&gt; mpc52xx-psc-spi f0000960.spi: probe called without platform data, no<b=
r>
&gt; (de)activate_cs function will be called.<br>
&gt;<br>
&gt; Is my assumption wrong that the gpios property is the way to map chips=
elects<br>
&gt; to the spi driver?<br>
<br>
</div></div>Yes, that is the way you should work specify the chip selects, =
but the<br>
driver hasn&#39;t been updated to support it yet.<br>
<br>
g.<br>
<font color=3D"#888888"><br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</font></blockquote></div><br>

--0016364587e85365d60462ca77f3--

Return-Path: <ypelletier@haivision.com>
Received: from mx11.exchange.telus.com (mx11.exchange.telus.com
	[216.123.224.145]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "mx11.exchange.telus.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44E57DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 08:25:12 +1100 (EST)
From: Yann Pelletier <ypelletier@haivision.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Fri, 27 Mar 2009 15:14:26 -0600
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
Message-ID: <9A8B45DD4DE17F4783430D784DA0B68811C41F984A@HEXMBVS12.hostedmsx.local>
Content-Type: multipart/alternative;
	boundary="_000_9A8B45DD4DE17F4783430D784DA0B68811C41F984AHEXMBVS12host_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_9A8B45DD4DE17F4783430D784DA0B68811C41F984AHEXMBVS12host_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm trying to do the same sort of thing


On Fri, Feb 13, 2009 at 3:40 AM, Henk Stegeman <henk.stegeman at gmail.com<=
https://ozlabs.org/mailman/listinfo/linuxppc-dev>> wrote:
> I'm busy adding support for slave deviced behind mpc52xx-psc-spi.
> One complication I have is that my SPI slave device has an interrupt outp=
ut
> to the CPU.
> My idea is to add it as a gpios property in the slave device's
> configuration:
>
>         spi at 2400<https://ozlabs.org/mailman/listinfo/linuxppc-dev> {  =
      // PSC3 (SPI IF to the IO-controller )
>             device_type =3D "spi";
>             #address-cells =3D <1>;
>             #size-cells =3D <0>;
>             compatible =3D "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
>             cell-index =3D <2>;
>             reg =3D <0x2400 0x100>;
>             interrupts =3D <2 3 0>;
>             interrupt-parent =3D <&mpc5200_pic>;
>             gpios =3D <&gpt4 0 0>;
>
>             io-controller at 0<https://ozlabs.org/mailman/listinfo/linuxp=
pc-dev> {
>                 compatible =3D "microkey,smc4000io";
>                 spi-max-frequency =3D <1000000>;
>                 reg =3D <0>;
>                 // gpios: first is IRQ to cpu
>                 gpios =3D <&gpt6 0 0>;
>             };

There is a better way to do this, and driver support for it is
currently merged into Ben Herrenschmidt's -next tree.

Do this instead:
        io-controller at 0<https://ozlabs.org/mailman/listinfo/linuxppc-dev=
> {
                compatible =3D "microkey,smc4000io";
                spi-max-frequency =3D <1000000>;
                reg =3D <0>;
                interrupt-controller =3D < &gpt6 >;     // Use GPT6 as
the IRQ controller
                interrupts =3D < 1 >;    // And make it rising edge.
        };

Then add these two properties to the GPT node:

        interrupt-controller;
        #interrupt-cells =3D <1>;

Then you can use normal irq_of_parse_and_map() to set up your handler.

> How should I then register my spi slave driver? My smc4000io_probe functi=
on
> gets called correctly by of_spi support but when I register as follows:
>
> static struct spi_driver smc4000io_driver =3D {
>     .driver =3D {
>         .name    =3D "smc4000io",
>         .bus    =3D &spi_bus_type,
>         .owner    =3D THIS_MODULE,
>     },
>     .probe        =3D smc4000io_probe,
>     .remove        =3D __devexit_p(smc4000io_remove),
> };
>
> static int __init smc4000io_init(void)
> {
>     return spi_register_driver(&smc4000io_driver);
> }
>
> static void __exit smc4000io_exit(void)
> {
>     spi_unregister_driver(&smc4000io_driver);
> }
>
> module_init(smc4000io_init);

Yes, this is right.  The psc_spi driver automatically registers all
spi children that it finds in the device tree onto the SPI bus.
Therefore registering an spi_driver() is the right thing to do.

> But when I do:
>
> static struct of_platform_driver smc4000_spi_of_driver =3D {
>     .name =3D "smc4000io",
>     .match_table =3D smc4000io_of_match,
>     .probe =3D smc4000io_of_probe,
>     .remove        =3D __devexit_p(smc4000io_of_remove),
> };
>
> static int __init smc4000io_init(void)
> {
>     return of_register_platform_driver(&smc4000_spi_of_driver);
> }
> module_init(smc4000io_init);
>
> Then my smc4000io_of_probe function never gets called.

Correct.  of_platform_driver isn't useful in this case because the
device cannot exist independently of the SPI bus.  Plus an
of_platform_device doesn't provide any information about the SPI bus
itself.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


--_000_9A8B45DD4DE17F4783430D784DA0B68811C41F984AHEXMBVS12host_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"ProgId" content=3D"Word.Document">
<meta name=3D"Generator" content=3D"Microsoft Word 11">
<meta name=3D"Originator" content=3D"Microsoft Word 11">
<link rel=3D"File-List" href=3D"cid:filelist.xml@01C9AEFE.8A643900"><!--[if=
 gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:DontDisplayPageBoundaries/>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]--><style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"tab-interval:.=
5in">
<div class=3D"Section1">
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:10.0pt;
font-family:Arial">I&#8217;m trying to do the same sort of thing
<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Arial"><span style=3D"font-=
size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>On Fri, Feb 13, 2009 at 3:40 AM, <span class=3D"SpellE">Henk</span> <span =
class=3D"SpellE">Stegeman</span> &lt;<a href=3D"https://ozlabs.org/mailman/=
listinfo/linuxppc-dev"><span class=3D"SpellE">henk.stegeman</span> at gmail=
.com</a>&gt; wrote:<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> I'm busy adding support for slav=
e <span class=3D"SpellE">deviced</span> behind mpc52xx-psc-spi.<o:p></o:p><=
/span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> One complication I have is that =
my SPI slave device has an interrupt output<o:p></o:p></span></i></span></f=
ont></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">to</span> =
the CPU.<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> My idea is to add it as a <span =
class=3D"SpellE">gpios</span> property in the slave <span class=3D"GramE">d=
evice's</span><o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">configurat=
ion</span>:<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><a href=3D"https://=
ozlabs.org/mailman/listinfo/linuxppc-dev"><span class=3D"SpellE"><span clas=
s=3D"GramE">spi</span></span> at 2400</a> {<span style=3D"mso-spacerun:yes"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>// PSC3 (SPI IF to the I=
O-controller )<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"SpellE">device_type</span> =3D &quot;<span class=3D"Spe=
llE">spi</span>&quot;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>#address-cells =3D &lt;1&gt;;<o:p></o:p></span></i></span></font></pre=
>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>#size-cells =3D &lt;0&gt;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"GramE">compatible</span> =3D &quot;fsl,mpc5200-psc-spi&=
quot;,&quot;fsl,mpc5200b-psc-spi&quot;;<o:p></o:p></span></i></span></font>=
</pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"GramE">cell-index</span> =3D &lt;2&gt;;<o:p></o:p></spa=
n></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"SpellE"><span class=3D"GramE">reg</span></span> =3D &lt=
;0x2400 0x100&gt;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>interrupts =3D &lt;2 3 0&gt;;<o:p></o:p></span></i></span></font></pre=
>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"GramE">interrupt-parent</span> =3D &lt;&amp;mpc5200_pic=
&gt;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><span class=3D"SpellE"><span class=3D"GramE">gpios</span></span> =3D &=
lt;&amp;gpt4 0 <span class=3D"SpellE">0</span>&gt;;<o:p></o:p></span></i></=
span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"><span cla=
ss=3D"SpellE"><span class=3D"GramE">io</span></span><span class=3D"GramE">-=
controller</span> at 0</a> {<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span><span class=3D"GramE">compatible</span> =3D &q=
uot;microkey,smc4000io&quot;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span><span class=3D"SpellE"><span class=3D"GramE">s=
pi</span></span><span class=3D"GramE">-max-frequency</span> =3D &lt;1000000=
&gt;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span><span class=3D"SpellE"><span class=3D"GramE">r=
eg</span></span> =3D &lt;0&gt;;<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span>// <span class=3D"SpellE">gpios</span>: first =
is IRQ to <span class=3D"SpellE"><span class=3D"GramE">cpu</span></span><o:=
p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span><span class=3D"SpellE"><span class=3D"GramE">g=
pios</span></span> =3D &lt;&amp;gpt6 0 <span class=3D"SpellE">0</span>&gt;;=
<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </=
span>};<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>There is a better way to do this, and driver support for it is<o:p></o:p><=
/span></font></pre>
<pre><span class=3D"GramE"><font size=3D"2" face=3D"Courier New"><span styl=
e=3D"font-size:10.0pt">currently</span></font></span> merged into Ben <span=
 class=3D"SpellE">Herrenschmidt's</span> -next tree.<o:p></o:p></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Do this instead:<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"><span=
 class=3D"SpellE"><span class=3D"GramE">io</span></span><span class=3D"Gram=
E">-controller</span> at 0</a> {<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"Gra=
mE">compatible</span> =3D &quot;microkey,smc4000io&quot;;<o:p></o:p></span>=
</font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"Spe=
llE"><span class=3D"GramE">spi</span></span><span class=3D"GramE">-max-freq=
uency</span> =3D &lt;1000000&gt;;<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"Spe=
llE"><span class=3D"GramE">reg</span></span> =3D &lt;0&gt;;<o:p></o:p></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"Gra=
mE">interrupt-controller</span> =3D &lt; &amp;gpt6 &gt;;<span style=3D"mso-=
spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>// Use GPT6 as<o:p></o:p></sp=
an></font></pre>
<pre><span class=3D"GramE"><font size=3D"2" face=3D"Courier New"><span styl=
e=3D"font-size:10.0pt">the</span></font></span> IRQ controller<o:p></o:p></=
pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"Gra=
mE">interrupts</span> =3D &lt; 1 &gt;;<span style=3D"mso-spacerun:yes">&nbs=
p;&nbsp;&nbsp; </span>// And make it rising edge.<o:p></o:p></span></font><=
/pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span>};<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Then add these two properties to the GPT node:<o:p></o:p></span></font></p=
re>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span><span class=3D"GramE">interrupt-controller</span>;<o:p></o:p></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span>#interrupt-cells =3D &lt;1&gt;;<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Then you can use normal <span class=3D"SpellE">irq_of_parse_and_<span clas=
s=3D"GramE">map</span></span><span class=3D"GramE">(</span>) to set up your=
 handler.<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> How should I then register my <s=
pan class=3D"SpellE">spi</span> slave driver? My smc4000io_probe function<o=
:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> gets called correctly by <span c=
lass=3D"SpellE">of_spi</span> support but when I register as follows:<o:p><=
/o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">static</sp=
an> <span class=3D"SpellE">struct</span> <span class=3D"SpellE">spi_driver<=
/span> smc4000io_driver =3D {<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.driver =3D {<o:p></o:p></span></i></span><=
/font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>.name<span style=3D=
"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>=3D &quot;smc4000io&quot;,<o:p=
></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>.bus<span style=3D"=
mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>=3D &amp;<span class=3D"SpellE"=
>spi_bus_type</span>,<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>.owner<span style=
=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>=3D THIS_MODULE,<o:p></o:p>=
</span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>},<o:p></o:p></span></i></span></font></pre=
>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.probe<span style=3D"mso-spacerun:yes">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=3D smc4000io_probe,<o:p></o:=
p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.remove<span style=3D"mso-spacerun:yes">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=3D __<span class=3D"SpellE"=
>devexit_<span class=3D"GramE">p</span></span><span class=3D"GramE">(</span=
>smc4000io_remove),<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> };<o:p></o:p></span></i></span><=
/font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">static</sp=
an> <span class=3D"SpellE">int</span> __init smc4000io_init(void)<o:p></o:p=
></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> {<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>return <span class=3D"SpellE">spi_register_=
<span class=3D"GramE">driver</span></span><span class=3D"GramE">(</span>&am=
p;smc4000io_driver);<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> }<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">static</sp=
an> void __exit smc4000io_exit(void)<o:p></o:p></span></i></span></font></p=
re>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> {<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span><span class=3D"SpellE">spi_unregister_<span=
 class=3D"GramE">driver</span></span><span class=3D"GramE">(</span>&amp;smc=
4000io_driver);<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> }<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"SpellE">module_<s=
pan class=3D"GramE">init</span></span><span class=3D"GramE">(</span>smc4000=
io_init);<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Yes, this is right.<span style=3D"mso-spacerun:yes">&nbsp; </span>The <spa=
n class=3D"SpellE">psc_spi</span> driver automatically registers all<o:p></=
o:p></span></font></pre>
<pre><span class=3D"SpellE"><span class=3D"GramE"><font size=3D"2" face=3D"=
Courier New"><span style=3D"font-size:10.0pt">spi</span></font></span></spa=
n> children that it finds in the device tree onto the SPI bus.<o:p></o:p></=
pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Therefore registering an <span class=3D"SpellE">spi_<span class=3D"GramE">=
driver</span></span><span class=3D"GramE">(</span>) is the right thing to d=
o.<o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> But when I do:<o:p></o:p></span>=
</i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">static</sp=
an> <span class=3D"SpellE">struct</span> <span class=3D"SpellE">of_platform=
_driver</span> smc4000_spi_of_driver =3D {<o:p></o:p></span></i></span></fo=
nt></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.name =3D &quot;smc4000io&quot;,<o:p></o:p>=
</span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.<span class=3D"SpellE">match_table</span> =
=3D smc4000io_of_match,<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.probe =3D smc4000io_of_probe,<o:p></o:p></=
span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>.remove<span style=3D"mso-spacerun:yes">&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>=3D __<span class=3D"SpellE"=
>devexit_<span class=3D"GramE">p</span></span><span class=3D"GramE">(</span=
>smc4000io_of_remove),<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> };<o:p></o:p></span></i></span><=
/font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"GramE">static</sp=
an> <span class=3D"SpellE">int</span> __init smc4000io_init(void)<o:p></o:p=
></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> {<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp; </span>return <span class=3D"SpellE">of_register_p=
latform_<span class=3D"GramE">driver</span></span><span class=3D"GramE">(</=
span>&amp;smc4000_spi_of_driver);<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> }<o:p></o:p></span></i></span></=
font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> <span class=3D"SpellE">module_<s=
pan class=3D"GramE">init</span></span><span class=3D"GramE">(</span>smc4000=
io_init);<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"><o:p>&nbsp;</o:p></span></i></spa=
n></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>&gt;<i><span style=3D"font-style:italic"> Then my smc4000io_of_probe funct=
ion never gets called.<o:p></o:p></span></i></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Correct.<span style=3D"mso-spacerun:yes">&nbsp; </span><span class=3D"Spel=
lE">of_platform_driver</span> isn't useful in this case because the<o:p></o=
:p></span></font></pre>
<pre><span class=3D"GramE"><font size=3D"2" face=3D"Courier New"><span styl=
e=3D"font-size:10.0pt">device</span></font></span> cannot exist independent=
ly of the SPI bus.<span style=3D"mso-spacerun:yes">&nbsp; </span>Plus an<o:=
p></o:p></pre>
<pre><span class=3D"SpellE"><font size=3D"2" face=3D"Courier New"><span sty=
le=3D"font-size:10.0pt">of_platform_device</span></font></span> doesn't pro=
vide any information about the SPI bus<o:p></o:p></pre>
<pre><span class=3D"GramE"><font size=3D"2" face=3D"Courier New"><span styl=
e=3D"font-size:10.0pt">itself</span></font></span>.<o:p></o:p></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><span class=3D"GramE"><font size=3D"2" face=3D"Courier New"><span styl=
e=3D"font-size:10.0pt">g</span></font></span>.<o:p></o:p></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
><o:p>&nbsp;</o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>-- <o:p></o:p></span></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Grant Likely, B.Sc., <span class=3D"SpellE">P.Eng</span>.<o:p></o:p></span=
></font></pre>
<pre><font size=3D"2" face=3D"Courier New"><span style=3D"font-size:10.0pt"=
>Secret Lab Technologies Ltd.<o:p></o:p></span></font></pre>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Times New Roman"><span styl=
e=3D"font-size:
11.0pt"><o:p>&nbsp;</o:p></span></font></p>
</div>
</body>
</html>

--_000_9A8B45DD4DE17F4783430D784DA0B68811C41F984AHEXMBVS12host_--

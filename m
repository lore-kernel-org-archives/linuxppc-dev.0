Return-Path: <atulsdeshmukh@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id 2A8DEB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 00:14:25 +1000 (EST)
Received: by qyk1 with SMTP id 1so5864931qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 Aug 2010 07:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100802134857.GA8689@oksana.dev.rtsoft.ru>
References: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
	<AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
	<20100802134857.GA8689@oksana.dev.rtsoft.ru>
Date: Mon, 2 Aug 2010 19:44:22 +0530
Message-ID: <AANLkTikRq95=4Pbhne9CikR-gEHOOp7tETdV0Lnr0Chh@mail.gmail.com>
Subject: Re: Issues to access Compact Flash Card on MPC8360E
From: Atul Deshmukh <atulsdeshmukh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00163630fe613fcb6e048cd7d120
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163630fe613fcb6e048cd7d120
Content-Type: text/plain; charset=ISO-8859-1

Thanks a lot Anton,
>From the dts entry given below,

localbus@e0005000 {
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L251>
         #address-cells = <2>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L252>
               #size-cells = <1>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L253>
               compatible = "fsl,mpc8349e-localbus",
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L254>
                            "fsl,pq2pro-localbus";
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L255>
               reg = <0xe0005000 0xd8>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L256>
               ranges = <0x3 0x0 0xf0000000 0x210>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L257>
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L258>
               pata@3,0 {
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L259>
                       compatible = "fsl,mpc8349emitx-pata",
"ata-generic";
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L260>
                       reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L261>
                       reg-shift = <1>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L262>
                       pio-mode = <6>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L263>
                       interrupts = <23 0x8>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L264>
                      interrupt-parent = <&ipic>;
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L265>
               };
 <http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L266>
       };


we can conclude that it uses ata-generic SATA/PATA controlelr driver which
controls PCI-based IDE-controller where we can plug in our CF card...Am I
right???
But in our design we don't use any controller we directly connects CF card
to local bus where UPM controls it..
Can you please explain how the interface is implemented in MPC8349..



On Mon, Aug 2, 2010 at 7:18 PM, linuxppc-dev@lists.ozlabs.org wrote:

> On Mon, Aug 02, 2010 at 06:08:14PM +0530, Atul Deshmukh wrote:
> [...]
> > 2: To access CF card in True IDE mode we have to use
> > "linux-kernel-source/drivers/ata/pata_platform.c" and
> > "linux-kernel-source/drivers/ata/libata-sff.c".....I'm going right??
>
> CF IDE support was already implemented for MPC8349EmITX boards
> with a bit of help from UPM (User-Programmable Machine), so
> you can do the same for MPC8360.
>
> UPM is programmed in U-Boot, u-boot/include/configs/MPC8349ITX.h
> (CONFIG_SYS_BR3_PRELIM stuff), and
> u-boot/board/freescale/mpc8349itx/mpc8349itx.c (UPMATable).
>
> For linux part, see arch/powerpc/boot/dts/mpc8349emitx.dts (pata
> node), and drivers/ata/pata_of_platform.c.
>
> For HW side, you can find MPC8349EmITX schematics on Freescale
> site (last time I checked, no registration was required).
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



-- 
Regards,
Atul

--00163630fe613fcb6e048cd7d120
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks a lot Anton,<br>From the dts entry given below, <br><pre class=3D"do=
ne" id=3D"97/0b/e6e9411e1792a01199c69b29f9235db64018_3/0">localbus@e0005000=
 {<br><a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349e=
mitx.dts#L251" id=3D"L251" class=3D"line" name=3D"L251"></a>          #addr=
ess-cells =3D &lt;2&gt;;<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L252" id=3D"L252" class=3D"line" name=3D"L252"></a>                #size=
-cells =3D &lt;1&gt;;<br><a href=3D"http://lxr.linux.no/linux+*/arch/powerp=
c/boot/dts/mpc8349emitx.dts#L253" id=3D"L253" class=3D"line" name=3D"L253">=
</a>                compatible =3D &quot;fsl,mpc8349e-localbus&quot;,<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L254" id=3D"L254" class=3D"line" name=3D"L254"></a>                     =
        &quot;fsl,pq2pro-localbus&quot;;<br><a href=3D"http://lxr.linux.no/=
linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L255" id=3D"L255" class=3D"l=
ine" name=3D"L255"></a>                reg =3D &lt;0xe0005000 0xd8&gt;;<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L256" id=3D"L256" class=3D"line" name=3D"L256"></a>                range=
s =3D &lt;0x3 0x0 0xf0000000 0x210&gt;;<br><a href=3D"http://lxr.linux.no/l=
inux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L257" id=3D"L257" class=3D"li=
ne" name=3D"L257"></a><br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L258" id=3D"L258" class=3D"line" name=3D"L258"></a>                pata@=
3,0 {<br><a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc83=
49emitx.dts#L259" id=3D"L259" class=3D"line" name=3D"L259"></a>            =
            compatible =3D &quot;fsl,mpc8349emitx-pata&quot;, &quot;ata-gen=
eric&quot;;<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L260" id=3D"L260" class=3D"line" name=3D"L260"></a>                     =
   reg =3D &lt;0x3 0x0 0x10 0x3 0x20c 0x4&gt;;<br><a href=3D"http://lxr.lin=
ux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L261" id=3D"L261" clas=
s=3D"line" name=3D"L261"></a>                        reg-shift =3D &lt;1&gt=
;;<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L262" id=3D"L262" class=3D"line" name=3D"L262"></a>                     =
   pio-mode =3D &lt;6&gt;;<br><a href=3D"http://lxr.linux.no/linux+*/arch/p=
owerpc/boot/dts/mpc8349emitx.dts#L263" id=3D"L263" class=3D"line" name=3D"L=
263"></a>                        interrupts =3D &lt;23 0x8&gt;;<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L264" id=3D"L264" class=3D"line" name=3D"L264"></a>                     =
  interrupt-parent =3D &lt;&amp;ipic&gt;;<br><a href=3D"http://lxr.linux.no=
/linux+*/arch/powerpc/boot/dts/mpc8349emitx.dts#L265" id=3D"L265" class=3D"=
line" name=3D"L265"></a>                };<br>
<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/boot/dts/mpc8349emitx.d=
ts#L266" id=3D"L266" class=3D"line" name=3D"L266"></a>        };</pre>
<br>we can conclude that it uses ata-generic SATA/PATA controlelr driver wh=
ich controls PCI-based IDE-controller where we can plug in our CF card...Am=
 I right???<br>But in our design we don&#39;t use any controller we directl=
y connects CF card to local bus where UPM controls it..<br>
Can you please explain how the interface is implemented in MPC8349..<br><br=
><pre class=3D"done" id=3D"97/0b/e6e9411e1792a01199c69b29f9235db64018_3/0">=
<br></pre><br><div class=3D"gmail_quote">On Mon, Aug 2, 2010 at 7:18 PM, <a=
 href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozlabs.or=
g</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Mon, Aug 02, 2=
010 at 06:08:14PM +0530, Atul Deshmukh wrote:<br>
[...]<br>
<div class=3D"im">&gt; 2: To access CF card in True IDE mode we have to use=
<br>
&gt; &quot;linux-kernel-source/drivers/ata/pata_platform.c&quot; and<br>
&gt; &quot;linux-kernel-source/drivers/ata/libata-sff.c&quot;.....I&#39;m g=
oing right??<br>
<br>
</div>CF IDE support was already implemented for MPC8349EmITX boards<br>
with a bit of help from UPM (User-Programmable Machine), so<br>
you can do the same for MPC8360.<br>
<br>
UPM is programmed in U-Boot, u-boot/include/configs/MPC8349ITX.h<br>
(CONFIG_SYS_BR3_PRELIM stuff), and<br>
u-boot/board/freescale/mpc8349itx/mpc8349itx.c (UPMATable).<br>
<br>
For linux part, see arch/powerpc/boot/dts/mpc8349emitx.dts (pata<br>
node), and drivers/ata/pata_of_platform.c.<br>
<br>
For HW side, you can find MPC8349EmITX schematics on Freescale<br>
site (last time I checked, no registration was required).<br>
<font color=3D"#888888"><br>
--<br>
Anton Vorontsov<br>
email: <a href=3D"mailto:cbouatmailru@gmail.com">cbouatmailru@gmail.com</a>=
<br>
irc://<a href=3D"http://irc.freenode.net/bd2" target=3D"_blank">irc.freenod=
e.net/bd2</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br>Atul=
 <br><br>=A0 <br>

--00163630fe613fcb6e048cd7d120--

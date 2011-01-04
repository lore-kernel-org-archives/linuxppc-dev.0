Return-Path: <gramaalexandruionut@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id EFEC5B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 08:43:12 +1100 (EST)
Received: by wyi11 with SMTP id 11so14548949wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Jan 2011 13:43:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110103160706.4329947c@udp111988uds.am.freescale.net>
References: <AANLkTikjjGGd5h7TsQtEuSjX3qhJv3wC28UtWHtJ19jo@mail.gmail.com>
	<20110103160706.4329947c@udp111988uds.am.freescale.net>
From: Alexandru Ionut Grama <gramaalexandruionut@gmail.com>
Date: Tue, 4 Jan 2011 22:42:49 +0100
Message-ID: <AANLkTi=s5id7QJ4nmfdSsuY3Y==b_5xyqHM3Y+K2HUXr@mail.gmail.com>
Subject: Re: problem backporting talitos for MPC8272
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=0016364162a99b5ebe04990c2781
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364162a99b5ebe04990c2781
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You're right Scott, there's no section in arch/powerpc/boot/Makefile
involving dts file for mpc8272ads.

Well some time ago I've already write an email explaining that I've try to
port a custom board patch from 2.6.21 to 2.6.35. I can't make the changes
properly in 2.6.35, so that's why I've decided to backport cryptoAPI and
talitos to 2.6.21.

 Because it's custom, the CPM_MAP_ADDR it's change from 0xF0000000 to
0xFF000000. =BFChanging this in mpc8272ads.dts

soc8272@f0000000 {
               #address-cells =3D <1>;
               #size-cells =3D <1>;
               #interrupt-cells =3D <2>;
               device_type =3D "soc";
               ranges =3D <00000000 f0000000 00053000>;
               reg =3D <f0000000 10000>;

 cpm@f0000000 {
                       linux,phandle =3D <f0000000>;
                       #address-cells =3D <1>;
                       #size-cells =3D <1>;
                       #interrupt-cells =3D <2>;
                       device_type =3D "cpm";
                       model =3D "CPM2";
                       ranges =3D <00000000 00000000 20000>;
                       reg =3D <0 20000>;
                       command-proc =3D <119c0>;
                       brg-frequency =3D <17D7840>;
                       cpm_clk =3D <BEBC200>;



to this

soc8272@ff000000 {
               #address-cells =3D <1>;
               #size-cells =3D <1>;
               #interrupt-cells =3D <2>;
               device_type =3D "soc";
               ranges =3D <00000000 ff000000 00053000>;
               reg =3D <ff000000 10000>;

cpm@ff000000 {
                       linux,phandle =3D <ff000000>;
                       #address-cells =3D <1>;
                       #size-cells =3D <1>;
                       #interrupt-cells =3D <2>;
                       device_type =3D "cpm";
                       model =3D "CPM2";
                       ranges =3D <00000000 00000000 20000>;
                       reg =3D <0 20000>;
                       command-proc =3D <119c0>;
                       brg-frequency =3D <17D7840>;
                       cpm_clk =3D <BEBC200>;


should solve this issue?

Also there is change in arch/powerpc/platforms/82xx/mpc82xx_ads.c


+ static void __init m82xx_map_io(void)   /* gonza */
+ {
+     io_block_mapping(CPM_MAP_ADDR, CPM_MAP_ADDR, ((uint)(4 * 64 * 1024)),
_PAGE_IO);
+ }
+
+

define_machine(mpc82xx_ads)
  {
    .name =3D "MPC82xx ADS",

***************
*** 642,645 ****
--- 648,652 ----
    .get_irq =3D    cpm2_get_irq,
    .calibrate_decr =3D    m82xx_calibrate_decr,
    .restart =3D m82xx_restart,.halt =3D m82xx_halt,
+   .setup_io_mappings =3D    m82xx_map_io, /* gonza */

  };


Redefining the address of CPM in the dts file, the kernel "io_block_map"
properly that address without no more code?

Thank you very much.
Alexandru.


2011/1/3 Scott Wood <scottwood@freescale.com>

> On Wed, 29 Dec 2010 02:10:55 +0100
> Alexandru Ionut Grama <gramaalexandruionut@gmail.com> wrote:
>
> > My final question it's about of-tree. I have the mpc8272ads.dts file wi=
th
> a
> > tree that involves talitos, but I've changed the properties acording th=
e
> new
> > version of it on 2.6.35. =BFThis file (mpc8272ads.dts) when it's used?I
> think
> > I don't use this file for nothing (it doesn't appears on make V=3D1)
> because I
> > don't have a normal bootloader and I have to load the kernel like a
> > flat-binary gz, so there's no more step after building System.map.
>
> IIRC, in 2.6.21, it wasn't used on 82xx (I think there was only
> arch/ppc support for 82xx, or at best 82xx arch/powerpc support was
> just getting started).  2.6.21 is very old, and doing new development on
> it is not recommended.
>
> Why not work with the current kernel?
>
> -Scott
>
>


--=20
*---------------------------------------------------------------
Alexandru Ionut Grama
**email: gramaalexandruionut@gmail.com**
*

--0016364162a99b5ebe04990c2781
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You&#39;re right Scott, there&#39;s no section in arch/powerpc/boot/Makefil=
e involving dts file for mpc8272ads.<br><br>Well some time ago I&#39;ve alr=
eady write an email explaining that I&#39;ve try to port a custom board pat=
ch from 2.6.21 to 2.6.35. I can&#39;t make the changes properly in 2.6.35, =
so that&#39;s why I&#39;ve decided to backport cryptoAPI and talitos to 2.6=
.21.<br>

<br>=A0Because it&#39;s custom, the CPM_MAP_ADDR it&#39;s change from 0xF00=
00000 to 0xFF000000. =BFChanging this in mpc8272ads.dts<br><br>soc8272@f000=
0000 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt=
;1&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;1=
&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #interrupt-cells =3D &lt;2&gt;;<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D &quot;soc&quo=
t;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges =3D &lt;00000000 f=
0000000 00053000&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D=
 &lt;f0000000 10000&gt;;<br><br>=A0cpm@f0000000 {<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 linux,ph=
andle =3D &lt;f0000000&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;1&g=
t;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #=
interrupt-cells =3D &lt;2&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_t=
ype =3D &quot;cpm&quot;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 model =3D &quot;CPM2&quot;;<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges =3D &lt;00000000 00000=
000 20000&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 reg =3D &lt;0 20000&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command-=
proc =3D &lt;119c0&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 brg-frequency =3D &lt;17D7840&gt;;<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpm_clk =3D &lt;BEBC200&gt=
;;<br><br><br><br>to this<br><br>soc8272@ff000000 {<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;1&gt;;<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #interrupt-cells =3D &lt;2&gt;;<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D &quot;soc&quo=
t;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges =3D &lt;00000000 f=
f000000 00053000&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D=
 &lt;ff000000 10000&gt;;<br>

<br>cpm@ff000000 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 linux,phandle =3D &lt;ff000000&gt;;<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&g=
t;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #=
size-cells =3D &lt;1&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 #interrupt-cells =3D &lt;2&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_t=
ype =3D &quot;cpm&quot;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 model =3D &quot;CPM2&quot;;<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges =3D &lt;00000000 00000=
000 20000&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 reg =3D &lt;0 20000&gt;;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command-=
proc =3D &lt;119c0&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 brg-frequency =3D &lt;17D7840&gt;;<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpm_clk =3D &lt;BEBC200&gt=
;;<br><br><br>should solve this issue?<br><br>Also there is change in arch/=
powerpc/platforms/82xx/mpc82xx_ads.c<pre>

+ static void __init m82xx_map_io(void)   /* gonza */<br>+ {<br>+     io_bl=
ock_mapping(CPM_MAP_ADDR, CPM_MAP_ADDR, ((uint)(4 * 64 * 1024)),<br>_PAGE_I=
O);<br>+ }<br>+<br>+<br><br>define_machine(mpc82xx_ads)<br>  {<br>    .name=
 =3D &quot;MPC82xx ADS&quot;,<br>

***************<br>*** 642,645 ****<br>--- 648,652 ----<br>    .get_irq =3D=
    cpm2_get_irq,<br>    .calibrate_decr =3D    m82xx_calibrate_decr,<br>  =
  .restart =3D m82xx_restart,.halt =3D m82xx_halt,<br>+   .setup_io_mapping=
s =3D    m82xx_map_io, /* gonza */<br>

  };<br><br><br></pre>Redefining the address of CPM in the dts file, the ke=
rnel &quot;io_block_map&quot; properly that address without no more code?<b=
r><br>Thank you very much.<br>Alexandru.<br><br><br><div class=3D"gmail_quo=
te">

2011/1/3 Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@frees=
cale.com" target=3D"_blank">scottwood@freescale.com</a>&gt;</span><br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


<div>On Wed, 29 Dec 2010 02:10:55 +0100<br>
Alexandru Ionut Grama &lt;<a href=3D"mailto:gramaalexandruionut@gmail.com" =
target=3D"_blank">gramaalexandruionut@gmail.com</a>&gt; wrote:<br>
<br>
&gt; My final question it&#39;s about of-tree. I have the mpc8272ads.dts fi=
le with a<br>
&gt; tree that involves talitos, but I&#39;ve changed the properties acordi=
ng the new<br>
&gt; version of it on 2.6.35. =BFThis file (mpc8272ads.dts) when it&#39;s u=
sed?I think<br>
&gt; I don&#39;t use this file for nothing (it doesn&#39;t appears on make =
V=3D1) because I<br>
&gt; don&#39;t have a normal bootloader and I have to load the kernel like =
a<br>
&gt; flat-binary gz, so there&#39;s no more step after building System.map.=
<br>
<br>
</div>IIRC, in 2.6.21, it wasn&#39;t used on 82xx (I think there was only<b=
r>
arch/ppc support for 82xx, or at best 82xx arch/powerpc support was<br>
just getting started). =A02.6.21 is very old, and doing new development on<=
br>
it is not recommended.<br>
<br>
Why not work with the current kernel?<br>
<font color=3D"#888888"><br>
-Scott<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><b>-------------=
--------------------------------------------------<br>Alexandru Ionut Grama=
<br></b><i style=3D"color: rgb(102, 102, 102);">email: <a href=3D"mailto:gr=
amaalexandruionut@gmail.com" target=3D"_blank">gramaalexandruionut@gmail.co=
m</a></i><b><br>


</b><br>

--0016364162a99b5ebe04990c2781--

Return-Path: <s104259@yahoo.it>
Received: from web23107.mail.ird.yahoo.com (web23107.mail.ird.yahoo.com
	[217.146.189.47]) by ozlabs.org (Postfix) with SMTP id C018CDDEE4
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 02:40:14 +1100 (EST)
Date: Fri, 5 Dec 2008 15:40:12 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Re: R: usb/eth DTS nodes for custom board based on mpc5200
To: gianfranco.casanova@alice.it, Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40812050725v7b6d5c8axc5a2aabec18c6e83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-643437297-1228491612=:73887"
Message-ID: <514412.73887.qm@web23107.mail.ird.yahoo.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
Reply-To: s104259@yahoo.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-643437297-1228491612=:73887
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using 2.6.26.3 nothing changes.



Reading MPC5200 user guide I calculate the value of port_config to
configure USB on ethernet port. So I'm using this value in arch=3Dppc
everyting works.

With arch=3Dpowerpc I see that the kernel read the device tree blob, so I t=
hink that I need to modify it.



However, when I plug-in my usb storage.. the system try to "initialize" the=
 device but something is dead...



How can I enable the sequent option (irqpoll):

...

irq 134: nobody cared (try booting with the "irqpoll" option)
...


thanks,
@ngel


--- Ven 5/12/08, Grant Likely <grant.likely@secretlab.ca> ha scritto:
Da: Grant Likely <grant.likely@secretlab.ca>
Oggetto: Re: usb/eth DTS nodes for custom board based on mpc5200
A: s104259@yahoo.it
Cc: devicetree-discuss@ozlabs.org
Data: Venerd=C3=AC 5 dicembre 2008, 16:16

On Fri, Dec 5, 2008 at 8:02 AM, Angelo <s104259@yahoo.it> wrote:
> Ok.
>
> Tha main problem is that if I cross-compile kernel for ARCH=3Dppc
everythings
> work fine.
>
>>"Configuring the Ethernet pins for USB IO is just a pin routing
board setup
>> task."
>
> What should I do for this?!?!?

Without seeing your board I don't know, but I do know that there have
been a *lot* of changes in mpc5200 support since 2.6.21, including
USB.  You should try using a 2.6.27 kernel.

>
> * I've configured the port_config in  lite5200_setup_cpu(void)
function
> [arch/powerpc/platforms/52xx/lite5200.c]. I put in port_config the same
> value that I put with ARCH=3Dppc!
>
> However I'm sure that my u-boot sets-up the port_config register
because
> fatls usb 0:1 / show me the content of usb-storage.

If U-Boot sets up port_config correctly, then you do *not* need to
change the setting in the kernel.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

--- Ven 5/12/08, Grant Likely <grant.likely@secretlab.ca> ha scritto:
Da: Grant Likely <grant.likely@secretlab.ca>
Oggetto: Re: R: usb/eth DTS nodes for custom board based on mpc5200
A: gianfranco.casanova@alice.it
Cc: s104259@yahoo.it, "linuxppc-dev" <linuxppc-dev@ozlabs.org>, devicetree-=
discuss@ozlabs.org
Data: Venerd=C3=AC 5 dicembre 2008, 16:25

On Fri, Dec 5, 2008 at 8:16 AM,  <gianfranco.casanova@alice.it> wrote:
> Hi Grant
>
> we have already tested what you are suggesting, but nothing happens.
>
> I'm supposing the problem comes from interrupts.

Unlikely.  The interrupt routing is hard wired into the SoC and
probably not messed up (unless the USB node in the device tree has
been changed).  You may have a problem with port_config (setup for
single ended vs differential signaling) or some other electrical
difference from the 5200.  Beyond that it's not something that is easy
to figure out over email.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
=0A=0A=0A      
--0-643437297-1228491612=:73887
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Using 2.6.26.3 nothing changes.<br>
<br>
Reading MPC5200 user guide I calculate the value of port_config to
configure USB on ethernet port. So I'm using this value in arch=3Dppc
everyting works.<br>
With arch=3Dpowerpc I see that the kernel read the device tree blob, so I t=
hink that I need to modify it.<br>
<br>
However, when I plug-in my usb storage.. the system try to "initialize" the=
 device but something is dead...<br>
<br>
How can I enable the sequent option (irqpoll):<br>
...<br>
irq 134: nobody cared (try booting with the "irqpoll" option)<br>...<br>
<br>thanks,<br>@ngel<br>
<br>--- <b>Ven 5/12/08, Grant Likely <i>&lt;grant.likely@secretlab.ca&gt;</=
i></b> ha scritto:<br>Da: Grant Likely &lt;grant.likely@secretlab.ca&gt;<br=
>Oggetto: Re: usb/eth DTS nodes for custom board based on mpc5200<br>A: s10=
4259@yahoo.it<br>Cc: devicetree-discuss@ozlabs.org<br>Data: Venerd=C3=AC 5 =
dicembre 2008, 16:16<br><br><pre>On Fri, Dec 5, 2008 at 8:02 AM, Angelo &lt=
;s104259@yahoo.it&gt; wrote:<br>&gt; Ok.<br>&gt;<br>&gt; Tha main problem i=
s that if I cross-compile kernel for ARCH=3Dppc<br>everythings<br>&gt; work=
 fine.<br>&gt;<br>&gt;&gt;"Configuring the Ethernet pins for USB IO is just=
 a pin routing<br>board setup<br>&gt;&gt; task."<br>&gt;<br>&gt; What shoul=
d I do for this?!?!?<br><br>Without seeing your board I don't know, but I d=
o know that there have<br>been a *lot* of changes in mpc5200 support since =
2.6.21, including<br>USB.  You should try using a 2.6.27 kernel.<br><br>&gt=
;<br>&gt; * I've configured the port_config in=20
 lite5200_setup_cpu(void)<br>function<br>&gt; [arch/powerpc/platforms/52xx/=
lite5200.c]. I put in port_config the same<br>&gt; value that I put with AR=
CH=3Dppc!<br>&gt;<br>&gt; However I'm sure that my u-boot sets-up the port_=
config register<br>because<br>&gt; fatls usb 0:1 / show me the content of u=
sb-storage.<br><br>If U-Boot sets up port_config correctly, then you do *no=
t* need to<br>change the setting in the kernel.<br><br>-- <br>Grant Likely,=
 B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.</pre><br><br>--- <b>Ven 5/12=
/08, Grant Likely <i>&lt;grant.likely@secretlab.ca&gt;</i></b> ha scritto:<=
br><blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-lef=
t: 5px; padding-left: 5px;">Da: Grant Likely &lt;grant.likely@secretlab.ca&=
gt;<br>Oggetto: Re: R: usb/eth DTS nodes for custom board based on mpc5200<=
br>A: gianfranco.casanova@alice.it<br>Cc: s104259@yahoo.it, "linuxppc-dev" =
&lt;linuxppc-dev@ozlabs.org&gt;, devicetree-discuss@ozlabs.org<br>Data:
 Venerd=C3=AC 5 dicembre 2008, 16:25<br><br><pre>On Fri, Dec 5, 2008 at 8:1=
6 AM,  &lt;gianfranco.casanova@alice.it&gt; wrote:<br>&gt; Hi Grant<br>&gt;=
<br>&gt; we have already tested what you are suggesting, but nothing happen=
s.<br>&gt;<br>&gt; I'm supposing the problem comes from interrupts.<br><br>=
Unlikely.  The interrupt routing is hard wired into the SoC and<br>probably=
 not messed up (unless the USB node in the device tree has<br>been changed)=
.  You may have a problem with port_config (setup for<br>single ended vs di=
fferential signaling) or some other electrical<br>difference from the 5200.=
  Beyond that it's not something that is easy<br>to figure out over email.<=
br><br>g.<br><br>-- <br>Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technolog=
ies Ltd.<br></pre></blockquote></td></tr></table><br>=0A=0A=0A=0A      
--0-643437297-1228491612=:73887--

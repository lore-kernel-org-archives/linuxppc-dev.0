Return-Path: <kkboyanov@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.194])
	by ozlabs.org (Postfix) with ESMTP id A2AC967B18
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 09:33:56 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id s17so701088wxc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 16:33:55 -0700 (PDT)
Message-ID: <929bf310605251633y110bb24br@mail.gmail.com>
Date: Fri, 26 May 2006 01:33:55 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: VME driver problem on MVME6100
In-Reply-To: <929bf310605251200s66106eaer@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15637_2226465.1148600035139"
References: <929bf310605250923i1924c12bj@mail.gmail.com>
	<007501c6801c$3b86fde0$0400a8c0@DLAPTOP>
	<929bf310605251200s66106eaer@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15637_2226465.1148600035139
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/5/25, Konstantin Boyanov <kkboyanov@gmail.com>:
>
> Hi again,
>
> The problem persist even with the new driver for 2.6 ... :(
> It is obvious that the driver cannot allocate memory for the window... It
> fails that thing called __ioremap(), whatever it might be used for:
>
> [mvme6100]# vme_setoutboundwin -h
> vme_setoutboundwin
> Usage: vme_setoutboundwin <options>
>         -w <window>     window(where 0<=3Dwindow<=3D6)
>         -m <mode>       address mode (where
> 0=3DA16,1=3DA24,2=3DA32,3=3DA64,4=3DCRCSR)
>         -p <protocol>   protocol (where
> 1=3DSCT,2=3DBLT,4=3DMBLT,8=3D2eVME,0x10=3D2eSST)
>         -a <VME addr>   VME address
>         -d <data width> data width (8, 16, 32, 64)
>         -s <window size>        window size (where 0 < window_size <=3D
> 0x400000)
>         -v              Be more verbose
>         -h              Give this (short) help
>
> [mvme6100]# vme_setoutboundwin -w0 -m0 -p8 -a0x8800 -d16 -s400000 -v
> window =3D 0, mode =3D 0 protocol 0x8 vme_addr =3D 0x8800 data width =3D =
16
> __ioremap(): phys addr 01000000 is RAM lr d100be34
> vmedrv: No memory for outbound window
> ioctl VME_IOCTL_SET_OUTBOUND failed.: Cannot allocate memory
>
> While searching on the web for information about __ioremap I found this:
>
> /*
>  * Remap an arbitrary physical address space into the kernel virtual
>  * address space. Needed when the kernel wants to access high addresses
>  * directly.
>  *
>
>  * NOTE! We need to allow non-page-aligned mappings too: we will obviousl=
y
>  * have to convert them into an offset in a page-aligned mapping, but the
>  * caller shouldn't need to know that small detail.
>  */
>
>
>  And another thing - people should not be using __ioremap() unless they
> have a _good_ _reason_ in their driver.  They should be using ioremap()
> instead.  __ioremap() is an architecture implementation detail which
>
> has no interface stability guarantees _at all_.
>
> How's that? So it seems that the kernel can't translate the accesses to
> the VME bus propperly. Any ideas how to fix that?
> Actually I cant figure out why configuring a single outbound window is so
> damn tough to achieve.e maybe I'm missing some crutial settings. I tried
> to set up the window attribute register, and the outbound translation off=
set
> register in the hope to fit in the needed size for the window, but again
> failed. I'm trying to get frustrated about that...
>
> Best regards,
> Konstantin
>
>  P.S. I forgot to say that on the target I'm booting a bare kernel with
not much functionality. Could it be that there are missing some settings fo=
r
the virtual memory management, which are crutial for the VME driver? I mean
the above message "phys addr 01000000 is RAM lr d100be34" is somehow
connected to misconfiguration (or lack of it at all) for the virtual memory
pages? That's what I can think of som late in the night...
Thank you anyways.

Best regards,
Konstantin

------=_Part_15637_2226465.1148600035139
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">2006/5/25, Konstantin Boyanov &lt;=
<a href=3D"mailto:kkboyanov@gmail.com">kkboyanov@gmail.com</a>&gt;:</span><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi again,<br>
<br>
The problem persist even with the new driver for 2.6 ... :(<br>
It is obvious that the driver cannot allocate memory for the window...
It fails that thing called __ioremap(), whatever it might be used for:<br>
<br>
<div style=3D"margin-left: 40px;">[mvme6100]# vme_setoutboundwin -h<br>
vme_setoutboundwin<br>
Usage: vme_setoutboundwin &lt;options&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -w &lt;window&gt;&nbsp;&nbsp;&nb=
sp;&nbsp; window(where 0&lt;=3Dwindow&lt;=3D6)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -m
&lt;mode&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address mode (where
0=3DA16,1=3DA24,2=3DA32,3=3DA64,4=3DCRCSR)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -p
&lt;protocol&gt;&nbsp;&nbsp; protocol (where
1=3DSCT,2=3DBLT,4=3DMBLT,8=3D2eVME,0x10=3D2eSST)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -a &lt;VME addr&gt;&nbsp;&nbsp; =
VME address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -d &lt;data width&gt; data width=
 (8, 16, 32, 64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -s &lt;window
size&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; window size (where 0
&lt; window_size &lt;=3D 0x400000)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-v&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
Be more verbose<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
Give this (short) help<br>
<br>
[mvme6100]# vme_setoutboundwin -w0 -m0 -p8 -a0x8800 -d16 -s400000 -v<br>
window =3D 0, mode =3D 0 protocol 0x8 vme_addr =3D 0x8800 data width =3D 16
<span class=3D"q"><br>
__ioremap(): phys addr 01000000 is RAM lr d100be34
<br></span><span class=3D"q">
vmedrv: No memory for outbound window
<br></span>
ioctl VME_IOCTL_SET_OUTBOUND failed.: Cannot allocate memory
<br>
</div>
<br>
While searching on the web for information about __ioremap I found this:<br=
>
<pre style=3D"margin-left: 40px;"><font size=3D"-1">/*<br> * Remap an arbit=
rary physical address space into the kernel virtual<br> * address space. Ne=
eded when the kernel wants to access high addresses<br> * directly.<br> *<b=
r>
<br> * NOTE! We need to allow non-page-aligned mappings too: we will obviou=
sly<br> * have to convert them into an offset in a page-aligned mapping, bu=
t the<br> * caller shouldn't need to know that small detail.<br> */</font>
</pre>


<div style=3D"margin-left: 40px;"><br>
</div>

<pre style=3D"margin-left: 40px;">And another thing - people should not be =
using __ioremap() unless they<br>have a _good_ _reason_ in their driver.  T=
hey should be using ioremap()<br>instead.  __ioremap() is an architecture i=
mplementation detail which
<br><br>has no interface stability guarantees _at all_.</pre>
How's that? So it seems that the kernel can't translate the accesses to the=
 VME bus propperly. Any ideas how to fix that?<br>
Actually I cant figure out why configuring a single outbound window is
so damn tough to achieve.e maybe I'm missing some crutial settings. I
tried to set up the window attribute register, and the outbound
translation offset register in the hope to fit in the needed size for
the window, but again failed. I'm trying to get frustrated about that...<br=
>
<br>
Best regards,<br><span class=3D"sg">
Konstantin<br>
<br>

</span></blockquote></div>&nbsp;P.S. I forgot to say that on the target
I'm booting a bare kernel with not much functionality. Could it be that
there are missing some settings for the virtual memory management,
which are crutial for the VME driver? I mean the above message <span class=
=3D"q">&quot;phys
addr 01000000 is RAM lr d100be34&quot; is somehow connected to
misconfiguration (or lack of it at all) for the virtual memory pages?
That's what I can think of som late in the night...<br>
Thank you anyways.<br>
<br>
Best regards,<br>
Konstantin<br>
</span><br>

------=_Part_15637_2226465.1148600035139--

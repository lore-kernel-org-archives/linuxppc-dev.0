Return-Path: <csdncannon@gmail.com>
Received: from mail-pz0-f173.google.com (mail-pz0-f173.google.com
	[209.85.222.173]) by ozlabs.org (Postfix) with ESMTP id 03FD3B7CB9
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:11:14 +1100 (EST)
Received: by pzk3 with SMTP id 3so899098pzk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 18:11:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1269549524.8599.243.camel@pasglop>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
Date: Fri, 26 Mar 2010 09:11:13 +0800
Message-ID: <43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=0016e64c3ba2e6baef0482a9d611
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e64c3ba2e6baef0482a9d611
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

After trying the new code with "isync" and unsigned long long convertion,
this problem doesn't happen(I tested for several minutes). But the previous
block of codes(lacking of isync) is borrowed from kernel. And if this is a
bug of kernel?

Thanks
Gino

2010/3/26 Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Thu, 2010-03-25 at 23:00 +0800, Csdncannon wrote:
> > I am really sorry that the previously attached code is wrong, this one
> > "timebase.c" is the right one, and the "log_timebase" file is the
> > right log.
> >
> > We are using FreeScale PowerPc 8378, kernel 2.6.28 and compiled as
> > 32-bit.
>
> And despite all those sync/isync you can still observe the timebase
> going backward ? That sounds scary. However, at this stage all I can
> suggest is getting freescale folks to have a look, as this should really
> not happen. Maybe there's some setting with that specific SoC that is
> missing or similar...
>
> Cheers,
> Ben.
>
> >
> > Thanks
> > Gino
> >
> > 2010/3/25 Arnd Bergmann <arnd@arndb.de>
> >         On Thursday 25 March 2010, Benjamin Herrenschmidt wrote:
> >         > On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wrote:
> >         > >          In my program, the value of the 64-bit time base
> >         register is
> >         > > read out, and you will find the later value is even
> >         smaller than the
> >         > > earlier value from the log =93log_timebase=94. While the
> >         kernel depends on
> >         > > the accuracy of the timebase for the compensation of the
> >         lost PIT
> >         > > interrupt, the negative value between two continual
> >         timebase reading
> >         > > will bring to the jump of the jiffies. And this timebase
> >         problem will
> >         > > bring to the instability of the gettimeofday system call.
> >         > >
> >         > >          Do you have any idea about this problem, thanks
> >         for your any
> >         > > advice. Attached is the code and log.
> >         >
> >         > This is a concern, it should definitely not happen. What
> >         machine is
> >         > that ? is the code compiled 32-bit or 64-bit ? What kernel
> >         version ?
> >         >
> >         > Arnd, any chance that could relate to the bug you've been
> >         chasing on
> >         > Cell ?
> >
> >
> >         We're still busy with the problem analysis on Cell, waiting
> >         for a time
> >         slot to run the next test kernel. So far it seems like the
> >         timebase
> >         is actually synchronized at a significant accuracy on QS22 to
> >         never
> >         cause this problem with correct code, however it is possible
> >         to
> >         observe incorrect timebase values on Cell whenever the mftb
> >         instruction
> >         is not serialized with memory accesses, e.g. by using an isync
> >         in front
> >         of the mftb. On Power6 and other CPUs, that problem will not
> >         happen.
> >
> >                Arnd
> >
>
>
>

--0016e64c3ba2e6baef0482a9d611
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

After trying the new code with &quot;isync&quot; and unsigned long long con=
vertion, this problem doesn&#39;t happen(I tested for several minutes). But=
 the previous block of codes(lacking of isync) is borrowed from kernel. And=
 if this is a bug of kernel?<br>
<br>Thanks<br>Gino<br><br><div class=3D"gmail_quote">2010/3/26 Benjamin Her=
renschmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org=
">benh@kernel.crashing.org</a>&gt;</span><br><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Thu, 2010-03-25 at 23:00 +0800, Csdncannon wrote:<br>
&gt; I am really sorry that the previously attached code is wrong, this one=
<br>
&gt; &quot;timebase.c&quot; is the right one, and the &quot;log_timebase&qu=
ot; file is the<br>
&gt; right log.<br>
&gt;<br>
&gt; We are using FreeScale PowerPc 8378, kernel 2.6.28 and compiled as<br>
&gt; 32-bit.<br>
<br>
</div>And despite all those sync/isync you can still observe the timebase<b=
r>
going backward ? That sounds scary. However, at this stage all I can<br>
suggest is getting freescale folks to have a look, as this should really<br=
>
not happen. Maybe there&#39;s some setting with that specific SoC that is<b=
r>
missing or similar...<br>
<br>
Cheers,<br>
Ben.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; Thanks<br>
&gt; Gino<br>
&gt;<br>
&gt; 2010/3/25 Arnd Bergmann &lt;<a href=3D"mailto:arnd@arndb.de">arnd@arnd=
b.de</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Thursday 25 March 2010, Benjamin Herrenschmidt wrot=
e:<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wro=
te:<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0 =A0 =A0 =A0In my program, the value =
of the 64-bit time base<br>
&gt; =A0 =A0 =A0 =A0 register is<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; read out, and you will find the later value =
is even<br>
&gt; =A0 =A0 =A0 =A0 smaller than the<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; earlier value from the log =93log_timebase=
=94. While the<br>
&gt; =A0 =A0 =A0 =A0 kernel depends on<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; the accuracy of the timebase for the compens=
ation of the<br>
&gt; =A0 =A0 =A0 =A0 lost PIT<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; interrupt, the negative value between two co=
ntinual<br>
&gt; =A0 =A0 =A0 =A0 timebase reading<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; will bring to the jump of the jiffies. And t=
his timebase<br>
&gt; =A0 =A0 =A0 =A0 problem will<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; bring to the instability of the gettimeofday=
 system call.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0 =A0 =A0 =A0Do you have any idea abou=
t this problem, thanks<br>
&gt; =A0 =A0 =A0 =A0 for your any<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; advice. Attached is the code and log.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; This is a concern, it should definitely not happe=
n. What<br>
&gt; =A0 =A0 =A0 =A0 machine is<br>
&gt; =A0 =A0 =A0 =A0 &gt; that ? is the code compiled 32-bit or 64-bit ? Wh=
at kernel<br>
&gt; =A0 =A0 =A0 =A0 version ?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Arnd, any chance that could relate to the bug you=
&#39;ve been<br>
&gt; =A0 =A0 =A0 =A0 chasing on<br>
&gt; =A0 =A0 =A0 =A0 &gt; Cell ?<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 We&#39;re still busy with the problem analysis on Cell=
, waiting<br>
&gt; =A0 =A0 =A0 =A0 for a time<br>
&gt; =A0 =A0 =A0 =A0 slot to run the next test kernel. So far it seems like=
 the<br>
&gt; =A0 =A0 =A0 =A0 timebase<br>
&gt; =A0 =A0 =A0 =A0 is actually synchronized at a significant accuracy on =
QS22 to<br>
&gt; =A0 =A0 =A0 =A0 never<br>
&gt; =A0 =A0 =A0 =A0 cause this problem with correct code, however it is po=
ssible<br>
&gt; =A0 =A0 =A0 =A0 to<br>
&gt; =A0 =A0 =A0 =A0 observe incorrect timebase values on Cell whenever the=
 mftb<br>
&gt; =A0 =A0 =A0 =A0 instruction<br>
&gt; =A0 =A0 =A0 =A0 is not serialized with memory accesses, e.g. by using =
an isync<br>
&gt; =A0 =A0 =A0 =A0 in front<br>
&gt; =A0 =A0 =A0 =A0 of the mftb. On Power6 and other CPUs, that problem wi=
ll not<br>
&gt; =A0 =A0 =A0 =A0 happen.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Arnd<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br>

--0016e64c3ba2e6baef0482a9d611--

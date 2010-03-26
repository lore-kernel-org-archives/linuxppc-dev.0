Return-Path: <csdncannon@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id B1814B7CF6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 13:04:37 +1100 (EST)
Received: by pwj8 with SMTP id 8so6055839pwj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 19:04:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1269568527.8599.259.camel@pasglop>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
	<1269568527.8599.259.camel@pasglop>
Date: Fri, 26 Mar 2010 10:04:35 +0800
Message-ID: <43c137a81003251904ged9f17fof65e74bc766167d@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=001636b144abc085c20482aa9513
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636b144abc085c20482aa9513
Content-Type: multipart/alternative; boundary=001636b144abc085b60482aa9511

--001636b144abc085b60482aa9511
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Ben
       Attached is the previous failing one.

Thanks
Gino

2010/3/26 Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Fri, 2010-03-26 at 09:11 +0800, Csdncannon wrote:
> > After trying the new code with "isync" and unsigned long long
> > convertion, this problem doesn't happen(I tested for several minutes).
> > But the previous block of codes(lacking of isync) is borrowed from
> > kernel. And if this is a bug of kernel?
>
> There's an outstanding question about that. Some processors make mftb
> context synchronizing but it appears that it may not be the case for all
> of them.
>
> Thus indeed, we -might- need some isync's in some places, it's not
> totally clear to me though.
>
> Can you send the code that fails (without the isync) ? The one you sent
> did have them everywhere.
>
> Cheers,
> Ben.
>
> > Thanks
> > Gino
> >
> > 2010/3/26 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >         On Thu, 2010-03-25 at 23:00 +0800, Csdncannon wrote:
> >         > I am really sorry that the previously attached code is
> >         wrong, this one
> >         > "timebase.c" is the right one, and the "log_timebase" file
> >         is the
> >         > right log.
> >         >
> >         > We are using FreeScale PowerPc 8378, kernel 2.6.28 and
> >         compiled as
> >         > 32-bit.
> >
> >
> >         And despite all those sync/isync you can still observe the
> >         timebase
> >         going backward ? That sounds scary. However, at this stage all
> >         I can
> >         suggest is getting freescale folks to have a look, as this
> >         should really
> >         not happen. Maybe there's some setting with that specific SoC
> >         that is
> >         missing or similar...
> >
> >         Cheers,
> >         Ben.
> >
> >
> >         >
> >         > Thanks
> >         > Gino
> >         >
> >         > 2010/3/25 Arnd Bergmann <arnd@arndb.de>
> >         >         On Thursday 25 March 2010, Benjamin Herrenschmidt
> >         wrote:
> >         >         > On Thu, 2010-03-25 at 10:41 +0800, Csdncannon
> >         wrote:
> >         >         > >          In my program, the value of the 64-bit
> >         time base
> >         >         register is
> >         >         > > read out, and you will find the later value is
> >         even
> >         >         smaller than the
> >         >         > > earlier value from the log =93log_timebase=94. Wh=
ile
> >         the
> >         >         kernel depends on
> >         >         > > the accuracy of the timebase for the
> >         compensation of the
> >         >         lost PIT
> >         >         > > interrupt, the negative value between two
> >         continual
> >         >         timebase reading
> >         >         > > will bring to the jump of the jiffies. And this
> >         timebase
> >         >         problem will
> >         >         > > bring to the instability of the gettimeofday
> >         system call.
> >         >         > >
> >         >         > >          Do you have any idea about this
> >         problem, thanks
> >         >         for your any
> >         >         > > advice. Attached is the code and log.
> >         >         >
> >         >         > This is a concern, it should definitely not
> >         happen. What
> >         >         machine is
> >         >         > that ? is the code compiled 32-bit or 64-bit ?
> >         What kernel
> >         >         version ?
> >         >         >
> >         >         > Arnd, any chance that could relate to the bug
> >         you've been
> >         >         chasing on
> >         >         > Cell ?
> >         >
> >         >
> >         >         We're still busy with the problem analysis on Cell,
> >         waiting
> >         >         for a time
> >         >         slot to run the next test kernel. So far it seems
> >         like the
> >         >         timebase
> >         >         is actually synchronized at a significant accuracy
> >         on QS22 to
> >         >         never
> >         >         cause this problem with correct code, however it is
> >         possible
> >         >         to
> >         >         observe incorrect timebase values on Cell whenever
> >         the mftb
> >         >         instruction
> >         >         is not serialized with memory accesses, e.g. by
> >         using an isync
> >         >         in front
> >         >         of the mftb. On Power6 and other CPUs, that problem
> >         will not
> >         >         happen.
> >         >
> >         >                Arnd
> >         >
> >
> >
> >
> >
>
>
>

--001636b144abc085b60482aa9511
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Ben<br>=A0=A0=A0=A0=A0=A0 Attached is the previous failing one.<br><br>Than=
ks<br>Gino<br><br><div class=3D"gmail_quote">2010/3/26 Benjamin Herrenschmi=
dt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org">benh@k=
ernel.crashing.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Fri, 2010-03-26 at 09:11 +0800, Csdncannon wrote:<br>
&gt; After trying the new code with &quot;isync&quot; and unsigned long lon=
g<br>
&gt; convertion, this problem doesn&#39;t happen(I tested for several minut=
es).<br>
&gt; But the previous block of codes(lacking of isync) is borrowed from<br>
&gt; kernel. And if this is a bug of kernel?<br>
<br>
</div>There&#39;s an outstanding question about that. Some processors make =
mftb<br>
context synchronizing but it appears that it may not be the case for all<br=
>
of them.<br>
<br>
Thus indeed, we -might- need some isync&#39;s in some places, it&#39;s not<=
br>
totally clear to me though.<br>
<br>
Can you send the code that fails (without the isync) ? The one you sent<br>
did have them everywhere.<br>
<div><div></div><div class=3D"h5"><br>
Cheers,<br>
Ben.<br>
<br>
&gt; Thanks<br>
&gt; Gino<br>
&gt;<br>
&gt; 2010/3/26 Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.cra=
shing.org">benh@kernel.crashing.org</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Thu, 2010-03-25 at 23:00 +0800, Csdncannon wrote:<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; I am really sorry that the previously attached co=
de is<br>
&gt; =A0 =A0 =A0 =A0 wrong, this one<br>
&gt; =A0 =A0 =A0 =A0 &gt; &quot;timebase.c&quot; is the right one, and the =
&quot;log_timebase&quot; file<br>
&gt; =A0 =A0 =A0 =A0 is the<br>
&gt; =A0 =A0 =A0 =A0 &gt; right log.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; We are using FreeScale PowerPc 8378, kernel 2.6.2=
8 and<br>
&gt; =A0 =A0 =A0 =A0 compiled as<br>
&gt; =A0 =A0 =A0 =A0 &gt; 32-bit.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 And despite all those sync/isync you can still observe=
 the<br>
&gt; =A0 =A0 =A0 =A0 timebase<br>
&gt; =A0 =A0 =A0 =A0 going backward ? That sounds scary. However, at this s=
tage all<br>
&gt; =A0 =A0 =A0 =A0 I can<br>
&gt; =A0 =A0 =A0 =A0 suggest is getting freescale folks to have a look, as =
this<br>
&gt; =A0 =A0 =A0 =A0 should really<br>
&gt; =A0 =A0 =A0 =A0 not happen. Maybe there&#39;s some setting with that s=
pecific SoC<br>
&gt; =A0 =A0 =A0 =A0 that is<br>
&gt; =A0 =A0 =A0 =A0 missing or similar...<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Cheers,<br>
&gt; =A0 =A0 =A0 =A0 Ben.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks<br>
&gt; =A0 =A0 =A0 =A0 &gt; Gino<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 2010/3/25 Arnd Bergmann &lt;<a href=3D"mailto:arn=
d@arndb.de">arnd@arndb.de</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 On Thursday 25 March 2010, Benjam=
in Herrenschmidt<br>
&gt; =A0 =A0 =A0 =A0 wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; On Thu, 2010-03-25 at 10:41 =
+0800, Csdncannon<br>
&gt; =A0 =A0 =A0 =A0 wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0 =A0 =A0 =A0In m=
y program, the value of the 64-bit<br>
&gt; =A0 =A0 =A0 =A0 time base<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 register is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; read out, and you will =
find the later value is<br>
&gt; =A0 =A0 =A0 =A0 even<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 smaller than the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; earlier value from the =
log =93log_timebase=94. While<br>
&gt; =A0 =A0 =A0 =A0 the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 kernel depends on<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; the accuracy of the tim=
ebase for the<br>
&gt; =A0 =A0 =A0 =A0 compensation of the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 lost PIT<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; interrupt, the negative=
 value between two<br>
&gt; =A0 =A0 =A0 =A0 continual<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 timebase reading<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; will bring to the jump =
of the jiffies. And this<br>
&gt; =A0 =A0 =A0 =A0 timebase<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 problem will<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; bring to the instabilit=
y of the gettimeofday<br>
&gt; =A0 =A0 =A0 =A0 system call.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; =A0 =A0 =A0 =A0 =A0Do y=
ou have any idea about this<br>
&gt; =A0 =A0 =A0 =A0 problem, thanks<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 for your any<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; &gt; advice. Attached is the=
 code and log.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; This is a concern, it should=
 definitely not<br>
&gt; =A0 =A0 =A0 =A0 happen. What<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 machine is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; that ? is the code compiled =
32-bit or 64-bit ?<br>
&gt; =A0 =A0 =A0 =A0 What kernel<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 version ?<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Arnd, any chance that could =
relate to the bug<br>
&gt; =A0 =A0 =A0 =A0 you&#39;ve been<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 chasing on<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Cell ?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 We&#39;re still busy with the pro=
blem analysis on Cell,<br>
&gt; =A0 =A0 =A0 =A0 waiting<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 for a time<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 slot to run the next test kernel.=
 So far it seems<br>
&gt; =A0 =A0 =A0 =A0 like the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 timebase<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 is actually synchronized at a sig=
nificant accuracy<br>
&gt; =A0 =A0 =A0 =A0 on QS22 to<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 never<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 cause this problem with correct c=
ode, however it is<br>
&gt; =A0 =A0 =A0 =A0 possible<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 to<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 observe incorrect timebase values=
 on Cell whenever<br>
&gt; =A0 =A0 =A0 =A0 the mftb<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 instruction<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 is not serialized with memory acc=
esses, e.g. by<br>
&gt; =A0 =A0 =A0 =A0 using an isync<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 in front<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 of the mftb. On Power6 and other =
CPUs, that problem<br>
&gt; =A0 =A0 =A0 =A0 will not<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 happen.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Arnd<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br>

--001636b144abc085b60482aa9511--

--001636b144abc085c20482aa9513
Content-Type: application/octet-stream; name="timebase.c"
Content-Disposition: attachment; filename="timebase.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g78cn0ma0

LyogVFNDIHN5bmMgdGVzdA0KICoJCWJ5OiBqb2huIHN0dWx0eiAoam9obnN0dWxAdXMuaWJtLmNv
bSkNCiAqCQkoQykgQ29weXJpZ2h0IElCTSAyMDAzLCAyMDA1DQogKgkJTGljZW5zZWQgdW5kZXIg
dGhlIEdQTA0KICovDQoNCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3RpbWUu
aD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCg0KI2RlZmluZSBDQUxMU19QRVJfTE9PUCA2NA0KDQp2
b2xhdGlsZSB1bnNpZ25lZCBsb25nIGxvbmcgZ2V0VGltZUJhc2UoKQ0Kew0KCXVuc2lnbmVkIGxv
bmcgdXBwZXIsbG93ZXIsdXBwZXIyOw0KCWRvIHsNCgkJYXNtIHZvbGF0aWxlKCJzeW5jIjo6OiJt
ZW1vcnkiKTsNCgkJYXNtIHZvbGF0aWxlKCJtZnRidSAlMCIgOiAiPXIiICh1cHBlcikpOw0KCQlh
c20gdm9sYXRpbGUoInN5bmMiOjo6Im1lbW9yeSIpOw0KCQlhc20gdm9sYXRpbGUoIm1mdGJsICUw
IiA6ICI9ciIgKGxvd2VyKSk7DQoJCWFzbSB2b2xhdGlsZSgic3luYyI6OjoibWVtb3J5Iik7DQoJ
CWFzbSB2b2xhdGlsZSgibWZ0YnUgJTAiIDogIj1yIiAodXBwZXIyKSk7DQoJCWFzbSB2b2xhdGls
ZSgic3luYyI6OjoibWVtb3J5Iik7DQoJfXdoaWxlKHVwcGVyMiE9dXBwZXIpOw0KDQoJcmV0dXJu
ICh1cHBlcjw8MzIpfGxvd2VyOw0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQ0Kew0KCXZvbGF0aWxlIHVuc2lnbmVkIGxvbmcgbG9uZyBsaXN0W0NBTExTX1BFUl9MT09QXTsN
Cglib29sIGJhZFtDQUxMU19QRVJfTE9PUF07DQoJaW50IGksIGluY29uc2lzdGVudDsNCg0KDQoJ
LyogdGltZXN0YW1wIHN0YXJ0IG9mIHRlc3QgKi8NCglzeXN0ZW0oImRhdGUiKTsNCgl3aGlsZSgx
KXsNCgkJaW5jb25zaXN0ZW50ID0gMDsNCg0KCQkvKiBGaWxsIGxpc3QgKi8NCgkJZm9yKGk9MDsg
aSA8IENBTExTX1BFUl9MT09QOyBpKyspDQoJCQlsaXN0W2ldID0gZ2V0VGltZUJhc2UoKTsNCgkJ
DQoJCS8qIENoZWNrIGZvciBpbmNvbnNpc3RlbmNpZXMgKi8NCgkJZm9yKGk9MDsgaSA8IENBTExT
X1BFUl9MT09QLTE7IGkrKykNCgkJew0KCQkJaWYobGlzdFtpXSA+IGxpc3RbaSsxXSkNCgkJCXsN
CgkJCQlpbmNvbnNpc3RlbnQgPSBpKzE7DQoJCQkJYmFkW2ldID0gdHJ1ZTsNCgkJCX0NCgkJCWVs
c2V7DQoJCQkJYmFkW2ldID0gZmFsc2U7DQoJCQl9DQoJCX0NCg0KCQkvKiBkaXNwbGF5IGluY29u
c2lzdGVuY3kgKi8NCgkJaWYoaW5jb25zaXN0ZW50KXsNCgkJCWluY29uc2lzdGVudC0tOw0KCQkJ
Zm9yKGk9MDsgaSA8IENBTExTX1BFUl9MT09QOyBpKyspew0KCQkJCWlmKGJhZFtpXSA9PSB0cnVl
KQ0KCQkJCQlwcmludGYoIi0tLS0tLS0tLS0tLS0tLS0tLS0tXG4iKTsNCgkJCQlwcmludGYoIjB4
JWxseFxuIixsaXN0W2ldKTsNCgkJCQlpZihiYWRbaS0xXSA9PSB0cnVlICYmIGJhZFtpXSA9PSBm
YWxzZSApDQoJCQkJCXByaW50ZigiLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpOw0KCQkJfQ0KCQkJ
ZmZsdXNoKDApOw0KCQkJLyogdGltZXN0YW1wIGluY29uc2lzdGVuY3kqLw0KCQkJc3lzdGVtKCJk
YXRlIik7CQ0KCQl9DQoNCgl9DQoJcmV0dXJuIDA7DQp9DQoNCg==
--001636b144abc085c20482aa9513--

Return-Path: <csdncannon@gmail.com>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171]) by ozlabs.org (Postfix) with ESMTP id EDAF6B7C98
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 02:00:55 +1100 (EST)
Received: by pxi1 with SMTP id 1so3213568pxi.10
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 08:00:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201003251105.10033.arnd@arndb.de>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
Date: Thu, 25 Mar 2010 23:00:54 +0800
Message-ID: <43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary=0016e649ba6c38d82d0482a1500a
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e649ba6c38d82d0482a1500a
Content-Type: multipart/alternative; boundary=0016e649ba6c38d8250482a15008

--0016e649ba6c38d8250482a15008
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am really sorry that the previously attached code is wrong, this one
"timebase.c" is the right one, and the "log_timebase" file is the right log=
.

We are using FreeScale PowerPc 8378, kernel 2.6.28 and compiled as 32-bit.


Thanks
Gino

2010/3/25 Arnd Bergmann <arnd@arndb.de>

> On Thursday 25 March 2010, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wrote:
> > >          In my program, the value of the 64-bit time base register is
> > > read out, and you will find the later value is even smaller than the
> > > earlier value from the log =93log_timebase=94. While the kernel depen=
ds on
> > > the accuracy of the timebase for the compensation of the lost PIT
> > > interrupt, the negative value between two continual timebase reading
> > > will bring to the jump of the jiffies. And this timebase problem will
> > > bring to the instability of the gettimeofday system call.
> > >
> > >          Do you have any idea about this problem, thanks for your any
> > > advice. Attached is the code and log.
> >
> > This is a concern, it should definitely not happen. What machine is
> > that ? is the code compiled 32-bit or 64-bit ? What kernel version ?
> >
> > Arnd, any chance that could relate to the bug you've been chasing on
> > Cell ?
>
> We're still busy with the problem analysis on Cell, waiting for a time
> slot to run the next test kernel. So far it seems like the timebase
> is actually synchronized at a significant accuracy on QS22 to never
> cause this problem with correct code, however it is possible to
> observe incorrect timebase values on Cell whenever the mftb instruction
> is not serialized with memory accesses, e.g. by using an isync in front
> of the mftb. On Power6 and other CPUs, that problem will not happen.
>
>        Arnd
>

--0016e649ba6c38d8250482a15008
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I am really sorry that the previously attached code is wrong, this one &quo=
t;timebase.c&quot; is the right one, and the &quot;log_timebase&quot; file =
is the right log.<br><br>We are using FreeScale PowerPc 8378, kernel 2.6.28=
 and compiled as 32-bit.<br>
<br><br>Thanks<br>Gino<br><br><div class=3D"gmail_quote">
2010/3/25 Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D"mailto:arnd@arndb.=
de" target=3D"_blank">arnd@arndb.de</a>&gt;</span><br><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">

<div>On Thursday 25 March 2010, Benjamin Herrenschmidt wrote:<br>
&gt; On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wrote:<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0In my program, the value of the 64-bit time ba=
se register is<br>
&gt; &gt; read out, and you will find the later value is even smaller than =
the<br>
&gt; &gt; earlier value from the log =93log_timebase=94. While the kernel d=
epends on<br>
&gt; &gt; the accuracy of the timebase for the compensation of the lost PIT=
<br>
&gt; &gt; interrupt, the negative value between two continual timebase read=
ing<br>
&gt; &gt; will bring to the jump of the jiffies. And this timebase problem =
will<br>
&gt; &gt; bring to the instability of the gettimeofday system call.<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0Do you have any idea about this problem, thank=
s for your any<br>
&gt; &gt; advice. Attached is the code and log.<br>
&gt;<br>
&gt; This is a concern, it should definitely not happen. What machine is<br=
>
&gt; that ? is the code compiled 32-bit or 64-bit ? What kernel version ?<b=
r>
&gt;<br>
&gt; Arnd, any chance that could relate to the bug you&#39;ve been chasing =
on<br>
&gt; Cell ?<br>
<br>
</div>We&#39;re still busy with the problem analysis on Cell, waiting for a=
 time<br>
slot to run the next test kernel. So far it seems like the timebase<br>
is actually synchronized at a significant accuracy on QS22 to never<br>
cause this problem with correct code, however it is possible to<br>
observe incorrect timebase values on Cell whenever the mftb instruction<br>
is not serialized with memory accesses, e.g. by using an isync in front<br>
of the mftb. On Power6 and other CPUs, that problem will not happen.<br>
<font color=3D"#888888"><br>
 =A0 =A0 =A0 =A0Arnd<br>
</font></blockquote></div><br>

--0016e649ba6c38d8250482a15008--

--0016e649ba6c38d82d0482a1500a
Content-Type: application/octet-stream; name="timebase.c"
Content-Disposition: attachment; filename="timebase.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g77ov5z60

LyogVFNDIHN5bmMgdGVzdA0KICoJCWJ5OiBqb2huIHN0dWx0eiAoam9obnN0dWxAdXMuaWJtLmNv
bSkNCiAqCQkoQykgQ29weXJpZ2h0IElCTSAyMDAzLCAyMDA1DQogKgkJTGljZW5zZWQgdW5kZXIg
dGhlIEdQTA0KICovDQoNCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3RpbWUu
aD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCg0KI2RlZmluZSBDQUxMU19QRVJfTE9PUCA2NA0KDQp2
b2xhdGlsZSB1bnNpZ25lZCBsb25nIGxvbmcgZ2V0VGltZUJhc2UoKQ0Kew0KCXVuc2lnbmVkIGxv
bmcgdXBwZXIsbG93ZXIsdXBwZXIyOw0KCWRvIHsNCgkJYXNtIHZvbGF0aWxlKCJzeW5jOyBpc3lu
YyI6OjoibWVtb3J5Iik7DQoJCWFzbSB2b2xhdGlsZSgibWZ0YnUgJTAiIDogIj1yIiAodXBwZXIp
KTsNCgkJYXNtIHZvbGF0aWxlKCJzeW5jOyBpc3luYyI6OjoibWVtb3J5Iik7DQoJCWFzbSB2b2xh
dGlsZSgibWZ0YmwgJTAiIDogIj1yIiAobG93ZXIpKTsNCgkJYXNtIHZvbGF0aWxlKCJzeW5jOyBp
c3luYyI6OjoibWVtb3J5Iik7DQoJCWFzbSB2b2xhdGlsZSgibWZ0YnUgJTAiIDogIj1yIiAodXBw
ZXIyKSk7DQoJCWFzbSB2b2xhdGlsZSgic3luYzsgaXN5bmMiOjo6Im1lbW9yeSIpOw0KCX13aGls
ZSh1cHBlcjIhPXVwcGVyKTsNCg0KCXJldHVybiAodXBwZXI8PDMyKXxsb3dlcjsNCn0NCg0KaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCnsNCgl2b2xhdGlsZSB1bnNpZ25lZCBsb25n
IGxvbmcgbGlzdFtDQUxMU19QRVJfTE9PUF07DQoJYm9vbCBiYWRbQ0FMTFNfUEVSX0xPT1BdOw0K
CWludCBpLCBpbmNvbnNpc3RlbnQ7DQoNCg0KCS8qIHRpbWVzdGFtcCBzdGFydCBvZiB0ZXN0ICov
DQoJc3lzdGVtKCJkYXRlIik7DQoJd2hpbGUoMSl7DQoJCWluY29uc2lzdGVudCA9IDA7DQoNCgkJ
LyogRmlsbCBsaXN0ICovDQoJCWZvcihpPTA7IGkgPCBDQUxMU19QRVJfTE9PUDsgaSsrKQ0KCQkJ
bGlzdFtpXSA9IGdldFRpbWVCYXNlKCk7DQoJCQ0KCQkvKiBDaGVjayBmb3IgaW5jb25zaXN0ZW5j
aWVzICovDQoJCWZvcihpPTA7IGkgPCBDQUxMU19QRVJfTE9PUC0xOyBpKyspDQoJCXsNCgkJCWlm
KGxpc3RbaV0gPiBsaXN0W2krMV0pDQoJCQl7DQoJCQkJaW5jb25zaXN0ZW50ID0gaSsxOw0KCQkJ
CWJhZFtpXSA9IHRydWU7DQoJCQl9DQoJCQllbHNlew0KCQkJCWJhZFtpXSA9IGZhbHNlOw0KCQkJ
fQ0KCQl9DQoNCgkJLyogZGlzcGxheSBpbmNvbnNpc3RlbmN5ICovDQoJCWlmKGluY29uc2lzdGVu
dCl7DQoJCQlpbmNvbnNpc3RlbnQtLTsNCgkJCWZvcihpPTA7IGkgPCBDQUxMU19QRVJfTE9PUDsg
aSsrKXsNCgkJCQlpZihiYWRbaV0gPT0gdHJ1ZSkNCgkJCQkJcHJpbnRmKCItLS0tLS0tLS0tLS0t
LS0tLS0tLVxuIik7DQoJCQkJcHJpbnRmKCIweCVsbHhcbiIsbGlzdFtpXSk7DQoJCQkJaWYoYmFk
W2ktMV0gPT0gdHJ1ZSAmJiBiYWRbaV0gPT0gZmFsc2UgKQ0KCQkJCQlwcmludGYoIi0tLS0tLS0t
LS0tLS0tLS0tLS0tXG4iKTsNCgkJCX0NCgkJCWZmbHVzaCgwKTsNCgkJCS8qIHRpbWVzdGFtcCBp
bmNvbnNpc3RlbmN5Ki8NCgkJCXN5c3RlbSgiZGF0ZSIpOwkNCgkJfQ0KDQoJfQ0KCXJldHVybiAw
Ow0KfQ0KDQo=
--0016e649ba6c38d82d0482a1500a--

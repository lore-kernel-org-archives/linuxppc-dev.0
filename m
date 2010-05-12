Return-Path: <muvarov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 981CEB7DBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 16:31:34 +1000 (EST)
Received: by wyf19 with SMTP id 19so777800wyf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 23:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BEA2375.7040802@nerdbynature.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA2375.7040802@nerdbynature.de>
Date: Wed, 12 May 2010 10:31:26 +0400
Message-ID: <AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
From: Maxim Uvarov <muvarov@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: multipart/alternative; boundary=001485f44ff89c260904865fca77
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f44ff89c260904865fca77
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

2010/5/12 Christian Kujau <lists@nerdbynature.de>

> Maxim Uvarov wrote on 2010-05-11 10:47 :
> > This patch is required in case if you are using new toolchains.
>
> I'm on Debian/stable (binutils 2.18, gcc 4.3.2), so I applied your patche=
s
> to the latest -git checkout:
>
> First, compilation fails with:
>
> cc1: warnings being treated as errors
> kexec/arch/ppc/kexec-ppc.c: In function =91get_base_ranges=92:
> kexec/arch/ppc/kexec-ppc.c:258: error: value computed is not used
> make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1
>
> Somehow a "-" hyphen made it into one of the functions:
>
> > --- a/kexec/arch/ppc/kexec-ppc.c
> > +++ b/kexec/arch/ppc/kexec-ppc.c
> [...]
> >                       if (local_memory_ranges >=3D max_memory_ranges) {
> > -                             fclose(file);
> > -                             break;
> > +                             if (realloc_memory_ranges() < 0){
> > +     -                               fclose(file);
>
> Oh, I sent this patch twice with stg -a by mistake. And second version ha=
s
"-". I will fix and resend patches.

>
> Removing this, gets me further, until:
>
>
> purgatory/arch/ppc/crt.o: In function `__lshrdi3':
> (.text+0xf0): multiple definition of `__lshrdi3'
> purgatory/arch/ppc/misc.o:(.text+0x50): first defined here
> collect2: ld returned 1 exit status
> make: *** [purgatory/purgatory.ro] Error 1
>
> And has been defined in purgatory/arch/ppc/crt.S and
> ./purgatory/arch/ppc/misc.S. Removing it from e.g. crt.S
> makes it compile, I have not tested it yet, though :-)
>

Yes, that is expected result for old tool chains. New tool chains (from cod=
e
sourcery )  need this crt.S.
I think we can have --with-oldtoolchain option to configure to point to old
tool chains. (or even rename it to --with-crts,
I don't know what is better.)

>
> Thanks,
> Christian.
>
> PS: Where is -Werror defined? I could not find it anywhere in the kexec
>    source (execpt in arch/mips)...
> --
>

This -Werror came from mips. kexec/arch/mips/Makefile. It is already remove=
d
in the git. We already saw this problem.




> make bzImage, not war
>



--=20
Best regards,
Maxim Uvarov

--001485f44ff89c260904865fca77
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/5/12 Christian Kujau <span dir=3D"l=
tr">&lt;<a href=3D"mailto:lists@nerdbynature.de">lists@nerdbynature.de</a>&=
gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Maxim Uvarov wrote on 2010-05-11 10:47 :<br>
<div class=3D"im">&gt; This patch is required in case if you are using new =
toolchains.<br>
<br>
</div>I&#39;m on Debian/stable (binutils 2.18, gcc 4.3.2), so I applied you=
r patches<br>
to the latest -git checkout:<br>
<br>
First, compilation fails with:<br>
<br>
cc1: warnings being treated as errors<br>
kexec/arch/ppc/kexec-ppc.c: In function =91get_base_ranges=92:<br>
kexec/arch/ppc/kexec-ppc.c:258: error: value computed is not used<br>
make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1<br>
<br>
Somehow a &quot;-&quot; hyphen made it into one of the functions:<br>
<br>
&gt; --- a/kexec/arch/ppc/kexec-ppc.c<br>
<div class=3D"im">&gt; +++ b/kexec/arch/ppc/kexec-ppc.c<br>
</div>[...]<br>
<div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loca=
l_memory_ranges &gt;=3D max_memory_ranges) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclose(file)=
;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (realloc_=
memory_ranges() &lt; 0){<br>
&gt; + =A0 =A0 - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fclose(file);<br>
<br></div></blockquote><div>Oh, I sent this patch twice with stg -a by mist=
ake. And second version has &quot;-&quot;. I will fix and resend patches.<b=
r></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid r=
gb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">
<br>
</div>Removing this, gets me further, until:<br>
<br>
<br>
purgatory/arch/ppc/crt.o: In function `__lshrdi3&#39;:<br>
(.text+0xf0): multiple definition of `__lshrdi3&#39;<br>
purgatory/arch/ppc/misc.o:(.text+0x50): first defined here<br>
collect2: ld returned 1 exit status<br>
make: *** [purgatory/<a href=3D"http://purgatory.ro" target=3D"_blank">purg=
atory.ro</a>] Error 1<br>
<br>
And has been defined in purgatory/arch/ppc/crt.S and<br>
./purgatory/arch/ppc/misc.S. Removing it from e.g. crt.S<br>
makes it compile, I have not tested it yet, though :-)<br></blockquote><div=
><br>Yes, that is expected result for old tool chains. New tool chains (fro=
m code sourcery )=A0 need this crt.S.<br>I think we can have --with-oldtool=
chain option to configure to point to old tool chains. (or even rename it t=
o --with-crts,<br>
I don&#39;t know what is better.)<br></div><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
<br>
Thanks,<br>
Christian.<br>
<br>
PS: Where is -Werror defined? I could not find it anywhere in the kexec<br>
 =A0 =A0source (execpt in arch/mips)...<br>
<font color=3D"#888888">--<br></font></blockquote><div><br>This -Werror cam=
e from mips. kexec/arch/mips/Makefile. It is already removed in the git. We=
 already saw this problem.<br><br><br>=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
<font color=3D"#888888">
make bzImage, not war<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br=
>Maxim Uvarov<br>

--001485f44ff89c260904865fca77--

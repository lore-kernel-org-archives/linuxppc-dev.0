Return-Path: <muvarov@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id 10A0EB7D53
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 17:46:28 +1000 (EST)
Received: by wwb34 with SMTP id 34so3173622wwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 05 May 2010 00:46:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100505033928.GC2612@verge.net.au>
References: <15110.1273024133@neuling.org>
	<20100505023316.GF13035@verge.net.au> <14281.1273030521@neuling.org>
	<20100505033928.GC2612@verge.net.au>
Date: Wed, 5 May 2010 11:46:25 +0400
Message-ID: <q2y572af9171005050046v929117e8ya5b330a1a0c9c298@mail.gmail.com>
Subject: Re: [PATCH] kexec-tools, ppc64: fix build error on ppc64
From: Maxim Uvarov <muvarov@gmail.com>
To: Simon Horman <horms@verge.net.au>
Content-Type: multipart/alternative; boundary=001485f1e31aea759e0485d4058d
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f1e31aea759e0485d4058d
Content-Type: text/plain; charset=ISO-8859-1

2010/5/5 Simon Horman <horms@verge.net.au>

> On Wed, May 05, 2010 at 01:35:21PM +1000, Michael Neuling wrote:
> >
> >
> > In message <20100505023316.GF13035@verge.net.au> you wrote:
> > > On Wed, May 05, 2010 at 11:48:53AM +1000, Michael Neuling wrote:
> > > > 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> > > > improvements" broke pp64 as it turned on -Werror for all archs.
> > > >
> > > > This fixes the warning and hence ppc64 building.
> > >
> > > Thanks.
> > >
> > > While I'm very much in favour of using -Werror for testing
> > > and these kind of patches are great, I think that -Werror
> > > by default is rather silly. We can't control what will be
> > > a warning in the future and sometimes fixing warnings isn't
> > > appropriate - for instance there are warnings in fs2dt.c at
> > > the moment, that is currently considered an upstream problem.
> > >
> > > In short, this patch is great. But I plan to also remove -Werror
> > > as the default now that its been brought to my attention.
> >
> > Cool.  My second patch should do this for all but MIPS.
>
> Unfortunately the second patch breaks make tarball.
> For now I have committed the following:
>
> From 76beff0507360f3001e23c9b4c765ef56384d5d5 Mon Sep 17 00:00:00 2001
> From: Simon Horman <horms@verge.net.au>
> Date: Wed, 5 May 2010 13:33:21 +1000
> Subject: [PATCH] build: Don't modify CFLAGS in kexec/arch/mips/Makefile
>
> Revert this portion of recent MIPS changes as it actually effects the
> CFLAGS for all architectures.  Moreover I'm somewhat dubious about
> defaulting to -Werror for any architecture.
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/arch/mips/Makefile |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
> index 831b263..03bdb9a 100644
> --- a/kexec/arch/mips/Makefile
> +++ b/kexec/arch/mips/Makefile
> @@ -14,5 +14,3 @@ dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)
>             \
>        kexec/arch/mips/kexec-mips.h                                    \
>        kexec/arch/mips/crashdump-mips.h                                \
>        kexec/arch/mips/include/arch/options.h
> -
> -CFLAGS +=-Wall -Werror
> --
> 1.7.1
>
>
Plan was to have -Werror only for mips. Thanks for fixes.

-- 
Best regards,
Maxim Uvarov

--001485f1e31aea759e0485d4058d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/5/5 Simon Horman <span dir=3D"ltr">=
&lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span>=
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, May 05, 2010 at 01:35:21PM +1000, Michael Neuling=
 wrote:<br>
&gt;<br>
&gt;<br>
&gt; In message &lt;<a href=3D"mailto:20100505023316.GF13035@verge.net.au">=
20100505023316.GF13035@verge.net.au</a>&gt; you wrote:<br>
&gt; &gt; On Wed, May 05, 2010 at 11:48:53AM +1000, Michael Neuling wrote:<=
br>
&gt; &gt; &gt; 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 &quot;some kexec MI=
PS<br>
&gt; &gt; &gt; improvements&quot; broke pp64 as it turned on -Werror for al=
l archs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This fixes the warning and hence ppc64 building.<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt; While I&#39;m very much in favour of using -Werror for testing<br=
>
&gt; &gt; and these kind of patches are great, I think that -Werror<br>
&gt; &gt; by default is rather silly. We can&#39;t control what will be<br>
&gt; &gt; a warning in the future and sometimes fixing warnings isn&#39;t<b=
r>
&gt; &gt; appropriate - for instance there are warnings in fs2dt.c at<br>
&gt; &gt; the moment, that is currently considered an upstream problem.<br>
&gt; &gt;<br>
&gt; &gt; In short, this patch is great. But I plan to also remove -Werror<=
br>
&gt; &gt; as the default now that its been brought to my attention.<br>
&gt;<br>
&gt; Cool. =A0My second patch should do this for all but MIPS.<br>
<br>
</div>Unfortunately the second patch breaks make tarball.<br>
For now I have committed the following:<br>
<br>
>From 76beff0507360f3001e23c9b4c765ef56384d5d5 Mon Sep 17 00:00:00 2001<br>
From: Simon Horman &lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.ne=
t.au</a>&gt;<br>
Date: Wed, 5 May 2010 13:33:21 +1000<br>
Subject: [PATCH] build: Don&#39;t modify CFLAGS in kexec/arch/mips/Makefile=
<br>
<br>
Revert this portion of recent MIPS changes as it actually effects the<br>
CFLAGS for all architectures. =A0Moreover I&#39;m somewhat dubious about<br=
>
defaulting to -Werror for any architecture.<br>
<br>
Signed-off-by: Simon Horman &lt;<a href=3D"mailto:horms@verge.net.au">horms=
@verge.net.au</a>&gt;<br>
---<br>
=A0kexec/arch/mips/Makefile | =A0 =A02 --<br>
=A01 files changed, 0 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile<br>
index 831b263..03bdb9a 100644<br>
--- a/kexec/arch/mips/Makefile<br>
+++ b/kexec/arch/mips/Makefile<br>
@@ -14,5 +14,3 @@ dist +=3D kexec/arch/mips/Makefile $(mips_KEXEC_SRCS) =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0kexec/arch/mips/kexec-mips.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
 =A0 =A0 =A0 =A0kexec/arch/mips/crashdump-mips.h =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
 =A0 =A0 =A0 =A0kexec/arch/mips/include/arch/options.h<br>
-<br>
-CFLAGS +=3D-Wall -Werror<br>
<font color=3D"#888888">--<br>
1.7.1<br>
<br>
</font></blockquote></div><br>Plan was to have -Werror only for mips. Thank=
s for fixes.<br clear=3D"all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

--001485f1e31aea759e0485d4058d--

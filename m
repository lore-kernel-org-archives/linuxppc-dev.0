Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B84A71A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:28:40 +1100 (AEDT)
Received: by mail-qk0-x241.google.com with SMTP id e124so453713qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 04:28:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455707394.4450.4.camel@ellerman.id.au>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
 <1455685668-30198-2-git-send-email-mikey@neuling.org>
 <1455707394.4450.4.camel@ellerman.id.au>
Date: Wed, 17 Feb 2016 23:28:36 +1100
Message-ID: <CAOSf1CHJKbKW7ZRcHGfOr92+_8bwPPykS2RaVRycdgCkKZQBow@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Add POWER9 cputable entry
From: oliver <oohall@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001a114a8524a1b1e9052bf663bb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114a8524a1b1e9052bf663bb
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 17, 2016 at 10:09 PM, Michael Ellerman <mpe@ellerman.id.au>
wrote:

> On Wed, 2016-02-17 at 16:07 +1100, Michael Neuling wrote:
>
> > Add a cputable entry for POWER9.  More code is required to actually
> > boot and run on a POWER9 but this gets the base piece in which we can
> > start building on.
> >
> > Copies over from POWER8 except for:
> > - Adds a new CPU_FTR_ARCH_30 bit to start hanging new architecture
>
> ARCH thirty?
>
> Would CPU_FTR_ARCH_3 read better?
>
> Or CPU_FTR_ARCH_3_00 ?


The user visible version flags all have the pattern ARCH_X_XX while the
in-kernel flags use ARCH_XXX. It should probably be CPU_FTR_ARCH_300 for
consistency with the other kernel flags.

> +#define COMMON_USER_POWER9   (COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06
> |\
> > +                              PPC_FEATURE_SMT |
> PPC_FEATURE_ICACHE_SNOOP | \
> > +                              PPC_FEATURE_TRUE_LE | \
> > +                              PPC_FEATURE_PSERIES_PERFMON_COMPAT)
>
> That looks like it's == COMMON_USER_POWER8.
>
> > +#define COMMON_USER2_POWER9  (PPC_FEATURE2_ARCH_2_07 | \
> > +                              PPC_FEATURE2_HTM_COMP | \
> > +                              PPC_FEATURE2_HTM_NOSC_COMP | \
> > +                              PPC_FEATURE2_DSCR | \
> > +                              PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
> > +                              PPC_FEATURE2_VEC_CRYPTO | \
> > +                              PPC_FEATURE2_ARCH_3_00 | \
> > +                              PPC_FEATURE2_HAS_IEEE128)
>
> And this could be COMMON_USER_POWER8 + ARCH_3 + HAS_IEEE128 I think?


It could be, but similarly the POWER8 flags could also be POWER7 + some. I
think they're separate so flags can be easily removed if need be, but I'm
not sure how useful that is.

--001a114a8524a1b1e9052bf663bb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 17, 2016 at 10:09 PM, Michael Ellerman <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mpe@ellerman.id.au" target=3D"_blank">mpe@ellerman.id.au</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, =
2016-02-17 at 16:07 +1100, Michael Neuling wrote:<br>
<br>
&gt; Add a cputable entry for POWER9.=C2=A0 More code is required to actual=
ly<br>
&gt; boot and run on a POWER9 but this gets the base piece in which we can<=
br>
&gt; start building on.<br>
&gt;<br>
&gt; Copies over from POWER8 except for:<br>
&gt; - Adds a new CPU_FTR_ARCH_30 bit to start hanging new architecture<br>
<br>
</span>ARCH thirty?<br>
<br>
Would CPU_FTR_ARCH_3 read better?<br>
<br>
Or CPU_FTR_ARCH_3_00 ?</blockquote><div><br></div><div>The user visible ver=
sion flags all have the pattern ARCH_X_XX while the in-kernel flags use ARC=
H_XXX. It should probably be CPU_FTR_ARCH_300 for consistency with the othe=
r kernel flags.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><di=
v class=3D"h5">&gt; +#define COMMON_USER_POWER9=C2=A0 =C2=A0(COMMON_USER_PP=
C64 | PPC_FEATURE_ARCH_2_06 |\<br></div></div><div><div class=3D"h5">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SN=
OOP | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE_TRUE_LE | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE_PSERIES_PERFMON_COMPAT)<br>
<br>
</div></div>That looks like it&#39;s =3D=3D COMMON_USER_POWER8.<br>
<span class=3D""><br>
&gt; +#define COMMON_USER2_POWER9=C2=A0 (PPC_FEATURE2_ARCH_2_07 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_HTM_COMP | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_HTM_NOSC_COMP | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_DSCR | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | =
\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_VEC_CRYPTO | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_ARCH_3_00 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PPC_FEATURE2_HAS_IEEE128)<br>
<br>
</span>And this could be COMMON_USER_POWER8 + ARCH_3 + HAS_IEEE128 I think?=
</blockquote><div><br></div><div>It could be, but similarly the POWER8 flag=
s could also be POWER7 + some. I think they&#39;re separate so flags can be=
 easily removed if need be, but I&#39;m not sure how useful that is.</div><=
/div></div></div>

--001a114a8524a1b1e9052bf663bb--

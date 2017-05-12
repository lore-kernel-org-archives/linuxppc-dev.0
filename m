Return-Path: <npiggin@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPR8x3204zDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 20:31:29 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id d127so10124065wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 03:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgq2bvcb.fsf@concordia.ellerman.id.au>
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-2-npiggin@gmail.com>
 <87lgq2bvcb.fsf@concordia.ellerman.id.au>
From: Nick Piggin <npiggin@gmail.com>
Date: Fri, 12 May 2017 20:31:25 +1000
Message-ID: <CAPa8GCCZu5YuuYEzXeJp6QU_1sCFK6=TBrCKk9N8Ypi1e=ZJww@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/32: tlbie provide L operand explicitly
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <oss@buserror.net>
Content-Type: multipart/alternative; boundary="001a1147064c1e41bd054f51356b"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1147064c1e41bd054f51356b
Content-Type: text/plain; charset="UTF-8"

On 12 May 2017 at 13:35, Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > The single-operand form of tlbie used to be accepted as the second
> > operand (L) being implicitly 0. Newer binutils reject this.
> >
> > Change remaining single-op tlbie instructions to have explicit 0
> > second argument.
>
> Do old(er) binutils accept the two operand version?
>

They should going back to 2002, but now I dig further into it, the problem
is
my cross compiler that is not setting the cpu / ISA version correctly. So
powerpc32 CPUs with current binutils tlbie second parameter is still
optional
AFAIKS.

So this patch is not required.

Thanks,
Nick

--001a1147064c1e41bd054f51356b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 12 May 2017 at 13:35, Michael Ellerman <span dir=3D"ltr=
">&lt;<a href=3D"mailto:mpe@ellerman.id.au" target=3D"_blank">mpe@ellerman.=
id.au</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Nicholas Piggin &=
lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt; writes:<b=
r>
<br>
&gt; The single-operand form of tlbie used to be accepted as the second<br>
&gt; operand (L) being implicitly 0. Newer binutils reject this.<br>
&gt;<br>
&gt; Change remaining single-op tlbie instructions to have explicit 0<br>
&gt; second argument.<br>
<br>
</span>Do old(er) binutils accept the two operand version?<br></blockquote>=
<div><br></div><div>They should going back to 2002, but now I dig further i=
nto it, the problem is<br>my cross compiler that is not setting the cpu / I=
SA version correctly. So<br>powerpc32 CPUs with current binutils tlbie seco=
nd parameter is still optional<br></div><div>AFAIKS.<br><br></div><div>So t=
his patch is not required.<br></div><div><br></div><div>Thanks,<br></div><d=
iv>Nick<br></div><div><br></div></div></div></div>

--001a1147064c1e41bd054f51356b--

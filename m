Return-Path: <luto@amacapital.net>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49AC71A001A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 02:53:39 +1000 (EST)
Received: by mail-la0-f51.google.com with SMTP id el20so3032434lab.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 09:53:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53C8F4DF.8020103@nod.at>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
 <20140718101416.GB1818@arm.com> <53C8F4DF.8020103@nod.at>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 18 Jul 2014 09:53:14 -0700
Message-ID: <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
To: Richard Weinberger <richard@nod.at>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/alternative; boundary=001a11c3f90a12d5e104fe7a9985
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@mentor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c3f90a12d5e104fe7a9985
Content-Type: text/plain; charset=UTF-8

On Jul 18, 2014 3:20 AM, "Richard Weinberger" <richard@nod.at> wrote:
>
> Am 18.07.2014 12:14, schrieb Will Deacon:
> > On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:
> >> On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net>
wrote:
> >>> The core mm code will provide a default gate area based on
> >>> FIXADDR_USER_START and FIXADDR_USER_END if
> >>> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
> >>>
> >>> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
> >>> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
> >>> 32-bit UML, and x86_64 have gate areas, but they have their own
> >>> implementations.
> >>>
> >>> This gets rid of the default and moves the code into ia64.
> >>>
> >>> This should save some code on architectures without a gate area: it's
> >>> now possible to inline the gate_area functions in the default case.
> >>
> >> Can one of you pull this somewhere?  Otherwise I can put it somewhere
> >> stable and ask for -next inclusion, but that seems like overkill for a
> >> single patch.
>
> For the um bits:
> Acked-by: Richard Weinberger <richard@nod.at>
>
> > I'd be happy to take the arm64 part, but it doesn't feel right for mm/*
> > changes (or changes to other archs) to go via our tree.
> >
> > I'm not sure what the best approach is if you want to send this via a
single
> > tree. Maybe you could ask akpm nicely?
>
> Going though Andrew's tree sounds sane to me.

Splitting this will be annoying: I'd probably have to add a flag asking for
the new behavior, update all the arches, then remove the flag.  The chance
of screwing up bisectability in the process seems pretty high.  This seems
like overkill for a patch that mostly deletes code.

Akpm, can you take this?

--Andy

>
> Thanks,
> //richard

--001a11c3f90a12d5e104fe7a9985
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr"><br>
On Jul 18, 2014 3:20 AM, &quot;Richard Weinberger&quot; &lt;<a href=3D"mail=
to:richard@nod.at" target=3D"_blank">richard@nod.at</a>&gt; wrote:<br>
&gt;<br>
&gt; Am 18.07.2014 12:14, schrieb Will Deacon:<br>
&gt; &gt; On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:<=
br>
&gt; &gt;&gt; On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski &lt;<a href=
=3D"mailto:luto@amacapital.net" target=3D"_blank">luto@amacapital.net</a>&g=
t; wrote:<br>
&gt; &gt;&gt;&gt; The core mm code will provide a default gate area based o=
n<br>
&gt; &gt;&gt;&gt; FIXADDR_USER_START and FIXADDR_USER_END if<br>
&gt; &gt;&gt;&gt; !defined(__HAVE_ARCH_GATE_AREA) &amp;&amp; defined(AT_SYS=
INFO_EHDR).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This default is only useful for ia64. =C2=A0arm64, ppc, s=
390, sh, tile,<br>
&gt; &gt;&gt;&gt; 64-bit UML, and x86_32 have their own code just to disabl=
e it. =C2=A0arm,<br>
&gt; &gt;&gt;&gt; 32-bit UML, and x86_64 have gate areas, but they have the=
ir own<br>
&gt; &gt;&gt;&gt; implementations.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This gets rid of the default and moves the code into ia64=
.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This should save some code on architectures without a gat=
e area: it&#39;s<br>
&gt; &gt;&gt;&gt; now possible to inline the gate_area functions in the def=
ault case.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Can one of you pull this somewhere? =C2=A0Otherwise I can put=
 it somewhere<br>
&gt; &gt;&gt; stable and ask for -next inclusion, but that seems like overk=
ill for a<br>
&gt; &gt;&gt; single patch.<br>
&gt;<br>
&gt; For the um bits:<br>
&gt; Acked-by: Richard Weinberger &lt;<a href=3D"mailto:richard@nod.at" tar=
get=3D"_blank">richard@nod.at</a>&gt;<br>
&gt;<br>
&gt; &gt; I&#39;d be happy to take the arm64 part, but it doesn&#39;t feel =
right for mm/*<br>
&gt; &gt; changes (or changes to other archs) to go via our tree.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m not sure what the best approach is if you want to send th=
is via a single<br>
&gt; &gt; tree. Maybe you could ask akpm nicely?<br>
&gt;<br>
&gt; Going though Andrew&#39;s tree sounds sane to me.</p>
<p dir=3D"ltr">Splitting this will be annoying: I&#39;d probably have to ad=
d a flag asking for the new behavior, update all the arches, then remove th=
e flag.=C2=A0 The chance of screwing up bisectability in the process seems =
pretty high.=C2=A0 This seems like overkill for a patch that mostly deletes=
 code.</p>




<p dir=3D"ltr">Akpm, can you take this?</p>
<p dir=3D"ltr">--Andy</p>
<p dir=3D"ltr">&gt;<br>
&gt; Thanks,<br>
&gt; //richard<br>
</p>
</div>

--001a11c3f90a12d5e104fe7a9985--

Return-Path: <Paul.Burton@mips.com>
Received: from 9pmail.ess.barracuda.com (9pmail.ess.barracuda.com
 [64.235.150.224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419HRC4rKJzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:03:01 +1000 (AEST)
Date: Tue, 19 Jun 2018 12:02:25 -0700
From: Paul Burton <paul.burton@mips.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Arnd Bergmann <arnd@arndb.de>, Linux Kbuild mailing list
 <linux-kbuild@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux-MIPS <linux-mips@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 Matthew Wilcox <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Matthias
 Kaehlcke <mka@chromium.org>, He Zhe <zhe.he@windriver.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michal Marek
 <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Al Viro <viro@zeniv.linux.org.uk>, Stafford Horne
 <shorne@gmail.com>, Gideon Israel Dsouza <gidisrael@gmail.com>, Kees Cook
 <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko
 Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] kbuild: add macro for controlling warnings to
 linux/compiler.h
Message-ID: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
References: <20180616005323.7938-1-paul.burton@mips.com>
 <20180616005323.7938-2-paul.burton@mips.com>
 <CAK7LNASvCha27kU4ipn23uOpNuxkzJrNzWBwYcxN4n=3xtv8SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAK7LNASvCha27kU4ipn23uOpNuxkzJrNzWBwYcxN4n=3xtv8SA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Masahiro,

On Wed, Jun 20, 2018 at 02:34:35AM +0900, Masahiro Yamada wrote:
> 2018-06-16 9:53 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index f1a7492a5cc8..aba64a2912d8 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -347,3 +347,69 @@
> >  #if GCC_VERSION >= 50100
> >  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
> >  #endif
> > +
> > +/*
> > + * turn individual warnings and errors on and off locally, depending
> > + * on version.
> > + */
> > +#define __diag_GCC(version, s) __diag_GCC_ ## version(s)
> > +
> > +#if GCC_VERSION >= 40600
> > +#define __diag_str1(s) #s
> > +#define __diag_str(s) __diag_str1(s)
> > +#define __diag(s) _Pragma(__diag_str(GCC diagnostic s))
> > +
> > +/* compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
> > +#define __diag_GCC_4_6(s) __diag(s)
> > +#else
> > +#define __diag(s)
> > +#define __diag_GCC_4_6(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 40700
> > +#define __diag_GCC_4_7(s) __diag(s)
> > +#else
> > +#define __diag_GCC_4_7(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 40800
> > +#define __diag_GCC_4_8(s) __diag(s)
> > +#else
> > +#define __diag_GCC_4_8(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 40900
> > +#define __diag_GCC_4_9(s) __diag(s)
> > +#else
> > +#define __diag_GCC_4_9(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 50000
> > +#define __diag_GCC_5(s) __diag(s)
> > +#else
> > +#define __diag_GCC_5(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 60000
> > +#define __diag_GCC_6(s) __diag(s)
> > +#else
> > +#define __diag_GCC_6(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 70000
> > +#define __diag_GCC_7(s) __diag(s)
> > +#else
> > +#define __diag_GCC_7(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 80000
> > +#define __diag_GCC_8(s) __diag(s)
> > +#else
> > +#define __diag_GCC_8(s)
> > +#endif
> > +
> > +#if GCC_VERSION >= 90000
> > +#define __diag_GCC_9(s) __diag(s)
> > +#else
> > +#define __diag_GCC_9(s)
> > +#endif
> 
> 
> Hmm, we would have to add this for every release.

Well, strictly speaking only ones that we need to modify diags for - ie.
in this series we could get away with only adding the GCC 8 macro if we
wanted.

> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 6b79a9bba9a7..313a2ad884e0 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -271,4 +271,22 @@ struct ftrace_likely_data {
> >  # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> >  #endif
> >
> > +#ifndef __diag
> > +#define __diag(string)
> > +#endif
> > +
> > +#ifndef __diag_GCC
> > +#define __diag_GCC(string)
> > +#endif
> 
> __diag_GCC() takes two arguments,
> so it should be:
> 
> #ifndef __diag_GCC
> #define __diag_GCC(version, s)
> #endif
> 
> 
> Otherwise, this would cause warning like this:
> 
> 
> arch/arm64/kernel/sys.c:40:1: error: macro "__diag_GCC" passed 2
> arguments, but takes just 1
>  SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>  ^~~~~~~~~~

Yes, good catch.

> > +#define __diag_push()  __diag(push)
> > +#define __diag_pop()   __diag(pop)
> > +
> > +#define __diag_ignore(compiler, version, option, comment) \
> > +       __diag_ ## compiler(version, ignored option)
> > +#define __diag_warn(compiler, version, option, comment) \
> > +       __diag_ ## compiler(version, warning option)
> > +#define __diag_error(compiler, version, option, comment) \
> > +       __diag_ ## compiler(version, error   option)
> > +
> 
> To me, it looks like this is putting GCC/Clang specific things
> in the common file, <linux/compiler_types.h> .
> 
> All compilers must use "ignored", "warning", "error",
> not allowed to use "ignore".

We could move that to linux/compiler-gcc.h pretty easily.

> I also wonder if we could avoid proliferating __diag_GCC_*.

My thought is that it's unlikely we'll ever support enough different
compilers for it to become problematic to list the ones we modify
warnings for in linux/compiler_types.h.

> I attached a bit different implementation below.
> 
> I used -Wno-pragmas to avoid unknown option warnings.

That doesn't seem very clean to me because it will hide typos or other
mistakes. One advantage of Arnd's patch is that by specifying the
compiler & version we only attempt to use pragmas that are appropriate
so we don't need to ignore unknown ones.

> Usage is
> 
>        __diag_push();
>        __diag_ignore(-Wattribute-alias,
>                      "Type aliasing is used to sanitize syscall arguments");
>               ...
>        __diag_pop();
> 
> Comments, ideas are appreciated.

By removing the compiler & version arguments you're enforcing that if we
ignore a warning for one compiler we must ignore it for all, regardless
of whether it's problematic. This essentially presumes that warnings
with the same name will behave the same across compilers, which feels
worse to me than having users of this explicitly state which compilers
need the pragmas.

Thanks,
    Paul

Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lS516nMvzF2sf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 16:16:37 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id a13-v6so6533148pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 23:16:37 -0700 (PDT)
Date: Tue, 15 May 2018 16:16:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Message-ID: <20180515161625.292897c9@roar.ozlabs.ibm.com>
In-Reply-To: <87tvr9o5iy.fsf@concordia.ellerman.id.au>
References: <20180514035228.21316-1-npiggin@gmail.com>
 <20180514035228.21316-4-npiggin@gmail.com>
 <20180514112826.1b820335@gandalf.local.home>
 <87tvr9o5iy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 May 2018 15:24:21 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> > On Mon, 14 May 2018 13:52:27 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> The powerpc toolchain can compile combinations of 32/64 bit and
> >> big/little endian, so it's convenient to consider, e.g.,
> >> 
> >>   `CC -m64 -mbig-endian`
> >> 
> >> To be the C compiler for the purpose of invoking it to build target
> >> artifacts. So overriding the the CC variable to include thse
> >> flags  
> ...
> >> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> >> index 191eb949d52c..3c67304a7425 100755
> >> --- a/scripts/recordmcount.pl
> >> +++ b/scripts/recordmcount.pl
> >> @@ -274,6 +274,13 @@ if ($arch eq "x86_64") {
> >>      if ($bits == 64) {
> >>  	$type = ".quad";
> >>      }
> >> +    if ($endian eq "big") {
> >> +	    $cc .= " -mbig-endian ";
> >> +	    $ld .= " -EB ";
> >> +    } else {
> >> +	    $cc .= " -mlittle-endian ";
> >> +	    $ld .= " -EL ";
> >> +    }  
> >
> > Have you tried building all current archs with function tracing
> > enabled to make sure this doesn't break any of them? I can do it if
> > you want.  
> 
> We shouldn't need to should we? This is only touching powerpc specific
> code (if I understand perl that is).

Yeah that wasn't clear from the diff context, it should only have an
affect on powerpc so you shouldn't need to go through other archs.

Thanks,
Nick

> 
> eg:
> 
> $ git diff -U9 scripts/recordmcount.pl
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 191eb949d52c..3c67304a7425 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -268,18 +268,25 @@ if ($arch eq "x86_64") {
>  } elsif ($arch eq "powerpc") {
>      $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
>      # See comment in the sparc64 section for why we use '\w'.
>      $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?\\w*?)>:";
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s\\.?_mcount\$";
>  
>      if ($bits == 64) {
>         $type = ".quad";
>      }
> +    if ($endian eq "big") {
> +           $cc .= " -mbig-endian ";
> +           $ld .= " -EB ";
> +    } else {
> +           $cc .= " -mlittle-endian ";
> +           $ld .= " -EL ";
> +    }
>  
>  } elsif ($arch eq "arm") {
>      $alignment = 2;
>      $section_type = '%progbits';
>      $mcount_regex =
> "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24|THM_CALL)" .
> "\\s+(__gnu_mcount_nc|mcount)\$"; 
>  } elsif ($arch eq "arm64") {
>      $alignment = 3;
> 
> 
> cheers

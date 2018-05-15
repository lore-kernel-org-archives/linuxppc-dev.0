Return-Path: <SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lgKw0YzVzF14f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 00:43:28 +1000 (AEST)
Date: Tue, 15 May 2018 10:43:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Message-ID: <20180515104324.5230d827@gandalf.local.home>
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

> > Have you tried building all current archs with function tracing enabled
> > to make sure this doesn't break any of them? I can do it if you want.  
> 
> We shouldn't need to should we? This is only touching powerpc specific
> code (if I understand perl that is).
> 
> eg:
> 
> $ git diff -U9 scripts/recordmcount.pl

Thanks for the added context!

Yeah, I don't look at that code much anymore since I mainly deal with
recordmcount.c now-a-days. I wonder if someone should port ppc to that.
It is also no my todo list to merge that with objtool.

Anyway,

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


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
>      $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24|THM_CALL)" .
>                         "\\s+(__gnu_mcount_nc|mcount)\$";
>  
>  } elsif ($arch eq "arm64") {
>      $alignment = 3;
> 
> 
> cheers

Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vhqY5PCxzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 02:18:33 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id t133-v6so7147772oif.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 09:18:33 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180528150726.GC17342@gate.crashing.org>
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
 <e81f81b7-2bf5-7f9a-919f-87972bf1a9db@c-s.fr>
 <20180528150726.GC17342@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 28 May 2018 18:18:09 +0200
Message-ID: <CA+7wUszZ8Dq8S9ou7tTCF84MYh7De-K02GREVf+8cgqyn0wsSQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 28, 2018 at 5:07 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, May 28, 2018 at 02:39:37PM +0000, Christophe Leroy wrote:
>> In file included from arch/powerpc/kernel/syscalls.c:24:
>> ./include/linux/syscalls.h:233:18: warning: 'sys_mmap2' alias between
>> functions of incompatible types 'long int(long unsigned int,  size_t,
>> long unsigned int,  long unsigned int,  long unsigned int,  long
>> unsigned int)' {aka 'long int(long unsigned int,  unsigned int,  long
>> unsigned int,  long unsigned int,  long unsigned int,  long unsigned
>> int)'} and 'long int(long int,  long int,  long int,  long int,  long
>> int,  long int)' [-Wattribute-alias]
>
> So yes, these are actually different (int vs. long).
>
>> In file included from arch/powerpc/kernel/signal_32.c:29:
>> ./include/linux/syscalls.h:233:18: warning: 'sys_swapcontext' alias
>> between functions of incompatible types 'long int(struct ucontext *,
>> struct ucontext *, long int)' and 'long int(long int,  long int,  long
>> int)' [-Wattribute-alias]
>
> And this one is quite spectacularly different.

https://patchwork.kernel.org/patch/10375607/

>
> Try putting this before the wacko aliases:
>
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wattribute-alias"
>
> and this after:
>
> #pragma GCC diagnostic pop
>
> so that you will get this quite useful warning for all other code.
>
>
> Segher

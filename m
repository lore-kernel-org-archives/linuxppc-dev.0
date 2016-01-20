Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0A351A1867
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 05:21:35 +1100 (AEDT)
Received: by mail-ig0-x230.google.com with SMTP id ik10so106578863igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 10:21:35 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1453268061.14751.8.camel@ellerman.id.au>
References: <569EA155.5070602@br.ibm.com>
 <1453268061.14751.8.camel@ellerman.id.au>
Date: Wed, 20 Jan 2016 10:21:33 -0800
Message-ID: <CA+55aFwOdSvUpH=o-t0uaGsammKxydGBLcaWcJ_bRsr8P1zWtA@mail.gmail.com>
Subject: Re: Different SIGSEGV codes (x86 and ppc64le)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Breno Leitao <brenohl@br.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gustavo Bueno Romero <gromero@br.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2016 at 9:34 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The kernel describes those error codes as:
>
>   #define SEGV_MAPERR   (__SI_FAULT|1)  /* address not mapped to object */
>   #define SEGV_ACCERR   (__SI_FAULT|2)  /* invalid permissions for mapped object */
>
> Which one is correct in this case isn't entirely clear. There is a stack
> mapping, but you're not allowed to use it because of the stack ulimit, so
> arguably ACCERR is more accurate.
>
> However that's only true because of the stack guard page, which is supposed to
> be somewhat invisible to userspace. If I disable the stack guard page logic,
> userspace sees SEGV_MAPERR, so it seems that historically that's what is
> expected.

I think MAPERR is likely the right thing for a guard page access.

That said, I'd also warn people from caring too mucbh about the
details of si_code. We've not traditionally been very good at filling
it in. So any program that uses it for any actual semantic behavior is
likely just broken. Print it it in debuggers by all means, but relying
on it in any other way is just crazy. It's just not historically
reliable enough.

So I wouldn't worry about it excessively.

              Linus

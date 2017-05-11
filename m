Return-Path: <linus971@gmail.com>
Received: from mail-it0-x230.google.com (mail-it0-x230.google.com
 [IPv6:2607:f8b0:4001:c0b::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP2D71S25zDqKx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 04:47:51 +1000 (AEST)
Received: by mail-it0-x230.google.com with SMTP id g126so25258493ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 11:47:51 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170511165727.17847-1-npiggin@gmail.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 May 2017 11:47:47 -0700
Message-ID: <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
Subject: Re: [PATCH] spin loop primitives for busy waiting
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 11, 2017 at 9:57 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> If you find this acceptable, I'd like to start wiring in the powerpc
> and adding the annotations to some important core spin loops (there's
> not too many really). I'm hoping if you take this patch during this
> merge window, I'll be able to start sending small patches to maintainers
> for the next window. Unless you have a better suggestion for how to
> deal with this.

This looks fine to me as an interface, and yes, I guess I can just
take this scaffolding as-is.

The one question I have is about "spin_on_cond()": since you
explicitly document that the "no spinning" case is expected to be the
default, I really think that the default implementation should be
along the lines if

  #define spin_on_cond(cond) do { \
    if (unlikely(!(cond))) { \
        spin_begin(); do spin_cpu_relax(); while (!(cond)); spin_end(); \
    } \
  } while (0)

which will actually result in better code generation even if
spin_begin/end() are no-ops, and just generally optimizes for the
right behavior (ie do the spinning out-of-line, since by definition it
cannot be performance-critical after the first iteration).

So it's better even when you don't really have the begin/end overhead,
but that version of "spin_on_cond()" is then likely to work _much_
better if you actually do have it, when your version would seem to be
entirely unacceptable.

Hmm?

In fact, do you even want to make that "spin_on_cond()" version
conditional? I don't see how an architecture can really improve on it.
If an architecture wants to use things like "wait on this particular
variable", then that generic "cond" version is too generic an
interface anyway.

                  Linus

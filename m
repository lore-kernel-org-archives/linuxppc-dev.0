Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22d.google.com (mail-it0-x22d.google.com
 [IPv6:2607:f8b0:4001:c0b::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPZMt2B4kzDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 01:56:26 +1000 (AEST)
Received: by mail-it0-x22d.google.com with SMTP id o5so13099819ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 08:56:26 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
 <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 May 2017 08:56:23 -0700
Message-ID: <CA+55aFyZKwHdtfjZOpo2ReEeyLG24Qpik4UzqyM3V63mxBujKQ@mail.gmail.com>
Subject: Re: [PATCH] spin loop primitives for busy waiting
To: David Laight <David.Laight@aculab.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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

On Fri, May 12, 2017 at 5:58 AM, David Laight <David.Laight@aculab.com> wrote:
>
> At least some versions of gcc convert while (cond) do {body}
> into if (cond) do {body} while (cond) even when 'cond'
> is a non-trivial expression and 'body' is trivial.

Afaik pretty much all versions of gcc do that, unless you use -Os
(which we have effectively stopped doing because it causes so many
other problems in stupid instruction choices etc).

> The code-bloat is silly.
> No point enforcing the 'optimisation' here.

Actually, for places where we expect cold code and the loop to be
often run zero times, it actually makes sense. When we can make the
initial "if()" be unlikely, and gcc can then generate the unlikely
code all out of line, then the while -> if+do-while construction makes
sense.

It's the "normal" while loops that it's sad how big code gcc
generates, considering that most of our loop counts are vert small
(but generally nonzero).

               Linus

Return-Path: <linus971@gmail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79B28B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 08:36:12 +1100 (EST)
Received: by wgbds10 with SMTP id ds10so2204219wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2012 14:36:08 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
References: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2012 14:35:48 -0700
Message-ID: <CA+55aFy9oxMrfm-+deMqV=XnFOa98aKXqW+8PR-P-zOARtC2BQ@mail.gmail.com>
Subject: Re: [GIT PULL] DMA-mapping framework updates for 3.4
To: Marek Szyprowski <m.szyprowski@samsung.com>, Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 discuss@x86-64.org, linux-kernel@vger.kernel.org,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2012 at 12:24 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> =A0git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next
>
> Those patches introduce a new alloc method (with support for memory
> attributes) in dma_map_ops structure, which will later replace
> dma_alloc_coherent and dma_alloc_writecombine functions.

So I'm quite unhappy with these patches.

Here's just the few problems I saw from some *very* quick look-through
of the git tree:

 - I'm not seeing ack's from the architecture maintainers for the
patches that change some architecture.

 - Even more importantly, what I really want is acks and comments from
the people who are expected to *use* this.

 - it looks like patches break compilation half-way through the
series. Just one example I noticed: the "x86 adaptation" patch changes
the functions in lib/swiotlb.c, but afaik ia64 *also* uses those. So
now ia64 is broken until a couple of patches later. I suspect there
are other examples like that.

 - the sign-off chains are odd. What happened there? Several patches
are signed off by Kyungmin Park, but he doesn't seem to be "in the
chain" at all. Whazzup? (*)

(Btw, I notice the same thing in the tree I pulled from Dave Airlie,
btw - what the F is going on with samsung submissions - those are
marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all!)

 - Finally, how/why are "dma attributes" different from the per-device
dma limits ("device_dma_parameters")

Hmm?

                  Linus

(*) Btw, I notice the same thing in the tree I pulled from Dave
Airlie, btw - what the F is going on with samsung submissions - those
are marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all! Dave?

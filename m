Return-Path: <linus971@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s1xw72dprzDrFb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 06:27:03 +1000 (AEST)
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s1xw65cR5z9syB
 for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2016 06:27:02 +1000 (AEST)
Received: by mail-oi0-x231.google.com with SMTP id l72so148356531oig.2
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Jul 2016 13:27:02 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1469888588-5918-1-git-send-email-mpe@ellerman.id.au>
References: <1469888588-5918-1-git-send-email-mpe@ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Jul 2016 13:27:00 -0700
Message-ID: <CA+55aFxBJO2HLkWM=uLyNxBYQpNY8jf_0oZqFzHNcgQd-VKdAA@mail.gmail.com>
Subject: Re: [PATCH] random: Fix crashes with sparse node ids
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 30, 2016 at 7:23 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>  #ifdef CONFIG_NUMA
> -       pool = kmalloc(num_nodes * sizeof(void *),
> +       pool = kmalloc(nr_node_ids * sizeof(void *),
>                        GFP_KERNEL|__GFP_NOFAIL|__GFP_ZERO);
>         for_each_online_node(i) {
>                 crng = kmalloc_node(sizeof(struct crng_state),

Ugh. Can we please also just change that kmalloc to kcalloc()? Get rid
of the odd multiplication and the unusual GFP mask bit crud?

And instead of using "sizeof(void *)", just use the pool entry size,
ie "sizeof(*pool)". Yes, we have other places where we depend on void
pointers having the same size as others, but it's the RightThing(tm)
to do anyway, and it makes more sense when you grep things ("Oh, we're
allocating 'nr_node_id' copes of *pool entries" even without knowing
what type is behind the "pool" pointer).

IOW, can you confirm that you could just use

        pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL);

instead? I'd much rather apply that patch.

               Linus

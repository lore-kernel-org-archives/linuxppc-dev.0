Return-Path: <linus971@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s27tP2fzjzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 13:56:13 +1000 (AEST)
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s27tN45gQz9sXx
 for <linuxppc-dev@ozlabs.org>; Sun, 31 Jul 2016 13:56:12 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id w18so154464183oiw.3
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Jul 2016 20:56:12 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87y44io5be.fsf@concordia.ellerman.id.au>
References: <1469888588-5918-1-git-send-email-mpe@ellerman.id.au>
 <CA+55aFxBJO2HLkWM=uLyNxBYQpNY8jf_0oZqFzHNcgQd-VKdAA@mail.gmail.com>
 <87y44io5be.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Jul 2016 20:56:09 -0700
Message-ID: <CA+55aFyi9JyFMArYtv_QBRMkp4GjHzmrDA99VrksShR=LwgdWw@mail.gmail.com>
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

On Sat, Jul 30, 2016 at 8:27 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Dropping NOFAIL means we need to handle allocation failures, which makes
> the patch a bit bigger, and less of a pure fix.

Hmm. If you get allocation failures for something like this at init
time, I think you're basically screwed anyway.

And I really only meant for the initial array allocation, and the
__GFP_ZERO thing.

Yes, __GFP_ZERO does work for kmalloc() too, but unlike the other GPF
flags, we do have special zalloc versions for zeroing that are
generally preferred.

              Linus

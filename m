Return-Path: <geert.uytterhoeven@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10A2E1A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 20:59:47 +1100 (AEDT)
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com
 [IPv6:2607:f8b0:4003:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83A5F14012C
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2015 20:59:46 +1100 (AEDT)
Received: by mail-oi0-f42.google.com with SMTP id h136so12582691oig.1
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2015 01:59:45 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1421737558-14756-1-git-send-email-mpe@ellerman.id.au>
References: <1421737558-14756-1-git-send-email-mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 10:59:44 +0100
Message-ID: <CAMuHMdXXoqhwEf6P0pbJb_JkEKkK4bOGBVt8jG-gqKYBBDeHQA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Update all configs using savedefconfig
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Jan 20, 2015 at 8:05 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> It looks like it's ~4 years since we updated some of these, so do a bulk
> update.
>
> Verified that the before and after generated configs are exactly the
> same.

Yep, that's guaranteed by the tool (modulo bugs).

> Which begs the question why update them? The answer is that it can be
> confusing when the stored defconfig drifts too far from the generated
> result.

And it becomes hard to update them, e.g. for enabling or disabling a single
option.

Now the big question is: do they still work?
Plainly ignoring any bugs introduced in the code, there are probably several
"select" statements that have been removed. 4 years ago, they automatically
selected some critical options, while now, they're no longer selected, causing
breakage.

I'm afraid the only safe way is (for all 108 defconfig files):
  - start from the full .config file, as generated from the minimal defconfig
    file in a source tree from 4 years ago,
  - run "make oldconfig" (boring),
  - run "make savedefconfig",
  - update the minimal defconfig.

The boring step can be made a little bit less boring by making a diff between
the .config versions before and after running the first "make oldconfig",
and applying that to the later .config files first, but it's still a tedious
task, especially after 4 years. That's why I do this (for m68k) on every rc
release.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

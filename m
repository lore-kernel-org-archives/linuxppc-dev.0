Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DE5E1A05A7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 May 2014 18:48:58 +1000 (EST)
Received: by mail-ie0-f180.google.com with SMTP id tp5so6593234ieb.39
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 May 2014 01:48:53 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.DEB.2.19.4.1405241829250.7552@trent.utfs.org>
References: <alpine.DEB.2.19.4.1405241829250.7552@trent.utfs.org>
Date: Sun, 25 May 2014 10:48:52 +0200
Message-ID: <CAMuHMdWSd=nLiG_QacqnePbvQ=QBv8dRakDGL6LQ+6tEGP1qEQ@mail.gmail.com>
Subject: Re: fs/hfsplus/xattr.c: comparison of distinct pointer types lacks a
 cast
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christian,

On Sun, May 25, 2014 at 3:42 AM, Christian Kujau <lists@nerdbynature.de> wrote:
> /usr/local/src/linux-git/include/asm-generic/div64.h:43:28: warning:
> comparison of distinct pointer types lacks a cast [enabled by default]
>   (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                             ^
> /usr/local/src/linux-git/fs/hfsplus/xattr.c:86:2: note: in expansion of
> macro 'do_div'
>   do_div(tmp, node_size);
>   ^
>   LD [M]  fs/hfsplus/hfsplus.o
>
> ---------------------------------------------------------------
>
> I don't fully understand the issue here, but xattr.c:86 reads:
>
>            do_div(tmp, node_size);

"tmp" is "loff_t" which is "__kernel_loff_t", which is "long long", i.e. signed,
while include/asm-generic/div64.h compares its type with "uint64_t".

As inode sizes are positive, it should be safe to change the type of "tmp"
to "u64". Does that make the warning go away?

> Now, "git log -S do_div --source fs/hfsplus/xattr.c" brought up the
> following commit from Geert, introducing do_div() to xattr.c
>
>   commit a99b7069aab8fc3fb4f26d15795dc280b52e38b1 HEAD
>   Author: Geert Uytterhoeven <geert@linux-m68k.org>
>   Date:   Thu Nov 14 14:32:18 2013 -0800
>   hfsplus: Fix undefined __divdi3 in hfsplus_init_header_node()
>
> Reverting this commit makes the warning above go away, but I doubt this
> would be the correct solution here :-)

Indeed ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

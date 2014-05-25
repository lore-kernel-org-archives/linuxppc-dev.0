Return-Path: <saproj@gmail.com>
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com
 [IPv6:2607:f8b0:4003:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 684781A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 07:19:46 +1000 (EST)
Received: by mail-ob0-f171.google.com with SMTP id wn1so7378654obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 May 2014 14:19:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.19.4.1405251156110.7552@trent.utfs.org>
References: <alpine.DEB.2.19.4.1405241829250.7552@trent.utfs.org>
 <CAMuHMdWSd=nLiG_QacqnePbvQ=QBv8dRakDGL6LQ+6tEGP1qEQ@mail.gmail.com>
 <alpine.DEB.2.19.4.1405251156110.7552@trent.utfs.org>
Date: Sun, 25 May 2014 23:19:42 +0200
Message-ID: <CABikg9zRh9iVKPmO=oUExcEx6nTz9rii6LDouzopYS-57uVTsw@mail.gmail.com>
Subject: Re: fs/hfsplus/xattr.c: comparison of distinct pointer types lacks a
 cast
From: Sergei Antonov <saproj@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25 May 2014 21:07, Christian Kujau <lists@nerdbynature.de> wrote:
> On Sun, 25 May 2014 at 10:48, Geert Uytterhoeven wrote:
>> "tmp" is "loff_t" which is "__kernel_loff_t", which is "long long", i.e. signed,
>> while include/asm-generic/div64.h compares its type with "uint64_t".
>
> Thanks for the explanation!
>
>> As inode sizes are positive, it should be safe to change the type of "tmp"
>> to "u64". Does that make the warning go away?
>
> Yes, this helped! Compile-tested only:
>
>  Signed-off-by: Christian Kujau <lists@nerdbynature.de>
>       Fixed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Commit a99b7069aab8fc3fb4f26d15795dc280b52e38b1 introduced do_div() to
> xattr.c and the warning below too.
>
> As Geert remarked: "tmp" is "loff_t" which is "__kernel_loff_t", which
> is "long long", i.e. signed, while include/asm-generic/div64.h compares
> its type with "uint64_t". As inode sizes are positive, it should be safe
> to change the type of "tmp" to "u64".
>
> ==============================
>   CC [M]  fs/hfsplus/xattr_user.o
>   CC [M]  fs/hfsplus/xattr_security.o
>   CC [M]  fs/hfsplus/xattr.o
>   CC [M]  fs/hfsplus/xattr_trusted.o
> In file included from
> arch/powerpc/include/asm/div64.h:1:0,
>                  from include/linux/kernel.h:124,
>                  from include/asm-generic/bug.h:13,
>                  from arch/powerpc/include/asm/bug.h:127,
>                  from include/linux/bug.h:4,
>                  from include/linux/thread_info.h:11,
>                  from include/asm-generic/preempt.h:4,
>                  from arch/powerpc/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:18,
>                  from include/linux/spinlock.h:50,
>                  from include/linux/wait.h:8,
>                  from include/linux/fs.h:6,
>                  from fs/hfsplus/hfsplus_fs.h:19,
>                  from fs/hfsplus/xattr.c:9:
> fs/hfsplus/xattr.c: In function
> 'hfsplus_init_header_node':
> include/asm-generic/div64.h:43:28: warning:
> comparison of distinct pointer types lacks a cast [enabled by default]
>   (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                             ^
> fs/hfsplus/xattr.c:86:2: note: in expansion of
> macro 'do_div'
>   do_div(tmp, node_size);
>   ^
>   LD [M]  fs/hfsplus/hfsplus.o
> ==============================
>
>
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 4e27edc..cd9ed4c 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -66,7 +66,7 @@ static void hfsplus_init_header_node(struct inode *attr_file,
>         char *bmp;
>         u32 used_nodes;
>         u32 used_bmp_bytes;
> -       loff_t tmp;
> +       u64 tmp;
>
>         hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size %u\n",
>                                 clump_size, node_size);

Acked-by: Sergei Antonov <saproj@gmail.com>
This patch also needs a name, for example "hfsplus: remove compiler
warning on PowerPC".
You may need to send it to Andrew Morton <akpm@linux-foundation.org>
to include in linux-next.

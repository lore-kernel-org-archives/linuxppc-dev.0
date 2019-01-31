Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B11C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 13:52:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D8B2085B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lpOa66XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D8B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r1ry4bBMzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 00:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=andreyknvl@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="lpOa66XZ"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r1ps69xszDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 00:50:55 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id g189so1386439pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5mHI+bG7UqOLpSStoFPELxtV/QVAsIr+h0/wFw+pvv4=;
 b=lpOa66XZM4yPKMVQFGcny7LJ5ik3t07aemIjCjZCcyi7tlmRjKcAqeXU7OXpxynO9k
 aZhtUv4SRUXB8afYOweJrUdVdGFyLdwAEs6mqxacm8Kt1Agbla/Xlsaksibhe0xda8EM
 4QCdI0XkzauGKSej8c3ypT+kSGexvxJyDrGpjjDbj1oGQ13b4Zd39BeTg+G0ZXzrp+y4
 U4Qpv6JuQJkdGzu1JRbRbCI55yRJXxwvNww8Qdeiu351e/IDsT/FcdoNWSqI6ziT4oqG
 PflfTMSiJgbTGOticxiFbpD66L4412gJwfyad49vkpeo3SJoRFNoO3YfnEiitbH1czRY
 8kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5mHI+bG7UqOLpSStoFPELxtV/QVAsIr+h0/wFw+pvv4=;
 b=Mst2ejGYbUocVtHaa8Yd6JHW2ejMNGgHgkNuawI8J3lulJ79w49/CcZ+R1D2JYGn7g
 aVLCggMr/ofgr9TIFws5A6ezcXm6dNmLs2KUQNivl8YNxr1mm52PEokvNZ7YfkQ2X4tY
 IC6E1grCGsIkMU5uXh4VIyRE5JK23ptA6wSMxF8UV5ibQG+h8m6pREmP2Ovk9+oBYwfL
 7pgdcV2uPzoo+AuZIRu17XjtQNiqT5MsseoUUukep86je9ldXk4kj4SSIYrlG2XN3+p3
 7TveL6C9NfS4mogeuei1a9Lo6KBVz5rT/QuFAsTJaZO77RAfqKwyBwq7SpGR/l+gwNf3
 NyUw==
X-Gm-Message-State: AJcUukcaaj6CnoqUW7fUYWYPAeePv2Hzg2bNSufbqogwo6wH1aohqiTL
 iZTE2cqVPZpyoHLukmhLS/JN6RP5YmsI4vjl2Ty8gw==
X-Google-Smtp-Source: ALg8bN5E/x/Nfc79SNycFRpyqvUiw86gTds5GoJ2BPF0CeoYJoWKaa2XQRKvayCkR2rkjASE1JgqbQIGnvzbHgMSXLU=
X-Received: by 2002:a63:4706:: with SMTP id u6mr29850017pga.95.1548942653182; 
 Thu, 31 Jan 2019 05:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20190131163854.307e17ab@canb.auug.org.au>
 <20190131170629.2cc20600@canb.auug.org.au>
 <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
 <20190131074018.GD28876@rapoport-lnx>
In-Reply-To: <20190131074018.GD28876@rapoport-lnx>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 31 Jan 2019 14:50:42 +0100
Message-ID: <CAAeHK+y5p85jdvtX4OhwR9zNPGy+fxZtzdDZwAPS3u-dHNKbQQ@mail.gmail.com>
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the akpm
 tree
To: Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 31, 2019 at 8:40 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> (added Andrey Konovalov)
>
> On Thu, Jan 31, 2019 at 07:15:26AM +0100, Christophe Leroy wrote:
> >
> > Le 31/01/2019 =C3=A0 07:06, Stephen Rothwell a =C3=A9crit :
> > >Hi all,
> > >
> > >On Thu, 31 Jan 2019 16:38:54 +1100 Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
> > >>
> > >>[I am guessing that is is something in Andrew's tree that has caused
> > >>this.]
> > >>
> > >>My qemu boot of the powerpc pseries_le_defconfig config failed like t=
his:
> > >>
> > >>htab_hash_mask    =3D 0x1ffff
> > >>-----------------------------------------------------
> > >>numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
> > >>Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 21=
47483648 bytes align=3D0x10000 nid=3D0 from=3Dfffffffffffffff
> > >>CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
> > >>Call Trace:
> > >>[c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliabl=
e)
> > >>[c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
> > >>[c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
> > >>[c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
> > >>[c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
> > >>[c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
> > >>[c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
> > >>[c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c
> > >
> > >A quick bisect leads to this:
> > >
> > >1c3c9328cde027eb875ba4692f0a5d66b0afe862 is the first bad commit
> > >commit 1c3c9328cde027eb875ba4692f0a5d66b0afe862
> > >Author: Mike Rapoport <rppt@linux.ibm.com>
> > >Date:   Thu Jan 31 10:51:32 2019 +1100
> > >
> > >     treewide: add checks for the return value of memblock_alloc*()
> > >     Add check for the return value of memblock_alloc*() functions and=
 call
> > >     panic() in case of error.  The panic message repeats the one used=
 by
> > >     panicing memblock allocators with adjustment of parameters to inc=
lude only
> > >     relevant ones.
> > >
> > >Which is just adding the panic we hit.  So, presumably, the bug is in =
a
> > >preceding patch :-(
> > >
> > >I have left the kernel not booting for today.
> > >
> >
> > No I think the error is really in that patch, see my other mail.
> >
> > See https://elixir.bootlin.com/linux/v5.0-rc4/source/mm/memblock.c#L145=
5,
> > memblock_alloc_try_nid_raw() is not supposed to panic, so the last hunk=
 of
> > this patch should be reverted.
> >
> > Found in total three problematic hunks in that patch:
> >
> > @@ -48,6 +53,11 @@ static phys_addr_t __init kasan_alloc_raw_page(int n=
ode)
> >       void *p =3D memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
> >                                               __pa(MAX_DMA_ADDRESS),
> >                                               MEMBLOCK_ALLOC_KASAN, nod=
e);
> > +     if (!p)
> > +             panic("%s: Failed to allocate %lu bytes align=3D0x%lx nid=
=3D%d from=3D%llx\n",
> > +                   __func__, PAGE_SIZE, PAGE_SIZE, node,
> > +                   __pa(MAX_DMA_ADDRESS));
> > +
> >       return __pa(p);
> >  }
>
> I've looked more closely to the code that uses this function and it does
> not seem to handle allocation error.
> I can replace the panic with WARN(), but I think that panic() here is
> appropriate.
>
> Andrey, can you comment?

+ Andrey Ryabinin

I think panic() there looks appropriate. Added Andrey Ryabinin to take a lo=
ok.

>
>
> > @@ -211,6 +211,9 @@ static int __init iob_init(struct device_node *dn)
> >       iob_l2_base =3D memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
> >                                       MEMBLOCK_LOW_LIMIT, 0x80000000,
> >                                       NUMA_NO_NODE);
> > +     if (!iob_l2_base)
> > +             panic("%s: Failed to allocate %lu bytes align=3D0x%lx max=
_addr=3D%x\n",
> > +                   __func__, 1UL << 21, 1UL << 21, 0x80000000);
> >
> >       pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
>
> This one is actually fixes my own mistake from one of the previous patche=
s
> that converted memblock_alloc_base() to memblock_alloc_try_nid_raw() with=
out
> adding the panic() (commit 47e382eb08cfa0199c4ea9f9cc73f1b48a3a4b1d
> "powerpc: prefer memblock APIs returning virtual address")
>
> > @@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned lon=
g
> > size, int nid)
> >               memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> >                                               __pa(MAX_DMA_ADDRESS),
> >                                               MEMBLOCK_ALLOC_ACCESSIBLE=
, nid);
> > +     if (!sparsemap_buf)
> > +             panic("%s: Failed to allocate %lu bytes align=3D0x%lx nid=
=3D%d from=3D%lx\n",
> > +                   __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRES=
S));
> > +
> >       sparsemap_buf_end =3D sparsemap_buf + size;
> >  }
>
> This hunk was not needed as sparse can deal with this allocation failure.
>
> Andrew, can you please add the below patch to as a fixup to "treewide: ad=
d
> checks for the return value of memblock_alloc*()"?
>
> From 854f54b9d4fe52f477765b905a4b2c421d30f46e Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Thu, 31 Jan 2019 09:18:50 +0200
> Subject: [PATCH] mm/sparse: don't panic if the allocation in
>  sparse_buffer_init fails
>
> Addition of panic if memblock_alloc_try_nid_raw() call in
> sparse_buffer_init() fails was over enthusiastic as the system is perfect=
ly
> capable to deal with that allocation failure.
> Remove the panic().
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/sparse.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 1471f06..c11aba0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -434,10 +434,6 @@ static void __init sparse_buffer_init(unsigned long =
size, int nid)
>                 memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>                                                 __pa(MAX_DMA_ADDRESS),
>                                                 MEMBLOCK_ALLOC_ACCESSIBLE=
, nid);
> -       if (!sparsemap_buf)
> -               panic("%s: Failed to allocate %lu bytes align=3D0x%lx nid=
=3D%d from=3D%lx\n",
> -                     __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRES=
S));
> -
>         sparsemap_buf_end =3D sparsemap_buf + size;
>  }
>
> --
> 2.7.4
>

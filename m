Return-Path: <catalin.marinas@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lBTF56fJzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 21:03:25 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id j8-v6so8426446pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 04:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de>
 <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org>
In-Reply-To: <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 7 Aug 2018 12:03:11 +0100
Message-ID: <CAHkRjk7aYtMJXmQ_zuV7B12JiCkLfg3-8x+ayTD2DU9gDwi8Hw@mail.gmail.com>
Subject: Re: Several suspected memory leaks
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: pmenzel@molgen.mpg.de, Paul Mackerras <paulus@samba.org>,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(catching up with emails)

On Wed, 11 Jul 2018 at 00:40, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-07-10 at 17:17 +0200, Paul Menzel wrote:
> > On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
> > =E2=80=93 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) =E2=80=93 w=
ith
> > kmemleak. Several issues are found.
>
> Some of these are completely uninteresting though and look like
> kmemleak bugs to me :-)
>
> >     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
> >     [<0000000007135d64>] hash__map_kernel_page+0x30c/0x4d0
> >     [<0000000071677858>] __ioremap_at+0x108/0x140
> >     [<000000000023e921>] __ioremap_caller+0x130/0x180
> >     [<000000009dbc3923>] icp_native_init_one_node+0x5cc/0x760
> >     [<0000000015f3168a>] icp_native_init+0x70/0x13c
> >     [<00000000655550ed>] xics_init+0x38/0x1ac
> >     [<0000000088dbf9d1>] pnv_init_IRQ+0x30/0x5c
>
> This is the interrupt controller mapping its registers, why on earth
> would that be considered a leak ? kmemleak needs to learn to ignore
> kernel page tables allocations.

Indeed, that's just a false positive for powerpc. Kmemleak ignores
page allocations and most architectures use __get_free_pages() for the
page table. In this particular case, the powerpc code uses
kmem_cache_alloc() and that's tracked by kmemleak. Since the pgd
stores the __pa(pud), kmemleak doesn't detect this pointer and reports
it as a leak. To work around this, you can pass SLAB_NOLEAKTRACE to
kmem_cache_create() in pgtable_cache_add()
(arch/powerpc/mm/init-common.c).

--=20
Catalin

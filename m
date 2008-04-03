Return-Path: <yhlu.kernel@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 2B129DDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 11:47:22 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1673815rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 17:47:21 -0700 (PDT)
Message-ID: <86802c440804021747j2e82a30ew8568e4339e272e36@mail.gmail.com>
Date: Wed, 2 Apr 2008 17:47:21 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
To: "Badari Pulavarty" <pbadari@us.ibm.com>
Subject: Re: [PATCH] mm: allocate usemap at first instead of mem_map in
	sparse_init
In-Reply-To: <1207180285.30407.45.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<1207180285.30407.45.camel@dyn9047017100.beaverton.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 4:51 PM, Badari Pulavarty <pbadari@us.ibm.com> wrote:
> On Wed, 2008-04-02 at 15:25 -0700, Yinghai Lu wrote:
>  > [PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
>
> > so try to allocate usemap at first altogether.
>  >
>  > Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
>  >
>  > diff --git a/mm/sparse.c b/mm/sparse.c
>  > index d3cb085..782ebe5 100644
>  > --- a/mm/sparse.c
>  > +++ b/mm/sparse.c
>  > @@ -294,7 +294,7 @@ void __init sparse_init(void)
>  >       unsigned long pnum;
>  >       struct page *map;
>  >       unsigned long *usemap;
>  > -     struct page **section_map;
>  > +     unsigned long **usemap_map;
>  >       int size;
>  >       int node;
>  >
>  > @@ -305,27 +305,31 @@ void __init sparse_init(void)
>  >        * make next 2M slip to one more 2M later.
>  >        * then in big system, the memmory will have a lot hole...
>  >        * here try to allocate 2M pages continously.
>
>  Comments are x86-64 specific. On ppc its 16MB chunks :(
>
>
>
>  > +      *
>  > +      * powerpc hope to sparse_init_one_section right after each
>  > +      * sparse_early_mem_map_alloc, so allocate usemap_map
>  > +      * at first.
>  >        */
>  > -     size = sizeof(struct page *) * NR_MEM_SECTIONS;
>  > -     section_map = alloc_bootmem(size);
>  > -     if (!section_map)
>  > -             panic("can not allocate section_map\n");
>  > +     size = sizeof(unsigned long *) * NR_MEM_SECTIONS;
>  > +     usemap_map = alloc_bootmem(size);
>  > +     if (!usemap_map)
>  > +             panic("can not allocate usemap_map\n");
>  >
>  >       for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
>  >               if (!present_section_nr(pnum))
>  >                       continue;
>  > -             section_map[pnum] = sparse_early_mem_map_alloc(pnum);
>  > +             usemap_map[pnum] = sparse_early_usemap_alloc(pnum);
>  >       }
>  >
>  >       for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
>  >               if (!present_section_nr(pnum))
>  >                       continue;
>  >
>  > -             map = section_map[pnum];
>  > +             map = sparse_early_mem_map_alloc(pnum);
>  >               if (!map)
>  >                        continue;
>  >
>  > -             usemap = sparse_early_usemap_alloc(pnum);
>  > +             usemap = usemap_map[pnum];
>  >               if (!usemap)
>  >                       continue;
>
>  You may want to move this check before doing sparse_early_mem_map_alloc
>  (). We are also not handling errors properly (freeing up the unused
>  map or usemap) if we "continue". I know the original code is this way,
>  but you touched it last :)

Yes. could avoid some leak...

YH

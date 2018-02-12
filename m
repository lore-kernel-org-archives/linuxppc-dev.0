Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg8c96Pp4zDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 02:24:56 +1100 (AEDT)
Received: by mail-pg0-x234.google.com with SMTP id g2so7692698pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 07:24:56 -0800 (PST)
Date: Tue, 13 Feb 2018 01:24:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/5] powerpc/mm/slice: improve slice speed and stack
 use
Message-ID: <20180213012442.45b6f49b@roar.ozlabs.ibm.com>
In-Reply-To: <e2043d70-97a7-b914-f279-4aad76b9bf91@c-s.fr>
References: <20180210081139.27236-1-npiggin@gmail.com>
 <e2043d70-97a7-b914-f279-4aad76b9bf91@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Feb 2018 16:02:23 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 10/02/2018 à 09:11, Nicholas Piggin a écrit :
> > This series intends to improve performance and reduce stack
> > consumption in the slice allocation code. It does it by keeping slice
> > masks in the mm_context rather than compute them for each allocation,
> > and by reducing bitmaps and slice_masks from stacks, using pointers
> > instead where possible.
> > 
> > checkstack.pl gives, before:
> > 0x00000de4 slice_get_unmapped_area [slice.o]:           656
> > 0x00001b4c is_hugepage_only_range [slice.o]:            512
> > 0x0000075c slice_find_area_topdown [slice.o]:           416
> > 0x000004c8 slice_find_area_bottomup.isra.1 [slice.o]:   272
> > 0x00001aa0 slice_set_range_psize [slice.o]:             240
> > 0x00000a64 slice_find_area [slice.o]:                   176
> > 0x00000174 slice_check_fit [slice.o]:                   112
> > 
> > after:
> > 0x00000d70 slice_get_unmapped_area [slice.o]:           320
> > 0x000008f8 slice_find_area [slice.o]:                   144
> > 0x00001860 slice_set_range_psize [slice.o]:             144
> > 0x000018ec is_hugepage_only_range [slice.o]:            144
> > 0x00000750 slice_find_area_bottomup.isra.4 [slice.o]:   128
> > 
> > The benchmark in https://github.com/linuxppc/linux/issues/49 gives, before:
> > $ time ./slicemask
> > real	0m20.712s
> > user	0m5.830s
> > sys	0m15.105s
> > 
> > after:
> > $ time ./slicemask
> > real	0m13.197s
> > user	0m5.409s
> > sys	0m7.779s  
> 
> Hi,
> 
> I tested your serie on an 8xx, on top of patch 
> https://patchwork.ozlabs.org/patch/871675/
> 
> I don't get a result as significant as yours, but there is some 
> improvment anyway:
> 
> ITERATION 500000
> 
> Before:
> 
> root@vgoip:~# time ./slicemask
> real    0m 33.26s
> user    0m 1.94s
> sys     0m 30.85s
> 
> After:
> root@vgoip:~# time ./slicemask
> real    0m 29.69s
> user    0m 2.11s
> sys     0m 27.15s
> 
> Most significant improvment is obtained with the first patch of your serie:
> root@vgoip:~# time ./slicemask
> real    0m 30.85s
> user    0m 1.80s
> sys     0m 28.57s

Okay, thanks. Are you still spending significant time in the slice
code?

> 
> Had to modify your serie a bit, if you are interested I can post it.
> 

Sure, that would be good.

Thanks,
Nick

Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4Mh34ZY2zDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 04:54:58 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Wed, 03 Aug 2016 20:52:48 +0200
Message-ID: <3892328.nUGXIq3MaH@wuerfel>
In-Reply-To: <20160804013729.7fffa45a@roar.ozlabs.ibm.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <5216072.9VpDc0iy8Q@wuerfel> <20160804013729.7fffa45a@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, August 4, 2016 1:37:29 AM CEST Nicholas Piggin wrote:
> 
> I've attached what I'm using, which builds and runs for me without
> any work. Your arch obviously has to select the option to use it.
> 
>     text      data     bss      dec       hex     filename
>     11196784  1185024  1923820  14305628  da495c  vmlinuxppc64.before
>     11187536  1181848  1923176  14292560  da1650  vmlinuxppc64.after
>     
> ~9K text saving, ~3K data saving. I assume this comes from fewer
> branch trampolines and toc entries, but haven't verified exactly.

The patch seems to work great, but for me it's getting bigger
(compared to my older patch, mainline allyesconfig doesn't build):

   text	   data	    bss	    dec	    hex	filename
51299868	42599559	23362148	117261575	6fd4507	vmlinuxarm.before
51302545	42595015	23361884	117259444	6fd3cb4	vmlinuxarm.after

Most of the difference appears to be in branch trampolines (634 added,
559 removed, 14837 unchanged) as you suspect, but I also see a couple
of symbols show up in vmlinux that were not there before:

-A __crc_dma_noop_ops
-D dma_noop_ops
-R __clz_tab
-r fdt_errtable
-r __kcrctab_dma_noop_ops
-r __kstrtab_dma_noop_ops
-R __ksymtab_dma_noop_ops
-t dma_noop_alloc
-t dma_noop_free
-t dma_noop_map_page
-t dma_noop_mapping_error
-t dma_noop_map_sg
-t dma_noop_supported
-T fdt_add_reservemap_entry
-T fdt_begin_node
-T fdt_create
-T fdt_create_empty_tree
-T fdt_end_node
-T fdt_finish
-T fdt_finish_reservemap
-T fdt_property
-T fdt_resize
-T fdt_strerror
-T find_cpio_data

>From my first look, it seems that all of lib/*.o is now getting linked
into vmlinux, while we traditionally leave out everything from lib/
that is not referenced.

I also see a noticeable overhead in link time, the numbers are for
a cache-hot rebuild after a successful allyesconfig build, using a
24-way Opteron@2.5Ghz, just relinking vmlinux:

$ time make skj30 vmlinux # before
real	2m8.092s
user	3m41.008s
sys	0m48.172s

$ time make skj30 vmlinux # after
real	4m10.189s
user	5m43.804s
sys	0m52.988s

That is clearly a very sharp difference. Fortunately for the defconfig
build, the times are much lower, and I see no real difference other
than the noise between subsequent runs:

$ time make skj30 vmlinux # before
real	0m5.415s
user	0m19.716s
sys	0m9.356s
$ time make skj30 vmlinux # before
real	0m9.536s
user	0m21.320s
sys	0m9.224s


$ time make skj30 vmlinux # after
real	0m5.539s
user	0m20.360s
sys	0m9.224s

$ time make skj30 vmlinux # after
real	0m9.138s
user	0m21.932s
sys	0m8.988s

$ time make skj30 vmlinux # after
real	0m5.659s
user	0m20.332s
sys	0m9.620s

	Arnd

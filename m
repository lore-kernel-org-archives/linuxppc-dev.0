Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4VhX0fchzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 10:10:52 +1000 (AEST)
Date: Thu, 4 Aug 2016 10:10:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Fengguang Wu
 <fengguang.wu@intel.com>, linuxppc-dev@lists.ozlabs.org, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160804101051.39ca1e26@canb.auug.org.au>
In-Reply-To: <3892328.nUGXIq3MaH@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <5216072.9VpDc0iy8Q@wuerfel>
 <20160804013729.7fffa45a@roar.ozlabs.ibm.com>
 <3892328.nUGXIq3MaH@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Wed, 03 Aug 2016 20:52:48 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> Most of the difference appears to be in branch trampolines (634 added,
> 559 removed, 14837 unchanged) as you suspect, but I also see a couple
> of symbols show up in vmlinux that were not there before:
> 
> -A __crc_dma_noop_ops
> -D dma_noop_ops
> -R __clz_tab
> -r fdt_errtable
> -r __kcrctab_dma_noop_ops
> -r __kstrtab_dma_noop_ops
> -R __ksymtab_dma_noop_ops
> -t dma_noop_alloc
> -t dma_noop_free
> -t dma_noop_map_page
> -t dma_noop_mapping_error
> -t dma_noop_map_sg
> -t dma_noop_supported
> -T fdt_add_reservemap_entry
> -T fdt_begin_node
> -T fdt_create
> -T fdt_create_empty_tree
> -T fdt_end_node
> -T fdt_finish
> -T fdt_finish_reservemap
> -T fdt_property
> -T fdt_resize
> -T fdt_strerror
> -T find_cpio_data
> 
> From my first look, it seems that all of lib/*.o is now getting linked
> into vmlinux, while we traditionally leave out everything from lib/
> that is not referenced.

You could try removing the --{,no-}whole-archive arguments to ld in
scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh.  Last time I did
that, though, a whole lot of stuff failed to be linked in. (Especially
stuff only referenced by EXPORT_SYMBOL()s, bu that may have been fixed).

> I also see a noticeable overhead in link time, the numbers are for
> a cache-hot rebuild after a successful allyesconfig build, using a
> 24-way Opteron@2.5Ghz, just relinking vmlinux:

I was afraid of that, but it is offset by the time saved by not doing
the "ld -r"s along the way?  It may also be that (for powerpc anyway)
the linker is doing a better job.

-- 
Cheers,
Stephen Rothwell

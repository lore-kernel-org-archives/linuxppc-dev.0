Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4kTJ3X8zzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:01:56 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Thu, 04 Aug 2016 11:00:49 +0200
Message-ID: <10480058.bD2uPUOBSy@wuerfel>
In-Reply-To: <20160804101051.39ca1e26@canb.auug.org.au>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <3892328.nUGXIq3MaH@wuerfel> <20160804101051.39ca1e26@canb.auug.org.au>
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

On Thursday, August 4, 2016 10:10:51 AM CEST Stephen Rothwell wrote:
> Hi Arnd,
> 
> On Wed, 03 Aug 2016 20:52:48 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Most of the difference appears to be in branch trampolines (634 added,
> > 559 removed, 14837 unchanged) as you suspect, but I also see a couple
> > of symbols show up in vmlinux that were not there before:
> > 
> > -A __crc_dma_noop_ops
> > -D dma_noop_ops
> > -R __clz_tab
> > -r fdt_errtable
> > -r __kcrctab_dma_noop_ops
> > -r __kstrtab_dma_noop_ops
> > -R __ksymtab_dma_noop_ops
> > -t dma_noop_alloc
> > -t dma_noop_free
> > -t dma_noop_map_page
> > -t dma_noop_mapping_error
> > -t dma_noop_map_sg
> > -t dma_noop_supported
> > -T fdt_add_reservemap_entry
> > -T fdt_begin_node
> > -T fdt_create
> > -T fdt_create_empty_tree
> > -T fdt_end_node
> > -T fdt_finish
> > -T fdt_finish_reservemap
> > -T fdt_property
> > -T fdt_resize
> > -T fdt_strerror
> > -T find_cpio_data
> > 
> > From my first look, it seems that all of lib/*.o is now getting linked
> > into vmlinux, while we traditionally leave out everything from lib/
> > that is not referenced.
> 
> You could try removing the --{,no-}whole-archive arguments to ld in
> scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh.  Last time I did
> that, though, a whole lot of stuff failed to be linked in. (Especially
> stuff only referenced by EXPORT_SYMBOL()s, bu that may have been fixed).

I tried this

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index b5e40ed86e60..89bca1a25916 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -44,7 +44,7 @@ modpost_link()
 	local objects
 
 	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
-		objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
+		objects="${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
 	else
 		objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
 	fi

but that did not seem to change anything, the extra symbols are
still there. I have not tried to understand what that actually
does, so maybe I misunderstood your suggestion.

> > I also see a noticeable overhead in link time, the numbers are for
> > a cache-hot rebuild after a successful allyesconfig build, using a
> > 24-way Opteron@2.5Ghz, just relinking vmlinux:
> 
> I was afraid of that, but it is offset by the time saved by not doing
> the "ld -r"s along the way?  It may also be that (for powerpc anyway)
> the linker is doing a better job.

At least on a big SMP system, it doesn't seem to make much difference,
as the "ld -r" steps are easily parallized

$ find build/ -name built-in.o | xargs rm ; time make -skj30 vmlinux
real	2m12.092s
user	3m52.932s
sys	0m51.248s

$ time make -skj30 vmlinux
real	2m12.162s
user	3m44.788s
sys	0m47.788s

I tried this twice with identical results: "user" time increases
by eight seconds today when we have to rebuild all "built-in.o"
files rather than just relinking vmlinux, but elapsed time
is unchanged.

After your patch that difference becomes smaller (three seconds
in one run, could be within the noise), but we still have the
extra two minutes for the total build time:

$ find build/ -name built-in.o | xargs rm ; time make -skj30 vmlinux
real	4m20.717s
user	5m47.556s
sys	0m54.128s

$ time make -skj30 vmlinux
real	4m18.835s
user	5m44.552s
sys	0m53.152s

FWIW, here is a sample build output I get on an allyesconfig build,
with timestamps added:

$ time make W= -kj30 vmlinux 
make[1]: Entering directory '/git/arm-soc'
make[2]: Entering directory '/git/arm-soc/build/tmp'
10:46:12   CHK     include/config/kernel.release
10:46:13   GEN     ./Makefile
10:46:13   CHK     include/generated/uapi/linux/version.h
  Using /git/arm-soc as source for kernel
10:46:13   CHK     include/generated/utsrelease.h
10:46:13   CHK     include/generated/timeconst.h
10:46:13   CHK     include/generated/bounds.h
10:46:13   CHK     include/generated/asm-offsets.h
10:46:13   CALL    /git/arm-soc/scripts/checksyscalls.sh
10:46:14   CHK     include/generated/compile.h
10:46:18   CHK     kernel/config_data.h
10:46:20   CC      drivers/misc/lkdtm_rodata.o
10:46:20   OBJCOPY drivers/misc/lkdtm_rodata_objcopy.o
10:46:20   LD      drivers/misc/lkdtm.o
10:46:20   LD      drivers/misc/built-in.o
10:46:20   DTC     drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb
10:46:20   DTB     drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.S
10:46:20   AS      drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.o
10:46:20   LD      drivers/gpu/drm/tilcdc/built-in.o
rm drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb.S drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dtb
10:46:33   LD      drivers/gpu/drm/built-in.o
10:46:33   LD      drivers/gpu/built-in.o
10:46:36   CHK     include/generated/uapi/linux/version.h
10:46:36   LINK    vmlinux
10:46:37   LD      vmlinux.o
10:47:14   MODPOST vmlinux.o
10:47:16   GEN     .version
10:47:17   CHK     include/generated/compile.h
10:47:17   UPD     include/generated/compile.h
10:47:17   CC      init/version.o
10:47:17   LD      init/built-in.o
10:48:09   KSYM    .tmp_kallsyms1.o
10:49:19   KSYM    .tmp_kallsyms2.o
10:49:33   LD      vmlinux
10:50:27   SORTEX  vmlinux
10:50:27   SYSMAP  System.map
make[2]: Leaving directory '/git/arm-soc/build/tmp'
make[1]: Leaving directory '/git/arm-soc'

real	4m18.033s
user	5m44.728s
sys	0m52.724s

(yes, I also just realized we should fix the tilcdc and lkdtm drivers
to not force a rebuild).

	Arnd

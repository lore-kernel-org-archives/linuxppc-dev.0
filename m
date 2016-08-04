Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4mh42jXPzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 20:41:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Thu, 04 Aug 2016 12:37:41 +0200
Message-ID: <1880505.MpH3ISbtMJ@wuerfel>
In-Reply-To: <10480058.bD2uPUOBSy@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160804101051.39ca1e26@canb.auug.org.au> <10480058.bD2uPUOBSy@wuerfel>
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

On Thursday, August 4, 2016 11:00:49 AM CEST Arnd Bergmann wrote:
> I tried this
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index b5e40ed86e60..89bca1a25916 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -44,7 +44,7 @@ modpost_link()
>         local objects
>  
>         if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -               objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
> +               objects="${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
>         else
>                 objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
>         fi
> 
> but that did not seem to change anything, the extra symbols are
> still there. I have not tried to understand what that actually
> does, so maybe I misunderstood your suggestion.
> 

On a second attempt, I did the same change for vmlinux instead of the
module (d'oh), and got a link failure instead:


arch/arm/mm/proc-xscale.o: In function `cpu_xscale_do_resume':
(.text+0x3d4): undefined reference to `cpu_resume_mmu'
arch/arm/kernel/setup.o: In function `setup_arch':
setup.c:(.init.text+0x910): undefined reference to `init_uts_ns'
kernel/nsproxy.o:(.data+0x4): undefined reference to `init_uts_ns'
kernel/sched/core.o: In function `update_rq_clock':
core.c:(.text+0x6d8): undefined reference to `paravirt_steal_rq_enabled'
core.c:(.text+0x6dc): undefined reference to `pv_time_ops'
kernel/sched/cputime.o: In function `account_process_tick':
cputime.c:(.text+0x794): undefined reference to `paravirt_steal_enabled'
cputime.c:(.text+0x7a0): undefined reference to `pv_time_ops'
kernel/locking/lockdep.o: In function `save_trace':
lockdep.c:(.text+0xfe8): undefined reference to `save_stack_trace'
kernel/module.o: In function `load_module':
module.c:(.text+0x1b54): undefined reference to `elf_check_arch'
module.c:(.text+0x2024): undefined reference to `apply_relocate'
kernel/debug/debug_core.o: In function `kgdb_unregister_io_module':
debug_core.c:(.text+0x2e4): undefined reference to `kgdb_arch_exit'
kernel/debug/debug_core.o: In function `kgdb_arch_set_breakpoint':
debug_core.c:(.text+0x3bc): undefined reference to `arch_kgdb_ops'
kernel/debug/debug_core.o: In function `dbg_remove_all_break':
debug_core.c:(.text+0x6d0): undefined reference to `arch_kgdb_ops'
...

However, I also see a link failure in some rare configurations
with just your patch:

arch/arm/lib/lib.a(io-acorn.o): In function `outsl':
(.text+0x38): undefined reference to `printk'

The problem being a file in a library object that is not referenced,
but that references another symbol that is not defined
(CONFIG_PRINTK=n).

	Arnd

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DyVY3SYbzF0dq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 19:33:57 +1000 (AEST)
Subject: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
Message-ID: <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
Date: Tue, 18 Sep 2018 09:33:48 +0000
MIME-Version: 1.0
In-Reply-To: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the below patch, checkpatch reports

WARNING: struct kgdb_arch should normally be const
#127: FILE: arch/powerpc/kernel/kgdb.c:480:
+struct kgdb_arch arch_kgdb_ops;

But when I add 'const', I get compilation failure

   CC      arch/powerpc/kernel/kgdb.o
arch/powerpc/kernel/kgdb.c:480:24: error: conflicting type qualifiers 
for ‘arch_kgdb_ops’
  const struct kgdb_arch arch_kgdb_ops;
                         ^
In file included from arch/powerpc/kernel/kgdb.c:18:0:
./include/linux/kgdb.h:284:26: note: previous declaration of 
‘arch_kgdb_ops’ was here
  extern struct kgdb_arch  arch_kgdb_ops;
                           ^
make[1]: *** [arch/powerpc/kernel/kgdb.o] Error 1

Christophe

On 09/18/2018 09:26 AM, Christophe Leroy wrote:
> Generic implementation fails to remove breakpoints after init
> when CONFIG_STRICT_KERNEL_RWX is selected:
> 
> [   13.251285] KGDB: BP remove failed: c001c338
> [   13.259587] kgdbts: ERROR PUT: end of test buffer on 'do_fork_test' line 8 expected OK got $E14#aa
> [   13.268969] KGDB: re-enter exception: ALL breakpoints killed
> [   13.275099] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-g82bbb913ffd8 #860
> [   13.282836] Call Trace:
> [   13.285313] [c60e1ba0] [c0080ef0] kgdb_handle_exception+0x6f4/0x720 (unreliable)
> [   13.292618] [c60e1c30] [c000e97c] kgdb_handle_breakpoint+0x3c/0x98
> [   13.298709] [c60e1c40] [c000af54] program_check_exception+0x104/0x700
> [   13.305083] [c60e1c60] [c000e45c] ret_from_except_full+0x0/0x4
> [   13.310845] [c60e1d20] [c02a22ac] run_simple_test+0x2b4/0x2d4
> [   13.316532] [c60e1d30] [c0081698] put_packet+0xb8/0x158
> [   13.321694] [c60e1d60] [c00820b4] gdb_serial_stub+0x230/0xc4c
> [   13.327374] [c60e1dc0] [c0080af8] kgdb_handle_exception+0x2fc/0x720
> [   13.333573] [c60e1e50] [c000e928] kgdb_singlestep+0xb4/0xcc
> [   13.339068] [c60e1e70] [c000ae1c] single_step_exception+0x90/0xac
> [   13.345100] [c60e1e80] [c000e45c] ret_from_except_full+0x0/0x4
> [   13.350865] [c60e1f40] [c000e11c] ret_from_syscall+0x0/0x38
> [   13.356346] Kernel panic - not syncing: Recursive entry to debugger
> 
> This patch creates powerpc specific version of
> kgdb_arch_set_breakpoint() and kgdb_arch_remove_breakpoint()
> using patch_instruction()
> 
> Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/kgdb.h |  5 ++++-
>   arch/powerpc/kernel/kgdb.c      | 43 +++++++++++++++++++++++++++++++++--------
>   2 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/kgdb.h
> index 9db24e77b9f4..a9e098a3b881 100644
> --- a/arch/powerpc/include/asm/kgdb.h
> +++ b/arch/powerpc/include/asm/kgdb.h
> @@ -26,9 +26,12 @@
>   #define BREAK_INSTR_SIZE	4
>   #define BUFMAX			((NUMREGBYTES * 2) + 512)
>   #define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
> +
> +#define BREAK_INSTR		0x7d821008	/* twge r2, r2 */
> +
>   static inline void arch_kgdb_breakpoint(void)
>   {
> -	asm(".long 0x7d821008"); /* twge r2, r2 */
> +	asm(stringify_in_c(.long BREAK_INSTR));
>   }
>   #define CACHE_FLUSH_IS_SAFE	1
>   #define DBG_MAX_REG_NUM     70
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 35e240a0a408..59c578f865aa 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -24,6 +24,7 @@
>   #include <asm/processor.h>
>   #include <asm/machdep.h>
>   #include <asm/debug.h>
> +#include <asm/code-patching.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -144,7 +145,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>   	if (kgdb_handle_exception(1, SIGTRAP, 0, regs) != 0)
>   		return 0;
>   
> -	if (*(u32 *) (regs->nip) == *(u32 *) (&arch_kgdb_ops.gdb_bpt_instr))
> +	if (*(u32 *)regs->nip == BREAK_INSTR)
>   		regs->nip += BREAK_INSTR_SIZE;
>   
>   	return 1;
> @@ -441,16 +442,42 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>   	return -1;
>   }
>   
> +int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
> +{
> +	int err;
> +	unsigned int instr;
> +	unsigned int *addr = (unsigned int *)bpt->bpt_addr;
> +
> +	err = probe_kernel_address(addr, instr);
> +	if (err)
> +		return err;
> +
> +	err = patch_instruction(addr, BREAK_INSTR);
> +	if (err)
> +		return -EFAULT;
> +
> +	*(unsigned int *)bpt->saved_instr = instr;
> +
> +	return 0;
> +}
> +
> +int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> +{
> +	int err;
> +	unsigned int instr = *(unsigned int *)bpt->saved_instr;
> +	unsigned int *addr = (unsigned int *)bpt->bpt_addr;
> +
> +	err = patch_instruction(addr, instr);
> +	if (err)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   /*
>    * Global data
>    */
> -struct kgdb_arch arch_kgdb_ops = {
> -#ifdef __LITTLE_ENDIAN__
> -	.gdb_bpt_instr = {0x08, 0x10, 0x82, 0x7d},
> -#else
> -	.gdb_bpt_instr = {0x7d, 0x82, 0x10, 0x08},
> -#endif
> -};
> +struct kgdb_arch arch_kgdb_ops;
>   
>   static int kgdb_not_implemented(struct pt_regs *regs)
>   {
> 

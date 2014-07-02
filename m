Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by lists.ozlabs.org (Postfix) with ESMTP id D4A571A0011
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:18:22 +1000 (EST)
Message-ID: <53B3B233.5000307@hitachi.com>
Date: Wed, 02 Jul 2014 16:18:11 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH v5 1/2] kprobes/powerpc: Fix arch_deref_entry_point
 to support ABIv2
References: <1404276081.7254.1.camel@concordia>
 <20140702070022.14689.7254.stgit@kbuild-fedora.novalocal>
In-Reply-To: <20140702070022.14689.7254.stgit@kbuild-fedora.novalocal>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Anoop Thomas Mathew <atm@profoundis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-tip-commits@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
 sparse@chrisli.org, rdunlap@infradead.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 Chris Wright <chrisw@sous-sol.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, dl9pf@gmx.de,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2014/07/02 16:00), Masami Hiramatsu wrote:
> Since PowerPC64 ABIv2 doesn't have function descriptor
> any more, arch_deref_entry_point(), which returns function
> entry point from function descriptor, should be updated.

Please ignore this patch, since it is already fixed by Michael

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2f0143c91d30823f6f6e7d94d7fa818f7ab18a18

We only need 2/2.

Thank you,



> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Anoop Thomas Mathew <atm@profoundis.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/kprobes.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 90fab64..72a1034 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -491,7 +491,12 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
> +/*
> + * On PPC64 ABIv1 the function pointer actually points to the
> + * function's descriptor. The first entry in the descriptor is the
> + * address of the function text.
> + */
>  unsigned long arch_deref_entry_point(void *entry)
>  {
>  	return ((func_descr_t *)entry)->entry;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com

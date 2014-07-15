Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78D6C1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 13:19:31 +1000 (EST)
Message-ID: <1405394370.17767.7.camel@concordia>
Subject: Re: [PATCH v5 2/2] [BUGFIX] kprobes: Fix "Failed to find blacklist"
 error on ia64 and ppc64
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Tue, 15 Jul 2014 13:19:30 +1000
In-Reply-To: <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
References: <1404276081.7254.1.camel@concordia>
 <20140702070029.14689.18485.stgit@kbuild-fedora.novalocal>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H.
 Peter Anvin" <hpa@zytor.com>, akataria@vmware.com,
 linux-tip-commits@vger.kernel.org, anil.s.keshavamurthy@intel.com,
 Ingo Molnar <mingo@kernel.org>, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-02 at 07:00 +0000, Masami Hiramatsu wrote:
> On ia64 and ppc64, the function pointer does not point the
> entry address of the function, but the address of function
> discriptor (which contains the entry address and misc
> data.) Since the kprobes passes the function pointer stored
> by NOKPROBE_SYMBOL() to kallsyms_lookup_size_offset() for
> initalizing its blacklist, it fails and reports many errors
> as below.
> 
>   Failed to find blacklist 0001013168300000
>   Failed to find blacklist 0001013000f0a000
>   Failed to find blacklist 000101315f70a000
>   Failed to find blacklist 000101324c80a000
>   Failed to find blacklist 0001013063f0a000
>   Failed to find blacklist 000101327800a000
>   Failed to find blacklist 0001013277f0a000
>   Failed to find blacklist 000101315a70a000
>   Failed to find blacklist 0001013277e0a000
>   Failed to find blacklist 000101305a20a000
>   Failed to find blacklist 0001013277d0a000
>   Failed to find blacklist 00010130bdc0a000
>   Failed to find blacklist 00010130dc20a000
>   Failed to find blacklist 000101309a00a000
>   Failed to find blacklist 0001013277c0a000
>   Failed to find blacklist 0001013277b0a000
>   Failed to find blacklist 0001013277a0a000
>   Failed to find blacklist 000101327790a000
>   Failed to find blacklist 000101303140a000
>   Failed to find blacklist 0001013a3280a000
> 
> To fix this bug, this introduces function_entry() macro to
> retrieve the entry address from the given function pointer,
> and uses for kallsyms_lookup_size_offset() while initializing
> blacklist.
> 
> Changes in v5:
>  - Use arch_deref_entry_point() instead of function_entry().
> 
> Changes in v4:
>  - Add kernel_text_address() check for verifying the address.
>  - Moved on the latest linus tree.
> 
> Changes in v3:
>  - Fix a bug to get blacklist address based on function entry
>    instead of function descriptor. (Suzuki's work, Thanks!)
> 
> Changes in V2:
>  - Use function_entry() macro when lookin up symbols instead
>    of storing it.
>  - Update for the latest -next.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Reported-by: Tony Luck <tony.luck@gmail.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)

Ben, can you take this in your tree?

cheers

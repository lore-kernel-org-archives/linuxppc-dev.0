Return-Path: <compudj@krystal.dyndns.org>
Received: from toq4-srv.bellnexxia.net (toq4.bellnexxia.net [209.226.175.24])
	by ozlabs.org (Postfix) with ESMTP id 9A855DDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 08:16:20 +1000 (EST)
Received: from krystal.dyndns.org ([76.65.100.86])
	by tomts25-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070705205004.HOJI25739.tomts25-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 16:50:04 -0400
Date: Thu, 5 Jul 2007 16:50:03 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: akpm@linux-foundation.org
Subject: Re: + add-missing-data_data-in-powerpc.patch added to -mm tree
Message-ID: <20070705205003.GD1341@Krystal>
References: <200707052023.l65KNoYF017223@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707052023.l65KNoYF017223@imap1.linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, mm-commits@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please add to patch header: 

Newer asm-generic/vmlinux.lds.h provides a DATA_DATA macro which defines
the content of what is normally referred to by *(.data). It permits
adding more "subsections" (declared by gcc with the section attribute or
in assembly), whichwill be linked in the .data section.

* akpm@linux-foundation.org (akpm@linux-foundation.org) wrote:
> 
> The patch titled
>      powerpc: add missing DATA_DATA
> has been added to the -mm tree.  Its filename is
>      add-missing-data_data-in-powerpc.patch
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: powerpc: add missing DATA_DATA
> From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> Cc: <paulus@samba.org>
> Cc: <linuxppc-dev@ozlabs.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/kernel/vmlinux.lds.S |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff -puN arch/powerpc/kernel/vmlinux.lds.S~add-missing-data_data-in-powerpc arch/powerpc/kernel/vmlinux.lds.S
> --- a/arch/powerpc/kernel/vmlinux.lds.S~add-missing-data_data-in-powerpc
> +++ a/arch/powerpc/kernel/vmlinux.lds.S
> @@ -174,7 +174,9 @@ SECTIONS
>  	}
>  #else
>  	.data : {
> -		*(.data .data.rel* .toc1)
> +		DATA_DATA
> +		*(.data.rel*)
> +		*(.toc1)
>  		*(.branch_lt)
>  	}
>  
> _
> 
> Patches currently in -mm which might be from mathieu.desnoyers@polymtl.ca are
> 
> powerpc-promc-remove-undef-printk.patch
> i386-text-edit-lock.patch
> i386-text-edit-lock-alternative-instructions.patch
> i386-text-edit-lock-kprobes.patch
> immediate-values-global-modules-list-and-module-mutex.patch
> immediate-value-architecture-independent-code.patch
> immediate-values-non-optimized-architectures.patch
> immediate-value-add-kconfig-menus.patch
> immediate-values-kprobe-header-fix.patch
> immediate-value-i386-optimization.patch
> immediate-value-powerpc-optimization.patch
> immediate-value-documentation.patch
> f00f-bug-fixup-for-i386-use-immediate-values.patch
> scheduler-profiling-use-immediate-values.patch
> use-data_data-in-cris.patch
> add-missing-data_data-in-powerpc.patch
> use-data_data-in-xtensa.patch
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

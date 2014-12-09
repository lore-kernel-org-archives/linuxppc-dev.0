Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD2261A050B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:03:07 +1100 (AEDT)
In-Reply-To: <1418020212-4303-4-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [4/5] powerpc, dscr: Added some in-code documentation
Message-Id: <20141209100307.ACBE41400DE@ozlabs.org>
Date: Tue,  9 Dec 2014 21:03:07 +1100 (AEDT)
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-12 at 06:30:11 UTC, Anshuman Khandual wrote:
> This patch adds some in-code documentation to the DSCR related
> code to make it more readable without having any functional
> change to it.

Adding documentation is always good, but ...

> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index dda7ac4..81c1aeb 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -295,6 +295,14 @@ struct thread_struct {
>  #endif
>  #ifdef CONFIG_PPC64
>  	unsigned long	dscr;
> +	/*
> +	 * XXX: dscr_inherit indicates that the process has explicitly

Please don't use XXX as a matter of practice.

It should be saved for *really* tricky/complicated code, and this isn't that.

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 67fd2fd..edde3f0 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -496,8 +496,21 @@ static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>  static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>  
> +/*
> + * XXX: This is the system wide DSCR register default value.
> + * Any change to this value through the sysfs interface will
> + * update all per-cpu DSCR default values across the system
> + * stored in their respective PACA structures.
> + */
>  static unsigned long dscr_default;

Yeah it seems you're right, writing updates the values in all pacas, reading
returns the value in the current cpu's paca. So why do we need this copy of the
value?

> +/*
> + * XXX: read_dscr and write_dscr are the functions for the
> + * per-cpu DSCR default sysfs files present for each cpu.
> + * Though updates to per-cpu DSCR value also gets called
> + * for all the CPUs on the system when the system wide
> + * global dscr_default gets changed.
> + */
>  static void read_dscr(void *val)
>  {

Please make these proper kernel-doc comments. I've definitely asked you to do
that at least once before on a different patch, to check you can do:

$ ./scripts/kernel-doc -text arch/powerpc/kernel/sysfs.c

The comments for write_dscr() should be attached to that function.

cheers

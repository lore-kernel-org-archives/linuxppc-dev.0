Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A657CDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 23:59:18 +1100 (EST)
Message-ID: <47A85DD8.4080300@ru.mvista.com>
Date: Tue, 05 Feb 2008 16:00:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-mm1: ppc32: too few arguments to function 'reserve_bootmem'
References: <20080203171634.58ab668b.akpm@linux-foundation.org>	<200802042129.03065.m.kozlowski@tuxland.pl>
	<20080204144036.cf22a402.akpm@linux-foundation.org>
In-Reply-To: <20080204144036.cf22a402.akpm@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	paulus@samba.org, bwalle@suse.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Andrew Morton wrote:

>>	This is from ppc32:

>>  CC      arch/powerpc/mm/mem.o
>>arch/powerpc/mm/mem.c: In function 'do_init_bootmem':
>>arch/powerpc/mm/mem.c:256: error: too few arguments to function 'reserve_bootmem'
>>arch/powerpc/mm/mem.c:261: error: too few arguments to function 'reserve_bootmem'

>>Leftover from introduce-flags-for-reserve_bootmem.patch?

> Yes, I've had to fix that patch many times.

> --- a/arch/powerpc/mm/mem.c~introduce-flags-for-reserve_bootmem-powerpc-fix
> +++ a/arch/powerpc/mm/mem.c
> @@ -253,12 +253,13 @@ void __init do_init_bootmem(void)
>  				     lmb_size_bytes(&lmb.reserved, i) - 1;
>  		if (addr < total_lowmem)
>  			reserve_bootmem(lmb.reserved.region[i].base,
> -					lmb_size_bytes(&lmb.reserved, i));
> +					lmb_size_bytes(&lmb.reserved, i),
> +					BOOTMEM_DEFAULT);
>  		else if (lmb.reserved.region[i].base < total_lowmem) {
>  			unsigned long adjusted_size = total_lowmem -
>  				      lmb.reserved.region[i].base;
>  			reserve_bootmem(lmb.reserved.region[i].base,
> -					adjusted_size);
> +					adjusted_size, BOOTMEM_DWEFAULT);

    BOOTMEM_DWEFAULT, are you sure? :-)

WBR, Sergei

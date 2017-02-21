Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS7d129SvzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:01:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc/xmon: Dump memory in native endian format.
In-Reply-To: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
References: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 16:01:22 +1100
Message-ID: <87shn8m925.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Douglas Miller <dougmill@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 9c0e17c..6249975 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2334,9 +2338,49 @@ static void dump_pacas(void)
>  }
>  #endif
>  
> +static void dump_by_size(unsigned long addr, long count, int size)
> +{
> +	unsigned char temp[16];
> +	int i, j;
> +	u64 val;
> +
> +	/*
> +	 * 'count' was aligned 16. If that changes, the following
> +	 * must also change to accommodate other values for 'count'.
> +	 */
> +	for (i = 0; i < count; i += 16, addr += 16) {
> +		printf(REG, addr);
> +
> +		if (mread(addr, temp, 16) != 16) {
> +			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
> +			return;
> +		}
> +
> +		for (j = 0; j < 16; j += size) {
> +			putchar(' ');
> +			switch (size) {
> +			case 1: val = temp[j]; break;
> +			case 2: val = *(u16 *)&temp[j]; break;
> +			case 4: val = *(u32 *)&temp[j]; break;
> +			case 8: val = *(u64 *)&temp[j]; break;
> +			default: val = 0;
> +			}
> +
> +			printf("%0*lx", size * 2, val);
> +		}
> +		printf("  |");
> +		for (j = 0; j < 16; ++j) {
> +			val = temp[j];
> +			putchar(' ' <= val && val <= '~' ? val : '.');
> +		}
> +		printf("|\n");

I know the ascii dump looks nice, but I think it's misleading. Which is
why I omitted it from my version.

eg.

0:mon> d $__kstrtab_init_task
c000000000c03ebe 696e69745f746173 6b006d6d755f6665  |init_task.mmu_fe|
c000000000c03ece 61747572655f6b65 7973006370755f66  |ature_keys.cpu_f|
c000000000c03ede 6561747572655f6b 657973006375725f  |eature_keys.cur_|
c000000000c03eee 6370755f73706563 00766972715f746f  |cpu_spec.virq_to|

0:mon> d8 $__kstrtab_init_task
c000000000c03ebe 7361745f74696e69 65665f756d6d006b  |init_task.mmu_fe|
c000000000c03ece 656b5f6572757461 665f757063007379  |ature_keys.cpu_f|
c000000000c03ede 6b5f657275746165 5f72756300737965  |eature_keys.cur_|
c000000000c03eee 636570735f757063 6f745f7172697600  |cpu_spec.virq_to|


That second dump says at c000000000c03ebe there is a byte with the value
0x73, which prints as 'i' - but that's false.


So I've dropped the ascii printing for now because I want to sneak this
in to v4.11.

If you want to send a follow-up patch to do the ascii byte reversed that
would be nice.

cheers

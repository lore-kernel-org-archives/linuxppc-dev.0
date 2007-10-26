Return-Path: <manuel.pezzin@free.fr>
Message-ID: <47223555.8090103@free.fr>
Date: Fri, 26 Oct 2007 20:43:33 +0200
From: manu <manuel.pezzin@free.fr>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: Re: problems to boot 2.6.23 kernel on XILINX ppc with 8Mbytes of RAM
References: <471FA48B.2020809@free.fr> <47203EF9.1070906@omnisys.se>
In-Reply-To: <47203EF9.1070906@omnisys.se>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Magnus,
your patch solved the problem.
Thank you.

Manu

Magnus Hjorth a écrit :
> Hello Manu,
>
> Could you try the attached patch to arch/ppc/mm/4xx_mmu.c and see if
> it solves your problem?
>
> Best regards,
> Magnus
>
>
> manu wrote:
>> Hello,
>> I work on a custom board based on a virtex 2 pro FPGA and 8Mbytes of
>> SDRAM.
>> Untill now I used a 2.4.31 linux ppc kernel with John Williams patches
>> and uclinux distribution and everything worked perfectly.
>> I've decided to move to the latest 2.6 version from kernel.org
>> (2.6.23.1) with an initramfs containing a busybox.
>> My complete zImage including the initramfs has a size of 900Kbytes.
>> I made some tests with a ML300 board and I managed to get a shell
>> easily.
>> When I migrated to the custom board, I had the "Now booting the kernel"
>> message and then nothing.
>> When I trace the code running on the ppc with the debugger, execution
>> seems to be stuck in some early initialization code.
>> I managed to reproduce the problem on the ML300 using "mem=8m" parameter
>> on the bootline.
>> With "mem=16m" the kernel boots correctly.
>> I'm really surprised by the amount of RAM required to boot the kernel.
>> Is there a way to make it boot with only 8Mbytes of RAM ?
>> Thanks for your help.
>>
>> Manu
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>   
>
>
> ------------------------------------------------------------------------
>
> --- 4xx_mmu_old.c	2007-10-25 08:54:46.000000000 +0200
> +++ 4xx_mmu.c	2007-10-25 08:55:57.000000000 +0200
> @@ -105,7 +105,7 @@
>  		return s;
>  	}
>  
> -	while (s <= (total_lowmem - LARGE_PAGE_SIZE_16M)) {
> +	while (s + LARGE_PAGE_SIZE_16M <= total_lowmem) {
>  		pmd_t *pmdp;
>  		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
>  
> @@ -120,7 +120,7 @@
>  		s += LARGE_PAGE_SIZE_16M;
>  	}
>  
> -	while (s <= (total_lowmem - LARGE_PAGE_SIZE_4M)) {
> +	while (s + LARGE_PAGE_SIZE_4M <= total_lowmem) {
>  		pmd_t *pmdp;
>  		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
>  
>   

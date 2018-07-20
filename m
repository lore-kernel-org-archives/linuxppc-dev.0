Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X8Xs0JYWzDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 21:58:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, malat@debian.org
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
In-Reply-To: <da5b3f3d-73f8-c21b-3c90-65fe33afbf97@infradead.org>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <da5b3f3d-73f8-c21b-3c90-65fe33afbf97@infradead.org>
Date: Fri, 20 Jul 2018 21:58:19 +1000
Message-ID: <87va9a86g4.fsf@concordia.ellerman.id.au>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> On 07/09/2018 07:24 AM, Michael Ellerman wrote:
>> Because the allmodconfig logic just sets every symbol to M or Y, it
>> has the effect of always generating a 64-bit config, because
>> CONFIG_PPC64 becomes Y.
>> 
>> So to make it easier for folks to test 32-bit code, provide a phony
>> defconfig target that generates a 32-bit allmodconfig.
>> 
>> The 32-bit port has several mutually exclusive CPU types, we choose
>> the Book3S variants as that's what the help text in Kconfig says is
>> most com
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Hi Michael,
>
> Sorry for the delay.  I was traveling (out in the boonies).
>
> I'm trying to use 'make ppc32_allmodconfig'.  Cross-building on x86_64
> with crosstools from kernel.org.  (gcc 8.1.0)
>
> I'm getting build errors.  Looks like it's missing a header file or 3.
> I looked into that but it's a long and twisty maze of passages.
> Any ideas?

Urk.

That code was really written for 64-bit and we haven't ever quite made
it fully generic, as you can see.

Christophe got it working for 8xx (a different 32-bit variant), but
clearly it doesn't work for this config.

This might be the solution for now:

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c45424c64e19..cb406d00702c 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -362,6 +362,7 @@ config FAIL_IOMMU
 config PPC_PTDUMP
         bool "Export kernel pagetable layout to userspace via debugfs"
         depends on DEBUG_KERNEL && DEBUG_FS
+        depends on PPC64 || PPC_8xx
         help
 	  This option exports the state of the kernel pagetables to a
 	  debugfs file. This is only useful for kernel developers who are


cheers

>   CC      arch/powerpc/mm/dump_linuxpagetables.o
> In file included from ../arch/powerpc/include/asm/book3s/pgtable.h:8,
>                  from ../arch/powerpc/include/asm/pgtable.h:18,
>                  from ../include/linux/hugetlb.h:12,
>                  from ../arch/powerpc/mm/dump_linuxpagetables.c:19:
> ../arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
> ../arch/powerpc/include/asm/book3s/32/pgtable.h:53:19: error: 'PKMAP_BASE' undeclared (first use in this function); did you mean 'AT_BASE'?
>  #define KVIRT_TOP PKMAP_BASE
>                    ^~~~~~~~~~
> ../arch/powerpc/include/asm/book3s/32/pgtable.h:64:23: note: in expansion of macro 'KVIRT_TOP'
>  #define IOREMAP_TOP ((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
>                        ^~~~~~~~~
> ../arch/powerpc/mm/dump_linuxpagetables.c:456:39: note: in expansion of macro 'IOREMAP_TOP'
>   address_markers[i++].start_address = IOREMAP_TOP;
>                                        ^~~~~~~~~~~
> ../arch/powerpc/include/asm/book3s/32/pgtable.h:53:19: note: each undeclared identifier is reported only once for each function it appears in
>  #define KVIRT_TOP PKMAP_BASE
>                    ^~~~~~~~~~
> ../arch/powerpc/include/asm/book3s/32/pgtable.h:64:23: note: in expansion of macro 'KVIRT_TOP'
>  #define IOREMAP_TOP ((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
>                        ^~~~~~~~~
> ../arch/powerpc/mm/dump_linuxpagetables.c:456:39: note: in expansion of macro 'IOREMAP_TOP'
>   address_markers[i++].start_address = IOREMAP_TOP;
>                                        ^~~~~~~~~~~
> ../arch/powerpc/mm/dump_linuxpagetables.c:464:39: error: implicit declaration of function 'PKMAP_ADDR'; did you mean 'PCI_IO_ADDR'? [-Werror=implicit-function-declaration]
>   address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
>                                        ^~~~~~~~~~
>                                        PCI_IO_ADDR
> ../arch/powerpc/mm/dump_linuxpagetables.c:464:50: error: 'LAST_PKMAP' undeclared (first use in this function); did you mean 'LIST_HEAD'?
>   address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
>                                                   ^~~~~~~~~~
>                                                   LIST_HEAD
>
>
>
> Thanks.
>
>> ---
>>  arch/powerpc/Makefile                 | 5 +++++
>>  arch/powerpc/configs/book3s_32.config | 2 ++
>>  2 files changed, 7 insertions(+)
>>  create mode 100644 arch/powerpc/configs/book3s_32.config
>> 
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 2ea575cb3401..2556c2182789 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
>>  	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
>>  		86xx-smp 86xx-hw fsl-emb-nonhw)
>>  
>> +PHONY += ppc32_allmodconfig
>> +ppc32_allmodconfig:
>> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
>> +		-f $(srctree)/Makefile allmodconfig
>> +
>>  define archhelp
>>    @echo '* zImage          - Build default images selected by kernel config'
>>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
>> diff --git a/arch/powerpc/configs/book3s_32.config b/arch/powerpc/configs/book3s_32.config
>> new file mode 100644
>> index 000000000000..8721eb7b1294
>> --- /dev/null
>> +++ b/arch/powerpc/configs/book3s_32.config
>> @@ -0,0 +1,2 @@
>> +CONFIG_PPC64=n
>> +CONFIG_PPC_BOOK3S_32=y
>> 
>
>
> -- 
> ~Randy

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvYT82SCwzF07g
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 06:46:50 +1100 (AEDT)
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
To: Michael Ellerman <mpe@ellerman.id.au>, Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
 <87lgf8gley.fsf@concordia.ellerman.id.au>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <8be155ab-ec2c-2b1e-89a2-02f8e9f0d0ba@c-s.fr>
Date: Sun, 4 Mar 2018 20:46:44 +0100
MIME-Version: 1.0
In-Reply-To: <87lgf8gley.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/03/2018 à 11:55, Michael Ellerman a écrit :
> Mathieu Malaterre <malat@debian.org> writes:
> 
>> Rewrite comparison since all values compared are of type `unsigned long`.
>>
>> Fix a warning (treated as error in W=1):
>>
>>    CC      arch/powerpc/kernel/irq.o
>> In file included from ./include/linux/bug.h:5:0,
>>                   from ./include/linux/cpumask.h:13,
>>                   from ./include/linux/smp.h:13,
>>                   from ./include/linux/kernel_stat.h:5,
>>                   from arch/powerpc/kernel/irq.c:35:
>> ./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
>> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>>   #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>>                                  ^
>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/page.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 8da5d4c1cab2..19dea64e7ed2 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>>   
>>   #ifdef CONFIG_FLATMEM
>>   #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
>> -#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>> +#define pfn_valid(pfn) \
>> +		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
> 
> I'm not a big fan of this one, because the original code is *far* more
> obvious as to what it's doing.
> 
> I'm not sure if we can make this one a static inline, or whether that
> would help, but it would be worth investigating.
> 

The following seems to give a good result:

diff --git a/arch/powerpc/include/asm/page.h 
b/arch/powerpc/include/asm/page.h
index 8da5d4c1cab2..6f74938483b7 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -126,7 +126,15 @@ extern long long virt_phys_offset;

  #ifdef CONFIG_FLATMEM
  #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#ifndef __ASSEMBLY__
+extern unsigned long max_mapnr;
+static inline bool pfn_valid(unsigned long pfn)
+{
+	unsigned long min_pfn = ARCH_PFN_OFFSET;
+
+	return pfn >= min_pfn && pfn < max_mapnr;
+}
+#endif
  #endif

  #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)


Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

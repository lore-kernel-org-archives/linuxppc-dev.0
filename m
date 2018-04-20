Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SGj124XYzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 23:21:40 +1000 (AEST)
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <5b495777-311b-ae81-6e07-6ae68f6da2b9@c-s.fr>
 <20180420203658.73100c8b@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a8dc55d9-e732-efab-6a9a-239a53aff96a@c-s.fr>
Date: Fri, 20 Apr 2018 15:21:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180420203658.73100c8b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/04/2018 à 12:36, Nicholas Piggin a écrit :
> On Fri, 20 Apr 2018 12:01:34 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 20/04/2018 à 09:34, Nicholas Piggin a écrit :
>>> This requires further changes to linker script to KEEP some tables
>>> and wildcard compiler generated sections into the right place. This
>>> includes pp32 modifications from Christophe Leroy.
>>>
>>> When compiling powernv_defconfig with this option:
>>>
>>> text       data      bss       dec        filename
>>> 11827621   4810490   1341080   17979191   vmlinux
>>> 11752437   4598858   1338776   17690071   vmlinux.dcde
>>>
>>> Resulting kernel is almost 400kB smaller (and still boots).
>>>
>>> [ppc32 numbers here]

Here a few results, obtained with readelf -l vmlinux | grep LOAD

First val is filesz, second is memsz, for each config you get the size 
before and after activation of LD_DCDE, and the difference between the two.

mpc83xx_defconfig:
Before: 0x5ecfe0 0x60b69c
After:  0x5d2fe0 0x5f04a4
Diff:   0x01a000 0x01b4c8

mpc83xx_defconfig without CONFIG_MODULE:
Before: 0x5c1040 0x5e0614
After:  0x55f040 0x57d314
Diff:   0x062000 0x063300

mpc885_ads_defconfig:
Before: 0x36eda4 0x38da04
After:  0x316da4 0x333764
Diff:   0x058000 0x05a2a0

Custom mpc885 config:
Before: 0x719948 0x78bc34
After:  0x6b9948 0x72a99c
Diff:   0x060000 0x061298

Custom mpc8321 config:
Before: 0x70f714 0x7d766c
After:  0x6af714 0x7763ec
Diff:   0x060000 0x061280



>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    arch/powerpc/Kconfig              |  1 +
>>>    arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++++++-----------
>>>    2 files changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index c32a181a7cbb..ee6dbe2efc8b 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -205,6 +205,7 @@ config PPC
>>>    	select HAVE_KPROBES
>>>    	select HAVE_KPROBES_ON_FTRACE
>>>    	select HAVE_KRETPROBES
>>> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>>>    	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
>>>    	select HAVE_MEMBLOCK
>>>    	select HAVE_MEMBLOCK_NODE_MAP
>>> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
>>> index c8af90ff49f0..89381dc959ce 100644
>>> --- a/arch/powerpc/kernel/vmlinux.lds.S
>>> +++ b/arch/powerpc/kernel/vmlinux.lds.S
>>> @@ -89,7 +89,7 @@ SECTIONS
>>>    	 */
>>>    	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
>>>    #ifdef CONFIG_LD_HEAD_STUB_CATCH
>>> -		*(.linker_stub_catch);
>>> +		KEEP(*(.linker_stub_catch));
>>>    		. = . ;
>>>    #endif
>>>    
>>> @@ -98,7 +98,7 @@ SECTIONS
>>>    		ALIGN_FUNCTION();
>>>    #endif
>>>    		/* careful! __ftr_alt_* sections need to be close to .text */
>>> -		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
>>> +		*(.text.hot .text .text.[0-9a-zA-Z_]* .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
>>
>> Why not use TEXT_MAIN here instead of .text .text.[0-9a-zA-Z_]* ?
> 
> It's from my early patch before we added those in the generic linker
> script. Yes your version looks nicer.
> 
> Thanks,
> Nick
> 

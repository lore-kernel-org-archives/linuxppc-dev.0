Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 5802C1A017C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 23:34:57 +1100 (AEDT)
Subject: Re: [PATCH v2 05/25] powerpc/8xx: Fix vaddr for IMMR early remap
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <83ffd345e7a3fe00443e32b6caf900e7618453d6.1442939410.git.christophe.leroy@c-s.fr>
 <20150928233900.GB6161@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <561662ED.1040103@c-s.fr>
Date: Thu, 8 Oct 2015 14:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <20150928233900.GB6161@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/09/2015 01:39, Scott Wood a écrit :
> On Tue, Sep 22, 2015 at 06:50:38PM +0200, Christophe Leroy wrote:
>> Memory: 124428K/131072K available (3748K kernel code, 188K rwdata,
>> 648K rodata, 508K init, 290K bss, 6644K reserved)
>> Kernel virtual memory layout:
>>    * 0xfffdf000..0xfffff000  : fixmap
>>    * 0xfde00000..0xfe000000  : consistent mem
>>    * 0xfddf6000..0xfde00000  : early ioremap
>>    * 0xc9000000..0xfddf6000  : vmalloc & ioremap
>> SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>>
>> Mapping IMMR 1:1 is just wrong because it may overlap with another
>> area. On most mpc8xx boards it is OK because IMMR is set to
>> 0xff000000 but for instance on EP88xC board, IMMR is at 0xfa200000
>> which overlaps with VM ioremap area
>>
>> This patch fixes the virtual address for remapping IMMR to 0xff000000,
>> regardless of the value of IMMR.
>>
>> The size of IMMR area is 256kbytes (CPM at offset 0, security engine
>> at offset 128) so 512kbytes is enough and allows to handle the EP88xC
>> case (which is not 8Mbytes but only 2Mbytes aligned) the same way.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Instead of hardcoding 0xff000000, can you use asm/fixmap.h to allocate a
> virtual address at compile time?
>
>
Yes good idea, but in asm/fixmap.h FIX_XXXX constants are defined as enums.
Is there a way to use them in head_8xx.S ?

Christophe

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xdqj61L7zDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 21:10:41 +1000 (AEST)
Subject: Re: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of
 __ioremap(_PAGE_NO_CACHE)
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
 <20180824110548.GV24439@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <78342b34-1a47-26a5-1636-0f7f64588c73@c-s.fr>
Date: Fri, 24 Aug 2018 13:10:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180824110548.GV24439@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/08/2018 à 13:05, Segher Boessenkool a écrit :
> On Fri, Aug 24, 2018 at 10:16:22AM +0000, Christophe Leroy wrote:
>> _PAGE_NO_CACHE is a target specific flag. Prefer generic functions.
> 
>>   #ifdef CONFIG_PPC
>> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
>> +	p->screen_base = ioremap_wc(addr, 0x200000);
>>   #else
> 
> But that is not the same.  I think you want ioremap_nocache?
> 
> 

No, ioremap_nocache() is _PAGE_NO_CACHE | _PAGE_GUARDED



/arch/powerpc/include/asm/io.h

#define ioremap_nocache(addr, size)	ioremap((addr), (size))


/arch/powerpc/mm/pgtable_32.c:

void __iomem *
ioremap_wc(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
				__builtin_return_address(0));
}

void __iomem *
ioremap(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
				__builtin_return_address(0));
}

Christophe

Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 88319DDF26
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 16:48:23 +1000 (EST)
Message-ID: <48803D3C.5020608@coritel.it>
Date: Fri, 18 Jul 2008 08:50:36 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: how to allocate 9MB of memory in kernel ?
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com>
In-Reply-To: <18522535.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan ha scritto:
> This i am not very sure with  :-
> Can we allocate 9MB using vmalloc and assure it to be low memory and not
> highmem ?

Why do you need only low memory? And why do you need to allocate memory? 
If I understood correctly you need only to "ioremap" a chunk of memory.

> can we ioremap 9 MB SDRAM to kernel virtual ?

Yep.

> can we use vmalloc and do mmap to that allocated memory ,if the pages are
> not continues then is it going to concern mapping to user space ?

The "contiguous" problem is related only to DMA operations.

> 
> ---Misbah <><
> 
> 
> 
> Arnd Bergmann wrote:
>> On Thursday 17 July 2008, Misbah khan wrote:
>>> I need to allocate 9 MB of memory in to the kernel space which i need to
>>> mmap for the application to access.
>>>
>>> I need to know what could be the best possible way of doing the same.
>>>
>> If you don't need the memory to be physically contiguous, you can use
>> vmalloc to get the memory, but then you need to use remap_vmalloc_range
>> for mapping the memory into a user address space.
>>
>> 	Arnd <><
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
> 


-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838

Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BB2A1DE053
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 18:48:55 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJle0-0006Vg-78
	for linuxppc-embedded@ozlabs.org; Fri, 18 Jul 2008 01:48:52 -0700
Message-ID: <18525063.post@talk.nabble.com>
Date: Fri, 18 Jul 2008 01:48:52 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <48803D3C.5020608@coritel.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


In our implimentation we have 9MB sdram which we want our application to
directly access 3 MB at a time due to following reasons :-
1. We dont want our application to make a read call and copy to user 3 MB
and go for context switching ?
2. We thought mmap could be a better solution to this as only one thread
will act upon it and also we planed to have a circular buffer in the kernel
having 3 frame of 3 MB size of the total 9MB ,each time we will block on
read and get the read index and copy the frame of data for user application
to process . We want our kernel circular buffer shared 
3. In order to avoid switching we are going for circular buffer mapping to
user space .
4. Now we want our 9MB SDRAM to point to the kernel circular buffer we want
our circular buffer to be mapped to continues paged so that we could map it
to user space.

Now my concern is How can i map SDRAM one to one to circular buffer of such
a huge size ???? 

My idea is that i will ioreamp SDRAM and do memcpy_toio() when ever i am
writing to the the circular buffer which is dma allocated and pages are set
reserved . and read the frame from user space .

I may be totally wrong in the idea thats why i need your experience and
suggession in this matter .

I hope i have answered to your concern including shiva's.

----- Misbah <><

Marco Stornelli wrote:
> 
> Misbah khan ha scritto:
>> This i am not very sure with  :-
>> Can we allocate 9MB using vmalloc and assure it to be low memory and not
>> highmem ?
> 
> Why do you need only low memory? And why do you need to allocate memory? 
> If I understood correctly you need only to "ioremap" a chunk of memory.
> 
>> can we ioremap 9 MB SDRAM to kernel virtual ?
> 
> Yep.
> 
>> can we use vmalloc and do mmap to that allocated memory ,if the pages are
>> not continues then is it going to concern mapping to user space ?
> 
> The "contiguous" problem is related only to DMA operations.
> 
>> 
>> ---Misbah <><
>> 
>> 
>> 
>> Arnd Bergmann wrote:
>>> On Thursday 17 July 2008, Misbah khan wrote:
>>>> I need to allocate 9 MB of memory in to the kernel space which i need
>>>> to
>>>> mmap for the application to access.
>>>>
>>>> I need to know what could be the best possible way of doing the same.
>>>>
>>> If you don't need the memory to be physically contiguous, you can use
>>> vmalloc to get the memory, but then you need to use remap_vmalloc_range
>>> for mapping the memory into a user address space.
>>>
>>> 	Arnd <><
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>>
>> 
> 
> 
> -- 
> Marco Stornelli
> Embedded Software Engineer
> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
> http://www.coritel.it
> 
> marco.stornelli@coritel.it
> +39 06 72582838
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18525063.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

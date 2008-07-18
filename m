Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 30437DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 14:45:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJhpy-0006zp-5A
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 21:44:58 -0700
Message-ID: <18522535.post@talk.nabble.com>
Date: Thu, 17 Jul 2008 21:44:58 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <200807170956.52101.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This i am not very sure with  :-
Can we allocate 9MB using vmalloc and assure it to be low memory and not
highmem ?
can we ioremap 9 MB SDRAM to kernel virtual ?
can we use vmalloc and do mmap to that allocated memory ,if the pages are
not continues then is it going to concern mapping to user space ?

---Misbah <><



Arnd Bergmann wrote:
> 
> On Thursday 17 July 2008, Misbah khan wrote:
>> I need to allocate 9 MB of memory in to the kernel space which i need to
>> mmap for the application to access.
>> 
>> I need to know what could be the best possible way of doing the same.
>> 
> 
> If you don't need the memory to be physically contiguous, you can use
> vmalloc to get the memory, but then you need to use remap_vmalloc_range
> for mapping the memory into a user address space.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18522535.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

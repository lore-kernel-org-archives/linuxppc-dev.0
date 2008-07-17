Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5C646DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 18:19:17 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJOhl-0005dY-7J
	for linuxppc-embedded@ozlabs.org; Thu, 17 Jul 2008 01:19:13 -0700
Message-ID: <18503765.post@talk.nabble.com>
Date: Thu, 17 Jul 2008 01:19:13 -0700 (PDT)
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


vmalloc can only allocate 128k i guess where in i need 9MB allocated when
driver is inserted and would be released only when its removed. mapping to
user space is not a concern 

--- Misbah <><


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
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18503765.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

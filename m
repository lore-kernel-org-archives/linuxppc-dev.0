Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id AE8FFDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 17:30:39 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLYo0-00059H-Rn
	for linuxppc-embedded@ozlabs.org; Wed, 23 Jul 2008 00:30:36 -0700
Message-ID: <18605418.post@talk.nabble.com>
Date: Wed, 23 Jul 2008 00:30:36 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <200807221712.52030.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com> <200807221131.32556.arnd@arndb.de>
	<4885AC94.7050501@coritel.it> <18587466.post@talk.nabble.com>
	<200807221712.52030.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



If you SDRAM is you main memory, you need vmalloc and remap_vmalloc_range.
If the SDRAM is not your main memory but some I/O attached buffer, you need
ioremap/of_iomap and remap_pfn_range.

My SDRAM is the main memory of which 9MB i have to allocate in the driver. 

If i allocate 9BM using vmalloc and remap to user space how should it
address to the 9MB 
SDRAM contigues address which i need to map for user access ? 


Arnd Bergmann wrote:
> 
> On Tuesday 22 July 2008, Misbah khan wrote:
>> First of all let me thank you for your valuable suggessions ...
>> 
>> 1. I wanted to allocate 9MB in kernel and wanted that memory to be mapped
>> to
>> the physically continews SDRAM memory. but till now i could not found a
>> way
>> to do so ???
>> 
>> 2. So i thought to use ioremap to map SDRAM and make it accessible to
>> user
>> using mmap technique but there is only one doubt and that is will it be
>> secure and stable and whether it is a right way of doing ???
> 
> As I have told you a few times now, you *either* allocate the memory *or*
> ioremap it, NOT BOTH!!!
> 
> If you SDRAM is you main memory, you need vmalloc and remap_vmalloc_range.
> If the SDRAM is not your main memory but some I/O attached buffer, you
> need
> ioremap/of_iomap and remap_pfn_range.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18605418.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

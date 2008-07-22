Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 017A6DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 23:22:48 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLHpF-0000mP-BI
	for linuxppc-embedded@ozlabs.org; Tue, 22 Jul 2008 06:22:45 -0700
Message-ID: <18587466.post@talk.nabble.com>
Date: Tue, 22 Jul 2008 06:22:45 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <4885AC94.7050501@coritel.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com> <200807221131.32556.arnd@arndb.de>
	<4885AC94.7050501@coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All ...

First of all let me thank you for your valuable suggessions ...

1. I wanted to allocate 9MB in kernel and wanted that memory to be mapped to
the physically continews SDRAM memory. but till now i could not found a way
to do so ???

2. So i thought to use ioremap to map SDRAM and make it accessible to user
using mmap technique but there is only one doubt and that is will it be
secure and stable and whether it is a right way of doing ???

3. Now i have allocated 3MB of memory in kernel for simulation purpose in
dma region and writing to 1 MB at a time in the driver and reading it in the
application this works good in the Linux PC where as in the board i could
just read '/0' char always .

4. When i do ioremap to a cpld memory mapped reg (as i am using simul board
which does not have the actual SDRAM mapping ) i could read write to it but
in the application i can read a value of '/0' always 

5. Can i actually do ioremap to 9 MB SDRAM memory and map it to the user
using function remap_pfn_range() ???


I am sorry Stornelli 
--- Since there is a time criticality hence i am not able to look the driver
books and documentation as of now and trying my little knowledge and your
suggessions .... 

------ Misbah <><

Marco Stornelli wrote:
> 
>> On Tuesday 22 July 2008, Misbah khan wrote:
>>> I am getting kernel panic while trying these as suggested by you ,the
>>> following points will elaborate my concern :-
>>> i am allocating memory using vmalloc and remaping to the SDRAM area as
>>> :-
>>>
>>> buf_area = vmalloc(sizeof(circularbuffer_S));
>>>         if(!buf_area)
>>>         {
>>>                 printk(KERN_ALERT"vmalloc failed \n");
>>>                 return -1;
>>>         }
>>>
>>>         buf_area = (circularbuffer_S *)ioremap(7700000,900000);
>>>         if(!buf_area)
>>>         {
>>>                 printk(KERN_ALERT"ioremap failed \n");
>>>                 return -1;
>>>         }
> 
> Misbah I suggest you, before to write in a Linux mailing list, to read 
> Understanding the Linux kernel, Linux device drivers, Understanding the 
> Linux virtual memory manager and so on, to study them very well, to 
> think well about your problem and then ask for help in a mailing list.
> 
> Regards,
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
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18587466.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 16494DE084
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 21:33:08 +1000 (EST)
Message-ID: <487F2E79.1030102@coritel.it>
Date: Thu, 17 Jul 2008 13:35:21 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Ruksen INANIR <rukseninanir@gmail.com>
Subject: Re: increase lowmem value for ppc
References: <487F1FD2.7090909@gmail.com>
	<487F297B.4070806@coritel.it>	<487F2B4C.7070409@coritel.it>
	<487F2B7D.6080109@gmail.com>
In-Reply-To: <487F2B7D.6080109@gmail.com>
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

Ruksen INANIR ha scritto:
> 
> Is there any side effects of changing the address splitting? 

Yes, in this way the application address space is smaller than normal. 
Some big applications (for example same dbms) might not work. Usually 
with 2G/2G most of the applications work well.

> What should i change for 2G/2G splitting? should i shift the kernel start?
> Thanks
> 
Yes in advanced options of the kernel menu, but sometimes it's not easy. 
  Sometimes ago I had to do the same thing but I have to change the 
kernel code because some operations were hard-coded. Be careful because 
it's not an easy operation. However I'd suggest you to use the highmem, 
the memory performance are worse than direct memory mapping, but usually 
it's not a problem because the overhead is low.

> 
> Marco Stornelli wrote:
>> Marco Stornelli ha scritto:
>>> Ruksen INANIR ha scritto:
>>>>
>>>> Is there a way to increase the lowmem value for ppc. The MAX_LOW_MEM 
>>>> is defined as max 768 MB. But a value around 1.5 G works with no 
>>>> problem. But when i try to increase this value to 1520 or more, 
>>>> kernel complaints about no space for memory allocation when loading 
>>>> kernel modules.
>>>> I do not want to use HIGHMEM config. What is the max lowmem value 
>>>> for a ppc system? What other setting are needed to use 1520 MB (or 
>>>> more) as lowmem .
>>>> The ppc card has 2G on board memory. 2.4.22 kernel is used.
>>>>
>>>> Thanks
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>
>>> With 32-bit arch you may not use more than 1GB to map the memory 
>>> (minus some space for some kernel operation). The value of 768MB was 
>>> not there by chance.
>>>
>> Only an additional comment: I meant with the address splitting 3G/1G. 
>> To map more than 1GB, you have to change the splitting 2G/2G for example.
>>
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838

Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30880DDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 17:03:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IDEQf-0004wA-IH
	for linuxppc-embedded@ozlabs.org; Tue, 24 Jul 2007 00:03:33 -0700
Message-ID: <11757911.post@talk.nabble.com>
Date: Tue, 24 Jul 2007 00:03:33 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kmalloc returns which address
In-Reply-To: <469B92DC.50609@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
	<469B92DC.50609@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Scott

The while idea behind my logic was something this :-

 Conver the physical address into virtual address and every time you read or
write to that virtual you are reading or writing to the physical address.
For that i suggested for ioremap(), some may suggest for __pa() to translate
the physical address to logical address. The whole idea behind this is to
make the task much easy and less complicated as if you are working on memory
mapped address.

DMA operation will make the application process to access the device
directly this i guess is little more complicated in implimentation and
passing a pointer to the application is a serious security concern untill
and unless only one thread is accessing .

well i will try this with a test driver as soon as i get the free time and
let you know with the findings

Thanks 
Misbah  

Scott Wood-2 wrote:
> 
> suresh suresh wrote:
>> I want know the address return by kmalloc function? is it physical
>> address
>> or kernel virtual address.
> 
> Kernel virtual.
> 
>> For Tx and Rx, hardware uses buffers, so I have to allocate buffers and 
>> pass
>> the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
>> should convert it into physical address?
> 
> You need to convert it; read Documentation/DMA-mapping.txt.
> 
> -Scott
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Kmalloc-returns-which-address-tf4086826.html#a11757911
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

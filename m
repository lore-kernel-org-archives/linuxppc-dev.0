Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB863DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 20:52:23 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IBq5t-0000pB-8j
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 03:52:21 -0700
Message-ID: <11705981.post@talk.nabble.com>
Date: Fri, 20 Jul 2007 03:52:21 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kmalloc returns which address
In-Reply-To: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi Suresh

In linux kmelloc returns the pointer to virtual address not the physical
address, to return to the physical address there is different function
called ioremap 

for eg :-
char *buf_tx =kmalloc(100,GFP_KERNEL); // Tx buffer
char *buf_rx=kmalloc(100,GFP_KERNEL); // Rx buffer

ptr_tx=ioremap( buf_tx,100);
ptr_rx=ioremap(buf_rx,100);

To learn more about this go through Linux device driver by rubini 

I hope this will work for you 
regard 
Misbah

suresh suresh wrote:
> 
> Hi,
> 
> I am porting MPC8280 driver from vxWorks to Linux.
> 
> I want know the address return by kmalloc function? is it physical address
> or kernel virtual address.
> 
> For Tx and Rx, hardware uses buffers, so I have to allocate buffers and
> pass
> the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
> should convert it into physical address?
> 
> If it returns kernel virtual address, then how to convert into physical?
> 
> Thanks & Regards-
> Suresh
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/Kmalloc-returns-which-address-tf4086826.html#a11705981
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

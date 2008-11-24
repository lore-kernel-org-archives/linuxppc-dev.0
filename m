Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C64AADDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 08:25:02 +1100 (EST)
In-Reply-To: <492B1602.7010102@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
MIME-Version: 1.0
Message-ID: <OF5164841E.9891D22C-ON8825750B.0074160D-8825750B.007587B6@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 24 Nov 2008 13:23:54 -0800
Content-Type: text/plain; charset="US-ASCII"
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

> 
> Any given memcpy operation involves *both* directions.  Data is copied 
> out of host memory into the DMA engine's internal buffer (this is the 
> src mapping), and then it its copied back into host memory at a 
> different address (this is the dest mapping).
> 

Whoops!  Now we may be getting to the heart of what I'm confused about ;). 
 My bad, some more background may be in order for you to help me.

What I'm trying to do is set up a DMA transfer to/from a NAND flash 
controller hanging on a PCI bus.  So, let's say I'm doing a read of the 2K 
NAND page.  My "source" is a PCI address and is what I was assuming I 
needed to pass to the memcpy function as "src".  But that assumption 
conflicts with your statement that "Data is copied out of host memory into 
the DMA engine's internal buffer (this is the src mapping)".  Is this 
where my ignorance is jumping up and bitting me?

Maybe (with you clarification) this is starting to make sense.  It doesn't 
matter if the "src" is host memory or PCI space.  What the "src" and it's 
DMA_TO_DEVICE mapping is saying to the kernel is "this data needs to be 
moved into the DMA engine", while the "dest" and it's DMA_FROM_DEIVCE 
mapping is telling the kernel "this data needs to be moved from the DMA 
engine".

Or am I even more confused :(  ?

Bruce

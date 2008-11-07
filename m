Return-Path: <timur.tabi@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 7228FDDF7D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 02:43:21 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1043794rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 07 Nov 2008 07:43:20 -0800 (PST)
Message-ID: <ed82fe3e0811070743l1e0f7430o6bbb2b3d5e5a446f@mail.gmail.com>
Date: Fri, 7 Nov 2008 09:43:18 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
In-Reply-To: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
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

On Wed, Nov 5, 2008 at 8:07 PM,  <Bruce_Leonard@selinc.com> wrote:
> This may be the wrong forum for this question.  If so I apologize, and
> could someone please tell me the appropriate place to ask?

You're in the right place.

> In the Cafe driver, Linux Device Drivers 3rd Edition, and DMA-mapping.txt
> everyone talks about how to allocate buffers using
> dma/pci_alloc_coherent(), but no one talks about how to actually use it.

That's because allocating a DMA buffer is a task common to all DMA
operations.  Everything else about DMA is device- and/or
architecture-specific.

DMA buffers typically have special requirements with respect to
contiguousness and caching.

> I'm pretty sure (even in my ignorance) that just allocating a DMA coherent
> buffer and then copying in and out of it does NOT actually engage the
> underlying hardware and perform a DMA transfer.

That is correct.  A DMA buffer, once allocated, generally acts very
much like any other piece of memory allocated by kmalloc(). The buffer
is typically allocated from main memory, so there's no way to make it
do anything special.

> With some digging I've found the Freescale Elo/Elo Plus DMA driver which
> supports my processor.  What I'm not clear on is how to actually make use
> of it.  How do I tie my NAND driver to the Freescale DMA driver and
> actually get the hardware to work?  Any pointers are greatly appreciated.

The Elo device driver is an async DMA back-end driver.  That is, you
don't communicate with that driver directly, you communicate with the
async library (which is new - so you won't find it in LDD3).

Please note that the async DMA stuff is intended for single-shot
one-way transfers only between two memory regions.  It has a very
specific usage.  If you need something more complicated, you'll need
to write your own DMA driver.  You can find an example of that in
sound/soc/fsl/fsl_dma.c.

-- 
Timur Tabi
Linux kernel developer at Freescale

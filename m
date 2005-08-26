Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id D483068048
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 13:14:40 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so639384rnf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 20:14:39 -0700 (PDT)
Date: Thu, 25 Aug 2005 21:10:57 -0600
To: "P. Sadik" <psadik@gmail.com>
Message-ID: <20050826031057.GA6553@siegfried.thelikelysolution.ca>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea43f4f9050825183121655ba2@mail.gmail.com>
From: Grant Likely <glikely@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2005 at 06:31:22PM -0700, P. Sadik wrote:
> Hello,
> 
>  On PPC I see that, the kernel .text is at 0xC000_0000. Is it a 
> translated address? If it is, for running kernel code, the CPU has to
> consult the TLB always?
Typically, PPC systems have RAM based at physical address 0 which is
mapped up to 0xc0000000.  Once the MMU is turned on the TLB is consulted
for every memory access.
> 
>  Another question is regarding addressing local peripherals. I am using
> an ML310 board from Xilinx and it has DDR mapped to 0x0000_0000
> to 0x0FFF_FFFF (256 MB). Now, I need to add an IP to the PLB.
> For that, I am thinking of using 0x2000_0000 to 0x2000_0FFF.
> Now, my driver need to access the registers within the above region.
> How will I do that? It is an I/O, hence should I use ioremap, or can
> I access it directly? What role cache will play in this case?
You can put your peripherals anywhere within the address space as long
as they don't conflict with each other.  You must add a page mapping for
each peripheral because once the MMU is turned on you can no longer
access physical addresses directly.  I believe ioremap is the correct
facility to do this.

> 
>  The third question is, can I use de-referencing of address. Is it O.K
> to use pointers to access the registers, or do I have to use read/write
> variants? 
Since there is no seperate IO memory space you can access the registers
with simple pointers.

Whether or not it is a good idea (based on coding conventions) I'll
leave for someone else to answer.  :)

> 
>   I would appreciate a lot if you could give some insight into this. Any
> pointers or reading materials will be very helpful.
Keep me updated on your progress.  I'm working on the ML300 and a couple
of the MEMEC boards to make v2pro support more flexible in 2.6.x, and
I'd like to hear about your experiences.

Cheers,
g.
> 
> Thanks and regards,
> 
> Sadik.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

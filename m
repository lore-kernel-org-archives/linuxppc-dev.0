Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id E1966679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 06:41:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel 2.6.15: cpm_uart driver broken?
Date: Wed, 19 Apr 2006 16:40:25 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD432D512@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: "Dan Malek" <dan@embeddedalley.com>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Dan:

>
>From: Dan Malek [mailto:dan@embeddedalley.com]=20
>Sent: Wednesday, April 19, 2006 3:42 PM
>To: Kenneth Poole
>Cc: Vitaly Bordug; David Jander; linuxppc-embedded@ozlabs.org
>Subject: Re: kernel 2.6.15: cpm_uart driver broken?


>On Apr 19, 2006, at 3:24 PM, Kenneth Poole wrote:

>>
>>  		/* get pointer */
>> -		cp =3D cpm2cpu_addr(bdp->cbd_bufaddr);
>> +		cp =3D (unsigned char *)pinfo->mem_addr +
>> (bdp->cbd_bufaddr - pinfo->dma_addr);


>Ummm, no.  Keep the cpm2cpu_addr() and pass it
>some driver data structure pointer so it does the computes,
>

We did this to solve the problem mentioned earlier in this thread which
is that bus_to_virt() and virt_to_bus() don't work for memory allocated
with dma_alloc_coherent(). By saving the return value from
dma_alloc_coherent() in dma_addr, we avoid having to do those
conversions all of the time.

>or better, keep the phys/virt addresses in a handy data
>structure you can easily access and work with offsets within
>the different address spaces.

That's what we're doing by using dma_addr. We just compute the offset in
the physical address space and apply that offset in the virtual address
space. Some drivers keep both sets of pointers around for each buffer
allocated, and that would work as well.

>  The test of addr >=3D CPM_ADDR
>is critically important to early boot and kgdb support
>and can't be removed.

I assumed that this test was simply to exclude console ports from
conversion. But in cpm_uart_allocbuf() there already is a test (is_con).
For the console, we simply save the unconverted dma_addr in the port
structure once and use it normally. Our console port works just fine.
Testing addr >=3D CPM_ADDR forces very specific ordering onto the IMMR =
and
DMA address spaces, and I thought our approach was more general.=20

>> -		bdp->cbd_bufaddr =3D cpu2cpm_addr(mem_addr);
>> +		bdp->cbd_bufaddr =3D dma_addr;

>This kind of initialization is broken, too.  You have to test
>that memory address and return the proper space.

>Thanks.

>	-- Dan

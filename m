Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 2F56767A86
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 07:33:02 +1100 (EST)
Date: Tue, 8 Mar 2005 13:32:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050308133249.C8434@cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592E9@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8592E9@ismail.innsys.innovsys.com>;
	from runet@innovsys.com on Tue, Mar 08, 2005 at 12:37:33PM -0600
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 12:37:33PM -0600, Rune Torgersen wrote:
> Ok... Got a little closer....
> 
> I have PCI (outbound) mapped in the area 0x80000000-0x8fffffff
> (prefetch/non-prefetch and IO)
> IMMR of cource is at 0xf0000000
> 
> So I map the IO as following:
> 	/* Map IMMR region to a 256MB BAT */
> 	addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
> 	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
> 
> 	io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
> 
> Now I can almost boot....:
> It craches when trying to read from harddisk
> (only happens with more than 512MB)

That's expected if you are going to 768MB. You have kernel lowmem
being mapped at 0xc0000000+<size_of_system_memory>. With 768MB that
takes you all the way to where you have the IMMR mapped 1:1 I
guess. This leaves no room for vmalloc space.  With 768MB of ram
the kernel will calculate VMALLOC_START at 0xf1000000 which is a
problem.

A few options are:

* Move the IMMR much higher to allow vmalloc space
* Modify maximum low memory to limit to 512MB using the advanced
  options menu
* Modify KERNELBASE to something like 0xa0000000 using the advanced
  options menu

All of these methods will provide addition vmalloc space.

Don't forget to turn on HIGHMEM to use everything above MAX_LOW_MEM.

-Matt

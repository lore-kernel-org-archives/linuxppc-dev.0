Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7D17DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 02:04:27 +1000 (EST)
Message-ID: <469CE80A.5080204@freescale.com>
Date: Tue, 17 Jul 2007 11:02:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: suresh suresh <sureshtang@gmail.com>
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 33
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>	
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>	
	<469B9825.6070507@freescale.com>
	<e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
In-Reply-To: <e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Siva Prasad <sprasad@bivio.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

suresh suresh wrote:
> MPC8280 has internal memory space which contains Dualport(Dp) RAM. In the
> DpRAM we allocate some tables and these has to store pointer of the buffers
> which are allocated in external memory. Core will use this pointer to 
> access
> the buffers, basically these buffers are used for DMA.
> 
> Using IMMR register we can get physical address of the internal memory. Now
> can I store the address return by the kmalloc() function? or I should
> convert it into physical?

Yes, you need to convert it to physical.  As I said earlier, use the DMA 
mapping API (described in Documentation/DMA-mapping.txt) to do so. 
Specifically, look at the dma_map_single() function.

-Scott

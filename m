Return-Path: <aidan@nicta.com.au>
Received: from mail08.syd.optusnet.com.au (mail08.syd.optusnet.com.au
	[211.29.132.189])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C90C867A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 18:46:41 +1000 (EST)
Message-ID: <4499076E.6000804@nicta.com.au>
Date: Wed, 21 Jun 2006 18:46:38 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Rick Moleres <rick.moleres@xilinx.com>
Subject: Re: Linux on Virtex4
References: <689CB232690D8D4E97DA6C76DA098E6C027E6274@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C027E6274@XCO-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, "Martin, Tim" <tim.martin@viasat.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rick Moleres wrote:
> There's also a Linux 2.4 patch provided with the ML403 PPC reference
> design on the Xilinx website
> (http://www.xilinx.com/products/boards/ml403/reference_designs.htm) that
> takes care of a Virtex-4 PPC cache issue (CCR0 register).  Have you
> applied this?
> 

Rick, which cache issue are you referring to?

I tried setting the CCR0 bits in accordance with:

   "Solution 10: CPU_213: Incorrect data might be
    flushed from the data cache"

but that didn't fix things in my case for the Avnet FX12 MiniModule.


I'm pretty sure that the FX12-MM strikes:

   "Solution 13: The return of a cacheline transaction that
    is not target word first (non-target word first) can
    cause data corruption in the PPC405 Core data cache in
    Virtex-4 FX devices."

For which the only solutions mentioned are to run without caches or get 
a fixed chip.


As I understand it, the memory controller for this board must be on the 
OPB because the memory is 16-bit.  Is there any way to move the memory 
controller to the PLB thus avoiding the cache problem (for RAM at least)?

- aidan

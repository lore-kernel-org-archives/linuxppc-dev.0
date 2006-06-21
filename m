Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D0DE67A60
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Jun 2006 06:33:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on Virtex4
Date: Wed, 21 Jun 2006 14:33:48 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C027E6946@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Aidan Williams" <aidan@nicta.com.au>
Cc: "Martin, Tim" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Aiden,

Looked into this and here's what I found out.  Only OPB_DDR supports
16-bit DDR memory right now and there are no concrete plans to add
16-bit support to PLB_DDR (it's been discussed, but nothing planned
yet).  So the only workarounds for this silicon issue are the two you
mentioned - run with caches off or get a fixed version of the chip (I
don't know what Avnet's plans are for your board).

-Rick


-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Rick Moleres
Sent: Wednesday, June 21, 2006 12:10 PM
To: Aidan Williams
Cc: linuxppc-embedded@ozlabs.org; Martin, Tim
Subject: RE: Linux on Virtex4


Aiden,

The cache issue I was referring to is the errata 213 that you tried.
I'll ask around regarding the silicon issue - I don't know if there is a
workaround for this on that board.

-Rick

-----Original Message-----
From: Aidan Williams [mailto:aidan@nicta.com.au]=20
Sent: Wednesday, June 21, 2006 2:47 AM
To: Rick Moleres
Cc: Martin, Tim; linuxppc-embedded@ozlabs.org
Subject: Re: Linux on Virtex4

Rick Moleres wrote:
> There's also a Linux 2.4 patch provided with the ML403 PPC reference
> design on the Xilinx website
> (http://www.xilinx.com/products/boards/ml403/reference_designs.htm)
that
> takes care of a Virtex-4 PPC cache issue (CCR0 register).  Have you
> applied this?
>=20

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

For which the only solutions mentioned are to run without caches or get=20
a fixed chip.


As I understand it, the memory controller for this board must be on the=20
OPB because the memory is 16-bit.  Is there any way to move the memory=20
controller to the PLB thus avoiding the cache problem (for RAM at
least)?

- aidan


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

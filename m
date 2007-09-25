Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3ECCEDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 01:23:08 +1000 (EST)
Date: Tue, 25 Sep 2007 10:23:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nethra <nethra_gmit@yahoo.co.in>
Subject: Re: jffs2 file system on MPC8272ADS
Message-ID: <20070925152301.GC15739@ld0162-tx32.am.freescale.net>
References: <12873633.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12873633.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 11:01:55PM -0700, Nethra wrote:
[snip]
> Header CRC failed on REF_PRISTINE node at 0x0063b24c: Read 0xffffffff,
> calculated 0x44660075 
> Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b4) 
> Header CRC failed on REF_PRISTINE node at 0x0063b500: Read 0xffffffff,
> calculated 0x44660075 
> Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c8) 
> Header CRC failed on REF_PRISTINE node at 0x0063b7c8: Read 0xffffffff,
> calculated 0x44660075 
> 
> are they debug messages or warnings...? 

They are errors.

> # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set 
> # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set 
> CONFIG_MTD_MAP_BANK_WIDTH_4=y 
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set 
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set 
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set 
> # CONFIG_MTD_CFI_I1 is not set 
> CONFIG_MTD_CFI_I2=y 
> # CONFIG_MTD_CFI_I4 is not set 
> # CONFIG_MTD_CFI_I8 is not set 
[snip]
> # 
> # Mapping drivers for chip access 
> # 
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set 
> CONFIG_MTD_PHYSMAP=y 
> CONFIG_MTD_PHYSMAP_START=0xFC000000 
> CONFIG_MTD_PHYSMAP_LEN=0x4000000CONFIG_MTD_PHYSMAP_BANKWIDTH=4 
> # CONFIG_MTD_MULTI_PHYSMAP is not set 
> # CONFIG_MTD_SBC8240 is not set 
> CONFIG_MTD_PQ2FADS=y 
> # CONFIG_MTD_PLATRAM is not set 

Are you using a non-standard flash SIMM?  The one that comes with the
board (that I've seen, at least) have interleave 4, and are mapped at
0xfe000000.

Was it the physmap driver or the pq2fads driver that found the flash?

Which kernel are you using, and are you using arch/ppc or arch/powerpc?

-Scott

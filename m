Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAC3EDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 14:52:52 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IalMn-000499-VX
	for linuxppc-embedded@ozlabs.org; Wed, 26 Sep 2007 21:52:49 -0700
Message-ID: <12914822.post@talk.nabble.com>
Date: Wed, 26 Sep 2007 21:52:49 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: jffs2 file system on MPC8272ADS
In-Reply-To: <20070925152301.GC15739@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12873633.post@talk.nabble.com>
	<20070925152301.GC15739@ld0162-tx32.am.freescale.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



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

>>They are errors.

which are all the most possible reasons for these errors ?

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

>>Are you using a non-standard flash SIMM?  The one that comes with the
>>board (that I've seen, at least) have interleave 4, and are mapped at
>>0xfe000000.

 First of all this is CUSTOM board similar to MPC8272ADS.

We are using flash which is different from flash that comes with the
MPC8272ADS board.

FLASH:	 S29GL256N90TF
       	Total size is 64 MB with 2 flash interleave
       	mapped at 0xfc000000.
       	
>>Was it the physmap driver or the pq2fads driver that found the flash?
       
             Flash is cfi compatible.


>>Which kernel are you using, and are you using arch/ppc or arch/powerpc?
>> -Scott
          
           KERNEL: linux-2.6.10 and we r using arc/ppc 	

Nethra

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



-- 
View this message in context: http://www.nabble.com/jffs2-file-system-on-MPC8272ADS-tf4513571.html#a12914822
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

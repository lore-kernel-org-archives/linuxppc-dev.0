Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 3F9B42BD6A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 09:29:33 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-dev@ozlabs.org; 17 Sep 2004 19:29:29 -0400
Date: Fri, 17 Sep 2004 19:23:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409171917180.6511@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: apparent error in micropatch.c
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


   i *believe* there's an error in arch/ppc/8xx_io/micropatch.c 
regarding how the SMC patch is applied.

   in the latest bk pull of that file, line 186:

#ifdef USE_SMC_PATCH
#define PATCH_DEFINED
/* SMC2/IIC/SPI Patch */
/* This is the area from 0x2000 to 0x23ff.
*/
uint patch_2000[] = {
         0x3fff0000,
         0x3ffd0000,
         0x3ffb0000,
         ... etc ...

actually, that patch is not 1024 bytes long, but 1280 bytes, which 
means it goes to 0x24ff, not 0x23ff.  this certainly seems like it's 
going to cause problems further down, when that same file defines a 
relocation base for a couple structures starting at 0x2400:


#if defined(USE_SMC_PATCH) || defined(USE_IIC_PATCH)

         iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
#define RPBASE 0x0400    <--  ???????
         iip->iic_rpbase = RPBASE;

         /* Put SPI above the IIC, also 32-byte aligned.
         */
         i = (RPBASE + sizeof(iic_t) + 31) & ~31;
         spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
         spp->spi_rpbase = i;


i'm pretty sure that trying to relocate the iic_t struct to that 
offset is going to clash badly with the tail end of the patch, no?
perhaps RPBASE could be set to 0x0500 to avoid this?

or am i misreading something?

rday

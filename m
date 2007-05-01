Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B385DDFA2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 14:35:39 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1Hik3i-0000Al-5t
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 May 2007 00:33:50 -0400
Message-ID: <4636C377.4070101@dlasys.net>
Date: Tue, 01 May 2007 00:35:03 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	<87slai5vz3.fsf@sleipner.barco.com>
	<528646bc0704292141n322c145cmc3d2606b13b0b053@mail.gmail.com>
In-Reply-To: <528646bc0704292141n322c145cmc3d2606b13b0b053@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>
> Is the redboot bd_info structure already in the kernel tree?  We could
> use a config option to select between the u-boot and redboot
> structures for all virtex platforms.  That would keep the uglyness
> down to a minimum.
>
> g.
>   
There are a plethora of bd_info's in the kernel tree. I think that
u-boot is probably the most common,
but the u-boot one is huge and full of cruft.
There are also likely to be any number for board/loader combinations
that are not in the kernel.
I have cut an pasted ours below - not that I am trying to sell it.

But I would prefer that if there is a bd_info struct that it be defined
by the board not virtex.h or virtex.c.

 //Information passed to program when it is executed.
 typedef struct _BOARD_INFO
   {uint32_t  bi_signature;       // 0x00 valid bi signature
    uint32_t  bi_memMax;          // 0x04 DRAM installed, maximum byte
address
    uint32_t  bi_intfreq;         // 0x08 Processor speed, in Hz
    uint32_t  bi_busfreq;         // 0x0C PLB Bus speed, in Hz
    uint32_t  bi_version;         // 0x10 local pico number format #.##,
eg 3.09
    uint8_t  *bi_cmdline;         // 0x14
    uint32_t  bi_capabilities;    // 0x18 Pico capabilities mask
    uint32_t  bi_debug;           // 0x1C Pico flags mask
    uint32_t  bi_flashstart;      // 0x20 start of FLASH memory
    uint32_t  bi_flashsize;       // 0x24 size  of FLASH memory
    uint32_t  bi_envSize;         // 0x28 environment size
    uint8_t   bi_enetaddr[6];     // 0x2C Local Ethernet MAC address
    uint16_t  bi_cflags;          // 0x32 console flags
    char     *bi_envP;            // 0x34 pointer to environment string
    uint32_t  bi_model;           // 0x38 0x0E16'FX', (ie 0x0E164658) etc 
    uint32_t  bi_resv;            // 0x38 reserved
   } BOARD_INFO;                  // 0x40




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

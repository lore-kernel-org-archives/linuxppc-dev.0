Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 9A478B70C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 19:10:08 +1000 (EST)
Message-ID: <4A4C7812.7040301@aimvalley.nl>
Date: Thu, 02 Jul 2009 11:04:18 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
Subject: Re: How to set DDR data bus width to 16Bit
References: <29DC34A6B43468409F5A371CFE34E849D7F173@ex01.ads.ubidyne.de>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849D7F173@ex01.ads.ubidyne.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


you have to do it via your bootloader (u-boot) which sets up
the DDR memory controller.
Linux (already) assumes memory is available.
Are you sure linux kernel is changing DDR_SDRAM_CFG ?
When our linux-2.6.28 kernel is up, it's still 0xc3080000 when I read
physical address 0xe0002110.

Btw. We did some performance tests with 16 bit bus-width (DDR2 memory)
and surprisingly performance was almost as good as 32 bit bus-width


---
N. van Bolhuis.




Frank Prepelica wrote:
> Hi all,
> 
> Does anyone knows how to set the DDR data bus width to 16Bit in linux?
> I've found that 
> option in U-Boot in the MPC8313ERDB_config file. (verfied with a memory
> dump of the 
> CPU register (DDR_SDRAM_CFG)  - the 16Bit DBW is set(10b) ). But after
> starting 
> linux the value is set to 00b (=reseverd).
> 
> We are using a customized MPC8313ERDB board.
> 
> Thanks in advance
> 
> 
> Kind regards
> 
> Frank Prepelica
> Software Design Engineer
> 
> Ubidyne GmbH
> Lise-Meitner-Str.-14
> 89081 Ulm - Germany
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

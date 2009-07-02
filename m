Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 905B7B70C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 20:31:08 +1000 (EST)
Message-ID: <4A4C8C60.6060607@aimvalley.nl>
Date: Thu, 02 Jul 2009 12:30:56 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
Subject: Re: AW: How to set DDR data bus width to 16Bit
References: <29DC34A6B43468409F5A371CFE34E849D7F193@ex01.ads.ubidyne.de>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849D7F193@ex01.ads.ubidyne.de>
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

Hi Frank,

Yes, it's 0xC3100000 for 16 bit. I showed the 32bit value.

Yes, to go to 16 bit bus-width (1 DDR(2) device), this is the only
change needed in u-boot, assuming you have 2 DDR(2) devices (like 8313E-RDB)
which together provide 16+16 = 32bit bus-width.

Since, surprisingly, the 16 bit application/u-boot performance was almost as
good as 32 bit we even tested with I-cache and D-cache turned off.
u-boot provides commands for this (which I didn't know, see some previous
emails from me on this mailing-list).
Also with I-cache and D-cache turned off the 16 bit bus-width performance was
almost as good as 32 bit. So our conclusion was that the 16/32 bit DDR2 memory
access is not the limiting factor when it comes to "SW performance".
Therefore we decided to go for 16 bit bus-width for a new/tiny 8313 based
design.

Please let me know your test results. I would expect you to conclude more
or less the same.

Best Regards,
Norbert.






Frank Prepelica wrote:
>> you have to do it via your bootloader (u-boot) which sets up
>> the DDR memory controller.
>> Linux (already) assumes memory is available.
>> Are you sure linux kernel is changing DDR_SDRAM_CFG ?
>> When our linux-2.6.28 kernel is up, it's still 0xc3080000 when I read
>> physical address 0xe0002110.
> 
> 
> Hi Norbert, thank you for your fast reply!
> 
> You are absolutly right! I made a silly mistake. I've read the value of
> the 0xe0002110 with a 8bit pointer.
> 
> The value is actually 0xC3100000 which means the 16bit bus width is set.
> 
> Just to be sure. Is this the only change (in the bootloader) I have to
> make that all data accesses are 16bit wide?
> 
>> Btw. We did some performance tests with 16 bit bus-width (DDR2 memory)
>> and surprisingly performance was almost as good as 32 bit bus-width
> 
> This is exactly our intention to test. Thanks for that hint. Very good
> to
> know!
> 
> Thank you.
> 
> Best regards
> Frank
> 
> 

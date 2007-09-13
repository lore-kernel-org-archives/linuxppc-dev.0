Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id EA13EDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 00:16:48 +1000 (EST)
Message-ID: <46E944BE.1010007@qstreams.com>
Date: Thu, 13 Sep 2007 10:10:06 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Erik Christiansen <erik@dd.nec.com.au>
Subject: Re: Flash on ep8248e standard motherboards
References: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
	<20070913082558.GB8968@dd.nec.com.au>
In-Reply-To: <20070913082558.GB8968@dd.nec.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Erik Christiansen wrote:
> On Tue, Sep 04, 2007 at 12:08:47PM -0600, Alan Bennett wrote:
>   
>> BDI 2000 Config File:
>>   ;  initialize - FLASH BR0 & OR0 (64 Mbyte)
>>   ;*******************************************
>>   WM32    0xf0010100     0xfc001801
>>   WM32     0xf0010104     0xfc0008c2
>>   [FLASH]
>>   CHIPTYPE    MIRRORX16
>>   CHIPSIZE    0x2000000
>>   BUSWIDTH    16
>>     
>
> Having just taken delivery of an ep8248e, I'm surprised that the
> supplied flash config is commented out and erroneous:
>
> [FLASH]
> ;CHIPTYPE    AM29F       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
> ;CHIPSIZE    0x200000    ;The size of one flash chip in bytes (e.g. AM29F010 = 0x20000)
> ;BUSWIDTH    8           ;The width of the flash memory bus in bits (8 | 16 | 32 | 64)
> ;
>
> Did you start with the Embedded Planet offering, in your current effort
> to create a usable config? Is MIRRORX16 more than a guess?
>
> I've found that my flash chips are "spansion GL256N10FFI02", which
> AFAICT are S29GL256N10FFI02 from AMD, as we used to know them.
> I wonder if S29M32X16 is a likely guess for CHIPTYPE on the card which
> has landed in my lap?
>
>   
MIRRORX16 is the correct type for Spansion GL series NOR flash. AMD spun 
off their flash business a while ago and renamed it Spansion. If you 
look on the datasheet you'll see that Spansion calls the GL technology 
'MirrorBit', and in all likelihood the device has a 16-bit data bus. The 
AMD algorithm may work but the MIRRORX16 definitely will.

regards,
Ben

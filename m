Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D0D576829B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 06:37:08 +1000 (EST)
In-Reply-To: <4540FC2D.6000403@freescale.com>
References: <20061025173304.c57o9tf3go000wc0@webmail.mcgill.ca>
	<4540FC2D.6000403@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D85A7F8-35E7-43E4-9738-46EED3077852@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: Kernel hangs in console_init()
Date: Thu, 26 Oct 2006 15:36:59 -0500
To: wei.li4@elf.mcgill.ca
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 26, 2006, at 1:19 PM, Scott Wood wrote:

> wei.li4@elf.mcgill.ca wrote:
>> Hi All,
>>
>> I am working on linux 2.6.18-rc2 with my mpc875 demo board, I used
>> Debugger LEDs to find that kernel stopped in:
>> 	while (call < __con_initcall_end) {
>> 		(*call)();
>> 		call++;
>>         }
>> which is in console_init() of tty_io.c, what kind of problem could  
>> be?
>> What's the means of 'bctrl' instruction that I found in its  
>> assembler?
>
> It's an indirect function call (i.e. the (*call)(); line) to the  
> address
> specified in the CTR register.  You need to find out the value of  
> *call
> in order to figure out which function is failing.  There are probably
> only a small number of possibilities that are actually configured into
> your kernel (look for console_initcall in files that get built for  
> your
> target).
>
> -Scott


Wei,

For future reference, bctrl is not an instruction, but a simplified  
mnemonic.  Simplified mnemonics are there to make it easier to read  
and write assembly code; for example, you can write "bctrl" instead  
of "bcctrl 20,0".  These are all listed in appendix F of the  
Programming Environments Manual for 32-bit implementations of the  
PowerPC Architecture.

You won't find these instructions in the index of the manual, so  
whenever you run into an "instruction" that you don't find listed in  
the main part of the manual, try appendix F and hopefully that will  
help.

Cheers,
B

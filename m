Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 458A867B22
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:30:09 +1000 (EST)
In-Reply-To: <200608182105.45264.arnd@arndb.de>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
	<1155924687.9659.25.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <85B7DDBD-52E0-4E1C-8493-A5BCA795780A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Fri, 18 Aug 2006 14:30:07 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 18, 2006, at 2:05 PM, Arnd Bergmann wrote:

> On Friday 18 August 2006 20:11, Will Schmidt wrote:
>> +#define INST_POPCNTB           0x7c0000f4
>> +
>
>> +       /* Emulate the popcntb (Population Count Bytes)  
>> instruction. */
>> +       if ((instword & INST_POPCNTB) == INST_POPCNTB) {
>> +               return emulate_popcntb_inst(regs, instword);
>> +       }
>> +
>
> Is that the right check? The other similar traps check against a
> mask of 0x7c0007fe.

I agree with Arnd here, its better to check with a larger mask to  
ensure that bits that should be '0' in the minor opcode are.

For example, if you had an instruction that was 0x7c0000f7 it would  
match.

- kumar

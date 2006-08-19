Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92D4267B8D
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 09:20:42 +1000 (EST)
From: segher@gate.crashing.org
Message-ID: <37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
Date: Sat, 19 Aug 2006 18:32:52 -0500 (CDT)
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
To: <arnd@arndb.de>
In-Reply-To: <200608192219.03178.arnd@arndb.de>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> > Is that the right check? The other similar traps check against a
>> mask of 0x7c0007fe.
>>
>> I hope you mean 0xfc0007fe?
>>
>
> No, the code in question is
>
> #define INST_MFSPR_PVR­·­·······0x7c1f42a6
> #define INST_MFSPR_PVR_MASK­····0xfc1fffff
>
> #define INST_DCBA­······­·······0x7c0005ec
> #define INST_DCBA_MASK­·­·······0x7c0007fe
>
> #define INST_MCRXR­·····­·······0x7c000400
> #define INST_MCRXR_MASK­­·······0x7c0007fe
>
> #define INST_STRING­····­·······0x7c00042a
> #define INST_STRING_MASK­·······0x7c0007fe
> #define INST_STRING_GEN_MASK­···0x7c00067e
> #define INST_LSWI­······­·······0x7c0004aa
> #define INST_LSWX­······­·······0x7c00042a
> #define INST_STSWI­·····­·······0x7c0005aa
> #define INST_STSWX­·····­·······0x7c00052a
>
> What does the MSB do in our instructions?

Bits 0..5 are the primary opcode, for all insns;
bits 21..30 are the secondary opcode, for insns that
have one (all in primary opcode 31 do).

So we have a bug here; could you take care of it please
Arnd?


Segher

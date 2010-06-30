Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56443B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 02:17:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5UGGtZo023327
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:17:05 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5UGRCV6015507
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 11:27:12 -0500 (CDT)
Message-ID: <4C2B6DF5.7030403@freescale.com>
Date: Wed, 30 Jun 2010 11:16:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
In-Reply-To: <AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2010 01:14 AM, Shawn Jin wrote:
> Hi Scott,
>
>>> Bus Fault @ 0x00404c40, fixup 0x00000000
>>> Machine check in kernel mode.
>>> Caused by (from msr): regs 07d1cb80 Unknown values in msr
>>> NIP: 00404C40 XER: 00000000 LR: 00404C24 REGS: 07d1cb80 TRAP: 0200 DAR: 00000001
>>> MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
>>
>> Can you look up the source line/instruction corresponding to 0x404c40, in
>> the wrapper ELF file?
>
> I'm not sure how to look up it.

Use a powerpc gdb on the wrapper ELF file, and do "li *0x404c40" and/or 
"i li *0x404c40".

Or use a powerpc addr2line.

> But I used the BDI to dump the
> instructions in which you may find some clue? These should be kernel
> code, right? Maybe the gdb can help to de-assemble them?

Not easily (Format letter "i" is meaningless in "print" command, it 
says...) and there'd be no context about what part of the source code it 
corresponds to...

> 00404c40 : 0xa00a0000  -1609957376  ....

But this is a 16-bit load from r10, which is from your previous register 
dump is FF0009C0.

Does u-boot on your board put IMMR somewhere other than 0xff000000?  If 
so, you'll need to update the device tree to reflect this.

-Scott

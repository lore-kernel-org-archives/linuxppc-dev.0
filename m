Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D22ADDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 01:20:04 +1100 (EST)
Message-Id: <0F4846DC-3109-4827-84C4-9C1C9E4F69AC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1195636347.6970.80.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Date: Wed, 21 Nov 2007 08:19:19 -0600
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<1195636347.6970.80.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 3:12 AM, Benjamin Herrenschmidt wrote:

>
> On Tue, 2007-11-20 at 15:01 -0600, Kumar Gala wrote:
>>> Given that the instruction is meant to be a performance enhancement,
>>> we should probably warn the first few times it's emulated, so the
>> user
>>> knows they should change their toolchain setup if possible.
>>
>> The same is true of mcrxr, popcntb, and possibly string ld/st.
>>
>> Feel free to submit a patch that warns about their usage.
>
> At least we should keep counters... best would be per-task counters
> in /proc but that sounds harder :-)
>
> I remember in the early days of powerpc, it wasn't uncommon to have  
> apps
> with issues because they used 601 only bits on 603/4 that had to be
> emulated (such as old POWER opcodes). On MacOS, we used to have a
> system-wide counter of the number of emulated instructions we could  
> use
> to detect these things.

I think having some form of per insn group counters would be useful as  
well.  I know it would be helpful to debug user problems if they are  
doing a lot of FP emu or the like and don't know it.

- k

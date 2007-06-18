Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 65716DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:47:32 +1000 (EST)
Message-ID: <46770B7E.4070807@am.sony.com>
Date: Mon, 18 Jun 2007 15:47:26 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 23/33] powerpc: Localize mmu_off
References: <891b0e086ebe9ebf85355f893f5dafa9@bga.com>
In-Reply-To: <891b0e086ebe9ebf85355f893f5dafa9@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> On Sat Jun 16 08:06:19 EST 2007, Geoff Levand wrote:
>> This just removes the dependency __mmu_off has on the symbol
>> __after_prom_start.  I found the current code inconvenient when I
>> wanted to put some debugging code between the call to __mmu_off
>> and the branch to __after_prom_start.
> 
> You are entering this code with the mmu on?

No, mmu is off on PS3.

> 
> My first thought was that is unexpected, but aparently Apple machines 
> do that, so its supported for the master -- not the slaves.

Yes, Apple enters with the mmu on.

>> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
>> ---
>>  arch/powerpc/kernel/head_64.S |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -1695,9 +1695,11 @@ _GLOBAL(__start_initialization_multiplat
>>  2:
>>
>>         /* Switch off MMU if not already */
>> -       LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
>> +       LOAD_REG_IMMEDIATE(r4, __mmu_off_return - KERNELBASE)
>>         add     r4,r4,r30
>>         bl      .__mmu_off
>> +__mmu_off_return:
>> +
>>         b       .__after_prom_start
>>
>>  _STATIC(__boot_from_prom)
>>
>> -- 
> 
> That seems like a long label.
> 
> I could stand a 1: there (ie a local numeric label).
> 
> Hmm... how about always going directly there:
> 
> -       bl      .__mmu_off
> -       b       .__after_prom_start
> +       mtlr    r4
> +       b       .__mmu_off
> 
> 
> So that there is no space to add code that is skipped if the mmu was on?


This was intended to be a simple update.  I think the existing code is OK,
so I would prefer to just drop this patch for 2.6.23.  Feel free to continue
the effort.

-Geoff

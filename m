Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 563F7DDF41
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:47:41 +1000 (EST)
Message-ID: <46770B84.9020801@am.sony.com>
Date: Mon, 18 Jun 2007 15:47:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 24/33] powerpc: Correct __secondary_hold comment
References: <26778ed0e343676aa0c4fd0f4fa0746b@bga.com>
In-Reply-To: <26778ed0e343676aa0c4fd0f4fa0746b@bga.com>
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
> On Sat Jun 16 08:06:23 EST 2007, Geoff Levand wrote:
>> Remove references to pSeries and OpenFirmware in the __secondary_hold
>> usage comment.  __secondary_hold is a generic routine and can be used
>> by other platforms.
> 
> The comment is correct, just incomplete.  Well, the part that you 
> changed anyways.  How about changing the subject to:
> 
> Expand comment for other uses of __secondary_hold.
> 
>>
>> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
>> ---
>>  arch/powerpc/kernel/head_64.S |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -103,8 +103,8 @@ __secondary_hold_acknowledge:
>>
>>         . = 0x60
>>  /*
>> - * The following code is used on pSeries to hold secondary processors
>> - * in a spin loop after they have been freed from OpenFirmware, but
>> + * The following code is used to hold secondary processors
>> + * in a spin loop after they have entered the kernel, but
>>   * before the bulk of the kernel has been relocated.  This code
>>   * is relocated to physical address 0x60 before prom_init is run.
>>   * All of it must fit below the first exception vector at 0x100.
>>
> 
> I don't like the resulting wording.  In particular, I don't like "after 
> they have entered the kernel", as most of the kernel is not available 
> to be entered.  In addition, the unchanged part of the comment refers 
> to relocating from offset 0x60-0x100 to address 0x60, but in fact 
> offset 0x0-0x100 is placed at address 0 (0x60 is just the entry point), 
> and its done from within prom_init not before.


This was intended to be a simple update to make the comment more accurate,
not a quest to perfect it.  I would prefer to just drop this patch for
2.6.23.  Feel free to continue the effort.

-Geoff

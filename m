Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68E881A09C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:40:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 16:40:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 76A953578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:40:34 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0M6eYQP32243896
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:40:34 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0M6eXsU029134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:40:33 +1100
Date: Thu, 22 Jan 2015 17:40:32 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kernel: Avoid memory corruption at early stage
Message-ID: <20150122064032.GA19557@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1420695651-574-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421907682.4598.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421907682.4598.6.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2015 at 05:21:22PM +1100, Michael Ellerman wrote:
>On Thu, 2015-01-08 at 16:40 +1100, Gavin Shan wrote:
>> When calling to early_setup(), we picks "boot_paca" up for the
>> master CPU and initialize that with initialise_paca(). At the
>> point, SLB shadow buffer isn't populated yet. Updating the SLB
>> shadow buffer should corrupt what we had in physical address 0
>> where the trap instruction is usually stored.
>
>Ouch.
>
>Introduced in 6f4441ef7009 ("powerpc: Dynamically allocate slb_shadow from
>memblock") - December 2013.
>
>So it seems it doesn't cause us any harm in general.
>
>Did you actually hit a bug with it?
>

I didn't hit any bugs with it. So I guess it's unnecessary to mark it as
"stable". I found the issue (not bug) occasionally: starting kernel in
simulator, dumping the instruction at physical address 0x0 and found
it's not "nop".

>> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
>> index d6e195e..048a6ee 100644
>> --- a/arch/powerpc/kernel/paca.c
>> +++ b/arch/powerpc/kernel/paca.c
>> @@ -115,6 +115,9 @@ static struct slb_shadow * __init init_slb_shadow(int cpu)
>>  {
>>  	struct slb_shadow *s = &slb_shadow[cpu];
>>  
>> +	if (!slb_shadow)
>> +		return NULL;
>> +
>>  	s->persistent = cpu_to_be32(SLB_NUM_BOLTED);
>>  	s->buffer_length = cpu_to_be32(sizeof(*s));
>
>
>Yeah I guess that's an OK fix.
>
>We must have a valid SLB shadow before we ever call _switch(), which is much
>later. The only way we could hit this case for the real paca is if
>allocate_slb_shadows() failed to allocate, but it would have panicked if it
>did.
>

Perhaps I can add BUG_ON(!slb_shadow) in allocate_slb_shadows() if you agree.

Thanks,
Gavin

>cheers
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

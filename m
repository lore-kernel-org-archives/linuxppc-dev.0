Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 826862C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 06:42:41 +1000 (EST)
Message-ID: <500F08B5.70901@freescale.com>
Date: Tue, 24 Jul 2012 15:42:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500EE4C3.40707@freescale.com>
 <500EEA46.6030807@freescale.com> <500EEF86.5040806@freescale.com>
In-Reply-To: <500EEF86.5040806@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2012 01:55 PM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>>>>> +	compatible = "fsl,P5040";
>>>>
>>>> When would we not override this?
>>>
>>> I don't understand.
>>
>> I was wondering why we put these chip-based toplevel compatibles in the
>> dtsi, when we'll always overwrite it with a board-based toplevel compatible.
> 
> That's a good point, but I'm loathe to break the current convention.  I'd
> rather post a patch that removes them from all boards, but I'd like an ACK
> from Kumar first.

Yeah, that was more a question for Kumar and the list than a "remove
this" request.

>>>> Why are kernel/dtb read only?
>>>
>>> Because that's how it is on the P5020!
>>
>> This is a copy-and-paste meme that I've probably complained about a few
>> dozen times by now. :-)
> 
> I know, I know, but you would think problems like this would already be
> fixed upstream.  I didn't think I would need to review every single
> property in the P5020 device trees.

In this particular case I should probably go fix the existing trees, but
in general blind copy and paste is a bad thing.

Maybe we should have include files for common partition schemes.

>>> This is how the structure is defined in smp.c:
>>>
>>> struct smp_ops_t smp_85xx_ops = {
>>> 	.kick_cpu = smp_85xx_kick_cpu,
>>> #ifdef CONFIG_KEXEC
>>> 	.give_timebase	= smp_generic_give_timebase,
>>> 	.take_timebase	= smp_generic_take_timebase,
>>> #endif
>>> };
>>>
>>> This code has not changed in years.
>>
>> There was a patch to fix this, but I guess it hasn't been merged yet.
> 
> Can you give me a clue which patch this is, so I can find it on the
> mailing list?

http://patchwork.ozlabs.org/patch/172243/

...but it only deals with e500v2 so far, so I was wrong when I said that
patch fixes it.  Once we do the equivalent thing for e500mc we can
remove all mpc85xx references to the generic tbsync code.

-Scott

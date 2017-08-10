Return-Path: <clg@kaod.org>
Received: from 9.mo179.mail-out.ovh.net (9.mo179.mail-out.ovh.net
 [46.105.76.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSfdq6JlkzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 17:19:27 +1000 (AEST)
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id EA9045B445
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 09:19:23 +0200 (CEST)
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e1759aa5-68d0-54ef-87fd-32908ff9ffbc@kaod.org>
Date: Thu, 10 Aug 2017 09:19:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170810042849.GU13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> +static void xive_spapr_update_pending(struct xive_cpu *xc)
>>>> +{
>>>> +	u8 nsr, cppr;
>>>> +	u16 ack;
>>>> +
>>>> +	/* Perform the acknowledge hypervisor to register cycle */
>>>> +	ack = be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
>>>
>>> Why do you need the raw_readw() + be16_to_cpu + mb, rather than one of
>>> the higher level IO helpers?
>>
>> This is one of the many ways to do MMIOs on the TIMA. This memory 
>> region defines a set of offsets and sizes for which loads and 
>> stores have different effects. 
>>
>> See the arch/powerpc/include/asm/xive-regs.h file and 
>> arch/powerpc/kvm/book3s_xive_template.c for some more usage.
> 
> Sure, much like any IO region.  My point is, why do you want this kind
> of complex combo, rather than say an in_be16() or readw_be().
> 

The code is inherited from the native backend. 

I think this is because we know what we are doing and we skip 
the synchronization routines of the higher level IO helpers. 
That might not be necessary for sPAPR. Ben ? 

Thanks,

C.   

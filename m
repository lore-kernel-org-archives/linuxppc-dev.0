Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F0F21A023F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 18:04:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 15 Dec 2014 17:04:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 67100357806B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 18:04:33 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBF74NJj30867470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 18:04:33 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBF73xEG013458
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 18:03:59 +1100
Message-ID: <548E87CD.5040008@linux.vnet.ibm.com>
Date: Mon, 15 Dec 2014 12:33:41 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v4,4/4] powernv: powerpc: Add winkle support for offline cpus
References: <20141214100600.3446B140119@ozlabs.org>
 <548D7A0E.2060107@linux.vnet.ibm.com>
 <1418601701.19970.4.camel@ellerman.id.au>
In-Reply-To: <1418601701.19970.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 15 December 2014 05:31 AM, Michael Ellerman wrote:
> On Sun, 2014-12-14 at 17:22 +0530, Shreyas B Prabhu wrote:
>> On Sunday 14 December 2014 03:35 PM, Michael Ellerman wrote:
>>>> diff --git a/arch/powerpc/platforms/powernv/subcore.h b/arch/powerpc/platforms/powernv/subcore.h
>>>> index 148abc9..604eb40 100644
>>>> --- a/arch/powerpc/platforms/powernv/subcore.h
>>>> +++ b/arch/powerpc/platforms/powernv/subcore.h
>>>> @@ -15,4 +15,5 @@
>>>>  
>>>>  #ifndef __ASSEMBLY__
>>>>  void split_core_secondary_loop(u8 *state);
>>>> +extern void update_subcore_sibling_mask(void);
>>>>  #endif
>>>
>>> subcore.c isn't built for CONFIG_SMP=n, resulting in:
>>>
>>>   setup.c:(.init.text+0x34b0): undefined reference to `.update_subcore_sibling_mask'
>>>
>>> I needed to add:
>>>
>>> +#else
>>> +static inline void update_subcore_sibling_mask(void) { };
>>> +#endif /* CONFIG_SMP */
> 
>> Sorry I missed that.
> 
> No worries.
> 
> Can you please do a quick test with a SMP=n kernel.
> 
> It looks like it should work, but it would be good to test.
> 
I successfully tested SMP=n kernel with your next branch.

Thanks,
Shreyas

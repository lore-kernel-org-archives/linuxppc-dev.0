Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9D302C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 10:26:45 +1000 (EST)
Message-ID: <504E853A.1010305@freescale.com>
Date: Mon, 10 Sep 2012 19:26:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
References: <20120614234101.GB17147@tyr.buserror.net>
 <1346992880.2385.51.camel@pasglop> <504A4C3D.3040709@freescale.com>
 <504A7CBC.80803@freescale.com> <1347061804.2385.58.camel@pasglop>
In-Reply-To: <1347061804.2385.58.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2012 06:50 PM, Benjamin Herrenschmidt wrote:
>>>>>  #endif /* CONFIG_PPC64 */
>>>>> @@ -377,7 +382,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
>>>>>  {
>>>>>  	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
>>>>>  
>>>>> -	if (book3e_htw_enabled) {
>>>>> +	if (book3e_htw_mode) {
>>>>
>>>> Make it if (boot3e_htw_enabled != PPC_HTW_NONE)
>>
>> Seems a little verbose, but OK.
>>
>> Same with things like this, I guess:
>> 	book3e_htw_mode ? "enabled" : "not supported"
> 
> Well, it's no longer a boolean so ...

It's pretty common to use implicit boolean conversion when a zero value
means no/false/absent, even if there are multiple non-false
possibilities (e.g. pointers) -- but not a big deal to change it if you
prefer.

> BTW. On another note, can you pickup Ananth series for larger address
> space (minus the one patch that breaks the BookE build, it shouldn't
> matter) and see if there's any runtime issue on BookE 64 ? (And whether
> the larger address space actually works for you too, using something
> like high up mmap tests)

It booted OK for me in my initial testing with a ramdisk, but when I
tried to use the network (to load a high mmap test program) I got hangs
that didn't happen before that patchset.  I'll look into it more tomorrow.

-Scott

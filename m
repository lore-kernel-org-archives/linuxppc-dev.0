Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv5QB1FW3zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 11:40:34 +1000 (AEST)
Received: by mail-pa0-x22f.google.com with SMTP id iv1so272657pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 18:40:34 -0700 (PDT)
Subject: Re: [PATCH V2 26/68] powerpc/mm/radix: Add radix pte defines
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5718531C.80903@gmail.com> <1461400219.3135.55.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571EC709.6090408@gmail.com>
Date: Tue, 26 Apr 2016 11:40:25 +1000
MIME-Version: 1.0
In-Reply-To: <1461400219.3135.55.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/04/16 18:30, Benjamin Herrenschmidt wrote:
> On Thu, 2016-04-21 at 14:12 +1000, Balbir Singh wrote:
>>> +     } while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
>>> +                                                    cpu_to_be64(old_pte),
>>> +                                                    cpu_to_be64(new_pte)));
>>> +     /* We already do a sync in cmpxchg, is ptesync needed ?*/
>>> +     asm volatile("ptesync" : : : "memory");
>>
>> Yes, I think ptesync is required after PTE changes
> 
> Is it really on radix ? I'm not 100% sure... it's usually needed to
> synchronize the writebacks of R and C...
> 

pte_update could be called to update R/reset R bit. I'll read the manual to see if I can find anything more specific

Balbir Singh.

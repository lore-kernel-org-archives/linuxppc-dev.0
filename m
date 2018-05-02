Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x234.google.com (mail-io0-x234.google.com
 [IPv6:2607:f8b0:4001:c06::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bXdH25c3zF2SZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 19:13:39 +1000 (AEST)
Received: by mail-io0-x234.google.com with SMTP id d11-v6so16616533iof.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:13:38 -0700 (PDT)
Subject: Re: [PATCH kernel 2/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical pages
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-3-aik@ozlabs.ru>
 <20180502155323.30c41ce4@balbir.ozlabs.ibm.com>
 <c04cd729-fd88-ed46-cfcb-93324bb243f3@ozlabs.ru>
 <CAKTCnzkfXjj4o7NRUsjgDOenZjgcxbhUbOgBw84eqi63JzC5pg@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <29b2f646-f110-83af-dbbe-8e4584b48ab8@ozlabs.ru>
Date: Wed, 2 May 2018 19:13:32 +1000
MIME-Version: 1.0
In-Reply-To: <CAKTCnzkfXjj4o7NRUsjgDOenZjgcxbhUbOgBw84eqi63JzC5pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/5/18 6:59 pm, Balbir Singh wrote:

>>>
>>>> +    unsigned long subpg;
>>>
>>> Why not just i?
>>
>> I can imagine pages so huge so backing them with 4K will overflow 32bit
>> anyway. It is very (very) unlikely but it is 64bit arch anyway and there is
>> no much point in not-long types anyway.
>>
> 
> What David said, i is an easy iterator to understand :)


Ah, blind me. The reason for this is there is another "i" in the caller and
I found it easier not to mix this "i" (host TCE entry number) with that "i"
(guest TCE entry number).


-- 
Alexey

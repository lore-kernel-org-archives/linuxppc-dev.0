Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJKHf6qZVzDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 00:48:30 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 May 2016 10:48:28 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for book3s
 64
In-Reply-To: <1464606018.3078.199.camel@kernel.crashing.org>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
 <20160530090833.4400ac83@kryten> <87shx00we2.fsf@skywalker.in.ibm.com>
 <1464606018.3078.199.camel@kernel.crashing.org>
Date: Mon, 30 May 2016 20:18:20 +0530
Message-ID: <87pos31u17.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2016-05-30 at 14:12 +0530, Aneesh Kumar K.V wrote:
>> =C2=A0/* Encode and de-code a swap entry */
>> @@ -516,10 +533,12 @@ static inline pte_t pte_swp_mksoft_dirty(pte_t
>> pte)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __pte(pte_val(pte=
) | _PAGE_SWP_SOFT_DIRTY);
>> =C2=A0}
>
> These kind of setters (and mkspecial etc...) could also just OR
> the byteswapped constant to the raw PTE..
>

We seems to be doing the right thing w.r.t setters


static inline pte_t pte_mkdirty(pte_t pte)
{
        return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
     9d8:       ff ff 40 39     li      r10,-1
     9dc:       04 00 4a 79     rldicr  r10,r10,0,0
     9e0:       78 53 2a 7d     or      r10,r9,r10
}

-aneesh

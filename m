Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJDDk2Js6zDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 21:00:37 +1000 (AEST)
Message-ID: <1464606018.3078.199.camel@kernel.crashing.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Date: Mon, 30 May 2016 21:00:18 +1000
In-Reply-To: <87shx00we2.fsf@skywalker.in.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
 <20160530090833.4400ac83@kryten> <87shx00we2.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-30 at 14:12 +0530, Aneesh Kumar K.V wrote:
>  /* Encode and de-code a swap entry */
> @@ -516,10 +533,12 @@ static inline pte_t pte_swp_mksoft_dirty(pte_t
> pte)
>  {
>         return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
>  }

These kind of setters (and mkspecial etc...) could also just OR
the byteswapped constant to the raw PTE..

Cheers,
Ben.

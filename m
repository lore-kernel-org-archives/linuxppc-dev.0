Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E9A51A0549
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:32:26 +1100 (AEDT)
Date: Thu, 18 Feb 2016 12:11:52 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 20/35] powerpc/mm: Don't track subpage valid bit in
 pte_t
Message-ID: <20160218011152.GA2765@fergus.ozlabs.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448941020-15168-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 01, 2015 at 09:06:45AM +0530, Aneesh Kumar K.V wrote:
> This free up 11 bits in pte_t. In the later patch we also change
> the pte_t format so that we can start supporting migration pte
> at pmd level. We now track 4k subpage valid bit as below
> 
> If we have _PAGE_COMBO set, we override the _PAGE_F_GIX_SHIFT
> and _PAGE_F_SECOND. Together we have 4 bits, each of them
> used to indicate whether any of the 4 4k subpage in that group
> is valid. ie,
> 
> [ group 1 bit ]   [ group 2 bit ]  ..... [ group 4 ]
> [ subpage 1 - 4]  [ subpage 5- 8]  ..... [ subpage 13 - 16]
> 
> We still track each 4k subpage slot number and secondary hash
> information in the second half of pgtable_t. Removing the subpage
> tracking have some significant overhead on aim9 and ebizzy benchmark and
> to support THP with 4K subpage, we do need a pgtable_t of 4096 bytes.

I know this has already been applied, but this hunk looks wrong:

> @@ -102,7 +131,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 */
>  	if (!(old_pte & _PAGE_COMBO)) {
>  		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
> -		old_pte &= ~_PAGE_HPTE_SUB;
> +		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;

Shouldn't this be:

+		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);

instead?

Paul.

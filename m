Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF33A1A0311
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 19:29:11 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 5 Mar 2016 01:29:10 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9FAE819D806A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 01:17:02 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u258T6Y536962466
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Mar 2016 01:29:06 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u258T696027093
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Mar 2016 01:29:06 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
In-Reply-To: <20160302010759.GB3160@oak.ozlabs.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160302010759.GB3160@oak.ozlabs.ibm.com>
Date: Sat, 05 Mar 2016 13:59:02 +0530
Message-ID: <87lh5xs4z5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> [ text/plain ]
> On Fri, Feb 26, 2016 at 08:50:50AM +0530, Aneesh Kumar K.V wrote:
>> _PAGE_PRIV means the page can be accessed only by kernel. This is done
>> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
>> pages are now makred by clearing _PAGE_PRIV bit.
>
>

.....

>> @@ -40,6 +40,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		if (unlikely(access & ~old_pte))
>>  			return 1;
>
> This check is going to do a different thing now as far as
> _PAGE_USER/_PAGE_PRIV is concerned: previously it would prevent a
> non-privileged access to a privileged page from creating a HPTE, now
> it prevents a privileged access to a non-privileged page from creating
> a HPTE.  A privileged access means an access by the kernel to a high
> address, and arguably we would never have a non-privileged PTE at a
> high (i.e. kernel) address, but it's still a semantic change that
> should have been flagged in the patch description.


We don't set _PAGE_PRIVILGED when we have a privilged acess to a non
privilged page. We set it as below (with updated comments)

	/*
	 * We set _PAGE_PRIVILEGED only when
	 * kernel mode access kernel space.
	 *
	 * _PAGE_PRIVILGED is NOT set
	 * 1) when kernel mode access user space
	 * 2) user space access kernel space.
	 */
	if (!(msr & MSR_PR) && !(REGION_ID(ea) == USER_REGION_ID))
		access |= _PAGE_PRIVILEGED;



>
> In fact it wouldn't really matter if we didn't check the privilege
> here and went ahead and created the HPTE - if it's a non-privileged
> access to a privileged page, the HPTE will get its permission bits set
> so as to prevent non-privileged access anyway.
>
>>  		/*
>> +		 * access from user, but pte in _PAGE_PRIV
>> +		 */
>> +		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
>> +			return 1;
>
> And this catches both the privileged access to non-privileged page
> case (which the previous statement already caught) and the
> non-privileged access to privileged page case.

The actual PRIVILEGED check is done by the above conditional. 


-aneesh

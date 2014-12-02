Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 946711A0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 17:55:19 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 12:25:13 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 612CE1258056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 12:25:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB26tlKh53674042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:25:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB26t9lY017756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:25:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request with
 NO HPTE fault
In-Reply-To: <1417480795.31336.4.camel@concordia>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1417480795.31336.4.camel@concordia>
Date: Tue, 02 Dec 2014 12:25:02 +0530
Message-ID: <87mw76h77d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Mon, 2014-11-03 at 20:21 +0530, Aneesh Kumar K.V wrote:
>> upatepp get called for a nohpte fault, when we find from the linux
>> page table that the translation was hashed before. In that case
>> we are sure that there is no existing translation, hence we could
>> avoid doing tlbie.
>
> We are sure there *was* no existing translation. It's possible that since the
> nohpte fault occurred the translation has been loaded into the tlb.
>
> Ben says that's OK, because updatepp is only ever relaxing permissions. But
> please add some explanation of that to the changelog - it's not obvious.
>
>> @@ -322,8 +322,15 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>>  		}
>>  		native_unlock_hpte(hptep);
>>  	}
>> -	/* Ensure it is out of the tlb too. */
>> -	tlbie(vpn, bpsize, apsize, ssize, local);
>> +
>> +	if (flags & HPTE_LOCAL_UPDATE)
>> +		local = 1;
>> +	/*
>> +	 * Ensure it is out of the tlb too if it is not a nohpte fault
>> +	 */
>> +	if (!(flags & HPTE_NOHPTE_UPDATE))
>> +		tlbie(vpn, bpsize, apsize, ssize, local);
>> +
>>  	return ret;
>>  }
>
> The context preceeding this hunk includes this comment:
>
> 	/*
> 	 * We need to invalidate the TLB always because hpte_remove doesn't do
> 	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
> 	 * random entry from it. When we do that we don't invalidate the TLB
> 	 * (hpte_remove) because we assume the old translation is still
> 	 * technically "valid".
> 	 */
>
> Which seems out of sync with the code now.

The comment is still valid. What it explain is the part that, even if we
didn't find hash pte matching we still need to do a tlbie. We don't look
at the nohpte fault details in the comment.

-aneesh

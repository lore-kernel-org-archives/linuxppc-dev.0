Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E24141A030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 01:30:00 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 19:59:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DDA761258023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 20:00:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3EUTs7131474
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 20:00:29 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3ETrx0026484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 19:59:53 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/mm: don't do tlbie for updatepp request with
 NO HPTE fault
In-Reply-To: <1417577863.16722.10.camel@concordia>
References: <1417503002-22086-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1417577863.16722.10.camel@concordia>
Date: Wed, 03 Dec 2014 19:59:52 +0530
Message-ID: <87oarkbycf.fsf@linux.vnet.ibm.com>
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

> On Tue, 2014-12-02 at 12:20 +0530, Aneesh Kumar K.V wrote:
>> upatepp get called for a nohpte fault, when we find from the linux
>> page table that the translation was hashed before. In that case
>> we are sure that there is no existing translation, hence we could
>> avoid doing tlbie.
>
> Same comments as last time.
>
> http://patchwork.ozlabs.org/patch/406219/

I replied to that review feedback right ? 

   > We are sure there *was* no existing translation. It's possible that since the
   > nohpte fault occurred the translation has been loaded into the tlb.
   >
   > Ben says that's OK, because updatepp is only ever relaxing permissions. But
   > please add some explanation of that to the changelog - it's not obvious.

I am not sure what we need to document. We look at pte bits to determine
the access bits in hpte, so even if we race and miss the tlbie, we
should have the right permissions. Or are you suggesting that we capture
in commit message that, even if we have parrallel fault, we should be
ok if we skip the tlbie ? Or do you want to capture the fact that
mprotect won't call updatepp, because that involve a
ptep_modify_prot_start which cause a hpte invalidate and not updatepp ?


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

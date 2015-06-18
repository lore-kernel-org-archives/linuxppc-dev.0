Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441671A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 15:20:54 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 10:50:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 766FF1258059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:53:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5I5Klpm49676532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:50:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5I5KlCU027371
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:50:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v2 2/2] powerpc/mm: Change the swap encoding in pte.
In-Reply-To: <1434575662.2353.107.camel@freescale.com>
References: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87616ngi8x.fsf@linux.vnet.ibm.com> <1434534342.28933.5.camel@ellerman.id.au>
 <1434575662.2353.107.camel@freescale.com>
Date: Thu, 18 Jun 2015 10:50:46 +0530
Message-ID: <871th9h9sh.fsf@linux.vnet.ibm.com>
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

Scott Wood <scottwood@freescale.com> writes:

> On Wed, 2015-06-17 at 19:45 +1000, Michael Ellerman wrote:
>> On Wed, 2015-06-17 at 08:21 +0530, Aneesh Kumar K.V wrote:
>> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> > 
>> > 
>> > Hi Scott,
>> > 
>> > > Current swap encoding in pte can't support large pfns
>> > > above 4TB. Change the swap encoding such that we put
>> > > the swap type in the PTE bits. Also add build checks
>> > > to make sure we don't overlap with HPTEFLAGS.
>> > > 
>> > 
>> > Can you please review this w.r.t 64bit booke ? 
>
> It looks OK.
>
> I'm curious why _PAGE_BIT_SWAP_TYPE is 2 -- it seems like it could be 
> any value >= 1 that isn't large enough to cause a conflict. Does 
> something get stored in that second bit?

Yes, we should be able to use >= 1. But then our _PAGE_USER is also used
to indicate prot_none. It should really be _PAGE_PRESENT set and
_PAGE_USER cleared. So for the swap case we should be ok to use
_PAGE_USER. But i didn't want to audit all the asm code. So i decided to
leave _PAGE_USER as it is.


>
>> I booted it on our p5020ds FWIW.
>
> Actively using swap?
>

-aneesh

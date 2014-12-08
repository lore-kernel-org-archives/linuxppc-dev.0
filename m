Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5165E1A026F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 22:35:44 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Mon, 8 Dec 2014 11:35:40 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D03717D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 11:35:59 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB8BZcUa57933984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 11:35:38 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB8BZarS032144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 04:35:37 -0700
Message-ID: <54858D07.2030403@de.ibm.com>
Date: Mon, 08 Dec 2014 12:35:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the access_once tree
References: <20141208222641.40a64946@canb.auug.org.au>
In-Reply-To: <20141208222641.40a64946@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Cc: linux-next@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 08.12.2014 um 12:26 schrieb Stephen Rothwell:
> Hi Christian,
> 
> After merging the acess_once tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
> 
> arch/powerpc/mm/hugetlbpage.c: In function 'find_linux_pte_or_hugepte':
> arch/powerpc/mm/hugetlbpage.c:981:3: error: invalid initializer
>    pud  = ACCESS_ONCE(*pudp);
>    ^
> arch/powerpc/mm/hugetlbpage.c:993:4: error: invalid initializer
>     pmd  = ACCESS_ONCE(*pmdp);
>     ^
> 
> These are preexisting ...
> 
> mm/gup.c: In function 'gup_pmd_range':
> mm/gup.c:929:3: error: invalid initializer
>    pmd_t pmd = ACCESS_ONCE(*pmdp);
>    ^
> mm/gup.c:929:3: error: (near initialization for 'pmd')
> 
> This is from commit f30c59e921f1 ("mm: Update generic gup
> implementation to handle hugepage directory") from the powerpc-mpe (and
> powerpc) tree and so will require a merge fix patch (presumable
> s/ACCESS_ONCE/READ_ONCE/).
> 
> I am not sure how many architectures you are trying to cover, but
> powerpc is one I care about :-)
> 
> I have dropped the access_once tree again today, sorry (its too late at
> night).

Yes, we expect that tightening ACCESS_ONCE will trigger these bugs. I tried to cover everything in Linus master, but next is certainly a new game. It will be pretty hard for me to keep this running when hundreds of trees get merged during 3.19-rc. :-(

Linus, I see two options:

a: Either we go a full round in linux-next and expect all trees to follow the new rules, so we can merge this for 3.20
b: Only apply READ/ASSIGN_ONCE and the first fixups for 3.19 and put the ACCESS_ONCE change in next after rc1 so it will go in for 3.20 (or later) so that people can adopt. 

Any opinions?

Christian

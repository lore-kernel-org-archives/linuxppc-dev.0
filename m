Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5164C1A0344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 06:54:34 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 9 Dec 2014 19:54:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B41517D8043
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 19:54:50 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9JsSci54067390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 19:54:28 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9JsRYG011563
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 12:54:28 -0700
Message-ID: <54875373.50305@de.ibm.com>
Date: Tue, 09 Dec 2014 20:54:27 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the access_once tree
References: <20141208222641.40a64946@canb.auug.org.au>
In-Reply-To: <20141208222641.40a64946@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
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
> 

Next try. I removed the change of ACCESS_ONCE and just left the new interfaces and the simple reworks in the queue.
I will tackle everything else after rc1 when next should be small again. Keeping fingers crossed....

Christian

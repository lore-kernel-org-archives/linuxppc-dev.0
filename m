Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425bd753sLzF3LJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 19:59:07 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w869wrIn047799
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2018 05:59:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2maypg6d31-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2018 05:59:04 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 6 Sep 2018 10:59:02 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
Date: Thu, 06 Sep 2018 15:28:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8736uneylc.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
> common parts of code.
> Using those directly in common parts of code have proven to lead to
> mistakes or misbehaviour, because their use is not always as trivial
> as one could think.
>
> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
> that a page is a kernel page, because some targets are using
> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be 
> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
> This has to (bad) consequences:
>
>  - All targets must define every bit, even the unsupported ones,
>    leading to a lot of useless #define _PAGE_XXX 0
>  - If someone forgets to take into account all possible _PAGE_XXX bits
>    for the case, we can get unexpected behaviour on some targets.
>
> This becomes even more complex when we come to using _PAGE_RW.
> Testing (flags & _PAGE_RW) is not enough to test whether a page
> if writable or not, because:
>
>  - Some targets have _PAGE_RO instead, which has to be unset to tell
>    a page is writable
>  - Some targets have _PAGE_R and _PAGE_W, in which case
>    _PAGE_RW = _PAGE_R | _PAGE_W
>  - Even knowing whether a page is readable is not always trivial because:
>    - Some targets requires to check that _PAGE_R is set to ensure page
>    is readable
>    - Some targets requires to check that _PAGE_NA is not set
>    - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>
> Etc ....
>
> In order to work around all those issues and minimise the risks of errors,
> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
> are then defined in target specific parts of the kernel code.

The series is really good. It also helps in code readability. Few things
i am not sure there is a way to reduce the overhead

-		access = _PAGE_EXEC;
+		access = pte_val(pte_mkexec(__pte(0)));

Considering we have multiple big endian to little endian coversion there
for book3s 64.

Other thing is __ioremap_at where we do

+       pte_t pte = __pte(flags);
 
        /* Make sure we have the base flags */
-       if ((flags & _PAGE_PRESENT) == 0)
+       if (!pte_present(pte))

-               err = map_kernel_page(v+i, p+i, flags);
+               err = map_kernel_page(v + i, p + i, pte_val(pte));


But otherwise for the series.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> 

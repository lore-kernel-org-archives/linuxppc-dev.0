Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4255651TSKzF33Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 00:03:56 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w85E0AE6025166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 10:03:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mafkfb9r0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 10:03:50 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 5 Sep 2018 08:03:42 -0600
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 5 Sep 2018 19:33:33 +0530
MIME-Version: 1.0
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <95ee30b8-70b5-0f74-b677-417d3b0ca19e@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2018 06:06 PM, Christophe Leroy wrote:
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
>   - All targets must define every bit, even the unsupported ones,
>     leading to a lot of useless #define _PAGE_XXX 0
>   - If someone forgets to take into account all possible _PAGE_XXX bits
>     for the case, we can get unexpected behaviour on some targets.
> 
> This becomes even more complex when we come to using _PAGE_RW.
> Testing (flags & _PAGE_RW) is not enough to test whether a page
> if writable or not, because:
> 
>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>     a page is writable
>   - Some targets have _PAGE_R and _PAGE_W, in which case
>     _PAGE_RW = _PAGE_R | _PAGE_W
>   - Even knowing whether a page is readable is not always trivial because:
>     - Some targets requires to check that _PAGE_R is set to ensure page
>     is readable
>     - Some targets requires to check that _PAGE_NA is not set
>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
> 
> Etc ....
> 
> In order to work around all those issues and minimise the risks of errors,
> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
> are then defined in target specific parts of the kernel code.

We recently did on book3s 64.

static inline int pte_present(pte_t pte)
{
	/*
	 * A pte is considerent present if _PAGE_PRESENT is set.
	 * We also need to consider the pte present which is marked
	 * invalid during ptep_set_access_flags. Hence we look for _PAGE_INVALID
	 * if we find _PAGE_PRESENT cleared.
	 */
	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
}

So I guess with that pte_present conversion we need to be careful.

Do you have a git tree which I can use to double check?

-aneesh

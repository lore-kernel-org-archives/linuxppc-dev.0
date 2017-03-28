Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsncT6HsNzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:46:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
In-Reply-To: <20170328052559.12912-1-aik@ozlabs.ru>
References: <20170328052559.12912-1-aik@ozlabs.ru>
Date: Tue, 28 Mar 2017 21:45:58 +1100
Message-ID: <87y3vpadcp.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The CMA pages migration code does not support compound pages at
> the moment so it performs few tests before proceeding to actual page
> migration.
>
> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
> it should be called on head pages. Since we also test for PageCompound(),
> and it contains PageTail(), we can simply move PageCompound() in front
> of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Some of actual POWER8 systems do crash on that BUG_ON.

So this is:

Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")

And therefore:

Cc: stable@vger.kernel.org # v4.9+

?

cheers

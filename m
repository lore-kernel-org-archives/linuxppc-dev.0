Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Kk372vBzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 18:20:27 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id o123so28871819pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:20:27 -0700 (PDT)
Message-ID: <1491898818.8380.3.camel@gmail.com>
Subject: Re: [PATCH kernel v2] powerpc/iommu: Do not call PageTransHuge() on
 tail pages
From: Balbir Singh <bsingharora@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Paul
 Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  #@ozlabs.ru, v4.9+@ozlabs.ru
Date: Tue, 11 Apr 2017 18:20:18 +1000
In-Reply-To: <20170411075457.28020-1-aik@ozlabs.ru>
References: <20170411075457.28020-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 17:54 +1000, Alexey Kardashevskiy wrote:
> The CMA pages migration code does not support compound pages at
> the moment so it performs few tests before proceeding to actual page
> migration.
> 
> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
> it is designed to be called on head pages only. Since we also test for
> PageCompound(), and it contains PageTail() and PageHead(), we can
> simplify the check by leaving just PageCompound() and therefore avoid
> possible VM_BUG_ON_PAGE.
> 
> Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> ---
> 
> Changes:
> v2:
> * instead of moving PageCompound() to the beginning, this just drops
> PageHuge() and PageTransHuge()
>

Looks good! My Acked-by is already present

Balbir Singh. 

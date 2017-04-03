Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxHcH54llzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 13:27:59 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 81so26751235pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Apr 2017 20:27:58 -0700 (PDT)
Message-ID: <1491190072.8948.1.camel@gmail.com>
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on
 tail pages
From: Balbir Singh <bsingharora@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Date: Mon, 03 Apr 2017 13:27:52 +1000
In-Reply-To: <20170328052559.12912-1-aik@ozlabs.ru>
References: <20170328052559.12912-1-aik@ozlabs.ru>
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

On Tue, 2017-03-28 at 16:25 +1100, Alexey Kardashevskiy wrote:
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

The fix looks reasonable to me. I suspect the checks can be simplified
and we can support split and move of THP in the future.

For now, looks good

Acked-by: Balbir Singh <bsingharora@gmail.com>

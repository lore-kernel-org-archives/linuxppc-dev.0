Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq7TX08M5zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 00:59:43 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 20:29:41 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3JExbMO61145286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:29:37 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3JExZ02029723
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:29:37 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
In-Reply-To: <3qk8fY48r6z9t45@ozlabs.org>
References: <3qk8fY48r6z9t45@ozlabs.org>
Date: Tue, 19 Apr 2016 10:59:29 -0400
Message-ID: <87y4893ar2.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>> 
> ...
>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>> and from 13-64 to 9-13 for 4K pages.
>> 
>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>

HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
size. We do have the below constraint w.r.t hugetlb pages

static inline bool hstate_is_gigantic(struct hstate *h)
{
	return huge_page_order(h) >= MAX_ORDER;
}

That require MAX_ORDER to be greater than 12.

Did we test hugetlbfs 4k config with this patch ? Will it work if we
start marking hugepage as gigantic page ?

-aneesh

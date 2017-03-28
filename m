Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsqCk4CtlzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 22:58:10 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id o123so18074428pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 04:58:10 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170328052559.12912-1-aik@ozlabs.ru>
 <87y3vpadcp.fsf@concordia.ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, Balbir Singh <bsingharora@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d50693b8-6c6b-8779-0774-5fbbec23771f@ozlabs.ru>
Date: Tue, 28 Mar 2017 22:58:01 +1100
MIME-Version: 1.0
In-Reply-To: <87y3vpadcp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/03/17 21:45, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> The CMA pages migration code does not support compound pages at
>> the moment so it performs few tests before proceeding to actual page
>> migration.
>>
>> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
>> it should be called on head pages. Since we also test for PageCompound(),
>> and it contains PageTail(), we can simply move PageCompound() in front
>> of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Some of actual POWER8 systems do crash on that BUG_ON.
> 
> So this is:
> 
> Fixes: 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate pinned pages out of CMA")
> 
> And therefore:
> 
> Cc: stable@vger.kernel.org # v4.9+
> 
> ?

May be, first I want to make sure this is enough fix, this is why I
(re)added Balbir in cc list.


-- 
Alexey

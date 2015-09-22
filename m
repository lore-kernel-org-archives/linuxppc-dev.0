Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0FB31A014D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:45:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 16:45:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EAA422CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:45:22 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8M6jEe646530722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:45:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8M6io92009202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:44:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/31] powerpc/mm: Don't use pte_val as lvalue
In-Reply-To: <20150922022223.GA12728@home.buserror.net>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150922022223.GA12728@home.buserror.net>
Date: Tue, 22 Sep 2015 12:14:23 +0530
Message-ID: <87d1xb3qd4.fsf@linux.vnet.ibm.com>
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

> On Mon, Sep 21, 2015 at 12:10:36PM +0530, Aneesh Kumar K.V wrote:
>> +static inline pte_t pte_mkwrite(pte_t pte)
>> +{
>> +	pte_basic_t ptev;
>> +
>> +	ptev = pte_val(pte) & ~_PAGE_RO;
>> +	ptev |= _PAGE_RW;
>> +	return __pte(pte);
>> +}
>
> s/__pte(pte)/__pte(ptev)/
>
> ...to fix an endless handle_mm_fault() loop.
>
> CONFIG_STRICT_MM_TYPECHECKS would have caught this.
>

Thanks will update the patch. As you noticied the patch series was not
tested on anything other than power7 and power8 (BE/LE). So any testing
on other platforms is going to be really useful. Now I did compile test
this with large number of configs. I guess none of them enable
STRICT_MM_TYPES.

Did the series boot fine on the platform after the above fix ?

-aneesh

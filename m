Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C6231A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 20:57:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 May 2015 16:26:58 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A5B10125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 16:29:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47Aurur917874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 16:26:54 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47ANnLX022282
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 15:53:49 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/mm: Return NULL for not present hugetlb page
In-Reply-To: <1430986646.3453.34.camel@kernel.crashing.org>
References: <1430982981-23700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1430986646.3453.34.camel@kernel.crashing.org>
Date: Thu, 07 May 2015 16:26:53 +0530
Message-ID: <87h9rod5ai.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2015-05-07 at 12:46 +0530, Aneesh Kumar K.V wrote:
>> We need to check whether pte is present in follow_huge_addr and
>> properly return NULL if mapping is not present. Also use READ_ONCE
>> when dereferencing pte_t address.
>
> Do that need to go to stable as well ?

Yes. I will like David to take a look at this and give his feedback.
W.r.t patch itself I hit a build failure on mpc85xx_smp_defconfig. I will
resent after the test build finish on all configs

-aneesh

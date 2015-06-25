Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46A341A1051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 22:51:45 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2611E1402EC
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 22:51:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 18:21:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5F7103940060
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:21:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PCpMLw28246114
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:21:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PBnGUv020862
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 17:19:17 +0530
Message-ID: <558BF949.7050807@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 18:21:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V9 02/13] powerpc, perf: Change type of the bhrb_users
 variable
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-3-git-send-email-khandual@linux.vnet.ibm.com>
 <1435210920.4286.38.camel@axtens.net>
In-Reply-To: <1435210920.4286.38.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 11:12 AM, Daniel Axtens wrote:
>> -	int				bhrb_users;
>> +	unsigned int			bhrb_users;
> 
> OK, so this is a good start.
> 
> A quick git grep for bhrb_users reveals this:
> perf/core-book3s.c:     WARN_ON_ONCE(cpuhw->bhrb_users < 0);
> 
> That occurs in power_pmu_bhrb_disable, immediately following a decrement
> of bhrb_users. Now that the test can never be true, this patch should
> change the function to check if bhrb_users is 0 before decrementing.

Sure. Would replace with 'WARN_ON_ONCE(!cpuhw->bhrb_users)' before
decrementing bhrb_users in the function.

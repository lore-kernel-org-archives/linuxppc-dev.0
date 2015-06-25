Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95F721A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 22:50:54 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E050D1402DE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 22:50:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 18:20:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0B73C1258062
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:23:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PCoWiX57802902
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:20:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PBmQ5h016402
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 17:18:27 +0530
Message-ID: <558BF917.2070706@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 18:20:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V9 00/13] powerpc, perf: Enable SW branch filters
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1435213119.4286.51.camel@axtens.net>
In-Reply-To: <1435213119.4286.51.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 11:48 AM, Daniel Axtens wrote:

> Hi Anshuman,
> 
> Thanks for your continued work on this.
> 
> Given that the series is now at version 9 and is 13 patches long, I
> wonder if it might be worth splitting it up.

Splitting it up completely or just keeping all the generic fixes
and cleanups at the beginning of the series would be sufficient.
Anyways I am willing to send them out separately if that helps.

> 
> I'd suggest:
> 
>  - Patch 1 could be sent individually as it's a bug fix.

Not with the generic cleanup group as proposed below ?

> 
>  - Separating out a series of simple cleanups would make the actual
> changes in your patch set easier to understand. Patches 2, 3 and 5 are
> obvious candidates.

Agreed. Just that adding the first patch here will prevent a three way
split of the entire series.

> 
>  - It looks like the changes in patch 6 aren't used by any of the
> following patches. It might be worth separating that out or just
> dropping it entirely.

I guess you are talking about patch 7 "powerpc, perf: Re organize PMU
branch filter processing on POWER8". Patch 6 is getting used later on.

> 
> 
> That would give you a series with just:
> 4   powerpc, perf: Restore privilege level filter support for BHRB
> 7   powerpc, perf: Re organize PMU branch filter processing on POWER8
> 8   powerpc, perf: Change the name of HW PMU branch filter tracking variable
> 9   powerpc, lib: Add new branch analysis support functions
> 10   powerpc, perf: Enable SW filtering in branch stack sampling framework
> 11   powerpc, perf: Change POWER8 PMU configuration to work with SW filters
> 12   powerpc, perf: Enable privilege mode SW branch filters
> 13   selftests, powerpc: Add test for BHRB branch filters (HW & SW)
> 
> That might make it easier for you to start getting the ground work in,
> and make it easier for others to understand what you're trying to do.

Sure, agreed. Here are the two set of patches after the proposed split.
Patches are in the reverse order though. Hope this helps.

Generic cleanups and fixes
---------------------------

powerpc/perf: Re organize PMU branch filter processing on POWER8
powerpc/perf: Change name & type of 'pred' in power_pmu_bhrb_read
powerpc/perf: Replace last usage of get_cpu_var with this_cpu_ptr
powerpc/perf: Change type of the bhrb_users variable
powerpc/perf: Drop the branch sample when 'from' cannot be fetched

BHRB SW branch filter
----------------------

selftests/powerpc: Add test for BHRB branch filters (HW & SW)
powerpc/perf: Enable privilege mode SW branch filters
powerpc/perf: Change POWER8 PMU configuration to work with SW filters
powerpc/perf: Enable SW filtering in branch stack sampling framework
powerpc/lib: Add new branch analysis support functions
powerpc/perf: Change the name of HW PMU branch filter tracking variable
powerpc/perf: Re organize BHRB processing
powerpc/perf: Restore privilege level filter support for BHRB

Regards
Anshuman

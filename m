Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71B5B2C0082
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 22:08:14 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Apr 2013 17:32:24 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3033E1258055
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 17:39:37 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3HC81Ul6226176
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 17:38:02 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3HC84pw009833
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 22:08:05 +1000
Message-ID: <516E9096.70906@linux.vnet.ibm.com>
Date: Wed, 17 Apr 2013 17:37:50 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V2 5/5] powerpc,
 perf: Enable branch stack sampling framework support with BHRB
References: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366127650-1952-6-git-send-email-khandual@linux.vnet.ibm.com>
 <20130417070852.GA29203@concordia>
In-Reply-To: <20130417070852.GA29203@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2013 12:38 PM, Michael Ellerman wrote:
> On Tue, Apr 16, 2013 at 09:24:10PM +0530, Anshuman Khandual wrote:
>> This patch provides basic enablement for perf branch stack sampling framework
>> on POWER8 processor with a new PMU feature called BHRB (Branch History Rolling
>> Buffer).
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/core-book3s.c     | 96 +++++++++++++++++++++++++++++++++++--
>>  arch/powerpc/perf/perf_event_bhrb.c | 85 ++++++++++++++++++++++++++++++++
>>  2 files changed, 178 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/powerpc/perf/perf_event_bhrb.c
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 4ac6e64..f4d1347 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -19,6 +19,8 @@
>>  #include <asm/firmware.h>
>>  #include <asm/ptrace.h>
>>  
>> +#define BHRB_MAX_ENTRIES	32
>> +
>>  struct cpu_hw_events {
>>  	int n_events;
>>  	int n_percpu;
>> @@ -38,11 +40,21 @@ struct cpu_hw_events {
>>  
>>  	unsigned int group_flag;
>>  	int n_txn_start;
>> +
>> +	/* BHRB bits */
>> +	u64				bhrb_filter;	/* BHRB HW branch filter */
>> +	int				bhrb_users;
>> +	void				*bhrb_context;
>> +	struct	perf_branch_stack	bhrb_stack;
>> +	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
>>  };
>> +
>>  DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>>  
>>  struct power_pmu *ppmu;
>>  
>> +#include "perf_event_bhrb.c"
>> +
> 
> Um, why are you doing that?
> 

There was no specific reason for that.

> If it's code that should be in a header, put it in a header. If it's C
> code, add it to the Makefile.

Sure I would get the new code in the Makefile. Thanks!

Regards
Anshuman

> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

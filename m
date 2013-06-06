Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 625922C009E
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 16:05:10 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 11:30:31 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3C46AE0053
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 11:37:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5664oMa9568606
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 11:34:50 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5664wRN003818
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2013 16:04:58 +1000
Message-ID: <51B0266F.3090708@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 11:34:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 1/2] powerpc, perf: Ignore separate BHRB privilege
 state filter request
References: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369716452-28689-2-git-send-email-khandual@linux.vnet.ibm.com>
 <20699.1370494560@ale.ozlabs.ibm.com>
In-Reply-To: <20699.1370494560@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 10:26 AM, Michael Neuling wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> Completely ignore BHRB privilege state filter request as we are
>> already configuring that with privilege state filtering attribute
>> for the accompanying PMU event. This would help achieve cleaner
>> user space interaction for BHRB.
>>
>> This patch fixes a situation like this
>>
>> Before patch:-
>> ------------
>> ./perf record -j any -e branch-misses:k ls
>> Error:
>> The sys_perf_event_open() syscall returned with 95 (Operation not supported) for event (branch-misses:k).
>> /bin/dmesg may provide additional information.
>> No CONFIG_PERF_EVENTS=y kernel support configured?
>>
>> Here 'perf record' actually copies over ':k' filter request into BHRB
>> privilege state filter config and our previous check in kernel would
>> fail that.
>>
>> After patch:-
>> -------------
>> ./perf record -j any -e branch-misses:k ls
>> perf  perf.data  perf.data.old  test-mmap-ring
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.002 MB perf.data (~102 samples) ]
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/power8-pmu.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
>> index f7d1c4f..3a58416 100644
>> --- a/arch/powerpc/perf/power8-pmu.c
>> +++ b/arch/powerpc/perf/power8-pmu.c
>> @@ -525,16 +525,12 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
>>  	u64 pmu_bhrb_filter = 0;
>>  	u64 br_privilege = branch_sample_type & ONLY_PLM;
>>  
>> -	/* BHRB and regular PMU events share the same prvillege state
>> +	/* BHRB and regular PMU events share the same privilege state
>>  	 * filter configuration. BHRB is always recorded along with a
>> -	 * regular PMU event. So privilege state filter criteria for BHRB
>> -	 * and the companion PMU events has to be the same. As a default
>> -	 * "perf record" tool sets all privillege bits ON when no filter
>> -	 * criteria is provided in the command line. So as along as all
>> -	 * privillege bits are ON or they are OFF, we are good to go.
>> +	 * regular PMU event. As the privilege state filter is handled
>> +	 * in the basic PMC configuration of the accompanying regular
>> +	 * PMU event, we ignore any separate BHRB specific request.
>>  	 */
>> -	if ((br_privilege != 7) && (br_privilege != 0))
>> -		return -1;
> 
> br_privilege is now unused which causes this compile error.
> 
> arch/powerpc/perf/power8-pmu.c:526:6: error: unused variable ‘br_privilege’ [-Werror=unused-variable]
> 
> I assume since you didn't compile test this code, you also didn't
> runtime test it either?!!?!?!?


Always compile with the cross compiler "ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- make"
I copied over arch/powerpc/config/pseries_defconfig and compiled it. Some how it missed
to be a 64 bit kernel config which resulted in shutting down compilation of arch/powerpc/perf/power8-pmu.c
file. So never encountered this compiler warning message before. Will fix this.

Regards
Anshuman

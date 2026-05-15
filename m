Return-Path: <linuxppc-dev+bounces-20965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D657ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 08:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH0yX2L32z2yb9;
	Fri, 15 May 2026 18:40:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778834436;
	cv=none; b=SsoNAzi+0xhSX37b+P+kiOFRBq7oEUPaQhVBrQKStpkOClMy/ibXS7GkR5f57CrQbasv12pV7NnoclJHn16GrGCV1mrxt/uUgEobetJrNwUsQDk1Dsrd/YytW0swGnua0f//M8oBQw6BKiLgU17EP1XQGOnP5RcRGCCPUuhM3DKjqqC+LeF9WVQSoEoCMNP22T8/0Il10WYiRQD3f5M6YeUmAst+d1c2lj2qWQ6aiX9XcdD61x8KP6S2vkdjLZgrbE37gQnb9kt0zEsfVzdUkQ1mLGFnaMcnFBVeiIrrI6ibXfe9/2m+xCoLTaR3z3aOJdTRBEoFn8yHJPzxZ+jQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778834436; c=relaxed/relaxed;
	bh=RdG29TFBdBx9QQCNNdr8lrTQL/bIfR6gp1jNPsVGW10=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cdle+iIIzrwZAFPH2kkhpgIFeqm2l5lAYVFWZuq1vjpwZ8mGXEtzsmU+Ubm6LnXArR+vzZl+AAIr9jp0iinCvb/YSDYLQcG1hmC5Kd31w925ox708P7iPt+qe+H2urbK1jAGeKLaF4AcG6W2zPj/Z3hIJwFR+eehVbOvx4je2K4xNg+xJXlh2kn5rxmg2N1TXEKqVo+CpStPDes3MgBLxeGyxvxnPV+dFnRoKmWFWw89eAa6qFSJx8dqyjSXI3UvJpjUGCa6WuFWzzUYFny9vttqLW73hrJNywJJ0KFW/pN7lYXtranH4AC20auzGvKZTpcKfwMbII9/lDP7bUVXgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUNKP/jI; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=dapeng1.mi@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUNKP/jI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=dapeng1.mi@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH0yT1bfgz2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 18:40:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778834434; x=1810370434;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5s9WkE+DvQbSASeNGK2PjpHgJ41YEOMPYBPgMnpNXpQ=;
  b=mUNKP/jIPx11ppFj+EuhRcI/sundXQiRJFYFvQlOAWzIdKDtUG+CHnFl
   GiWyq2UxPHN4sWh9KSR6XZKSSIcyq+EvWerklGBayBjETi2Dg35ghm136
   Vh6DsU87vjA0blKe0FwV5dzrMqMnWQjvNhDw4xpv2iEPK64oN5b8ArK9M
   y/cTB/dW7GrsOMIadpt6vfoB+qDcfuC9Smx7T8yu/igh/hA8UHcfpJRpJ
   BS6wvKLIIZfjxw8zzNrXj4lEteRrQgbFQSc6yPnT6UMVSpcay+EUGppRJ
   2ozM6gT0fRCeC/BKJRM1+EKnkFbrnMdimL+AaT8yQuWTheWDUM2nBEPvh
   g==;
X-CSE-ConnectionGUID: Ll4VBHH9QXSxRCxMM62LNQ==
X-CSE-MsgGUID: dKJMWIOITGeGBrOluV7ZPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79672376"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79672376"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:25:44 -0700
X-CSE-ConnectionGUID: rj14tv9ATyOibeTzgI0fMA==
X-CSE-MsgGUID: RdxphKbsSaK0zCOxfA3ADQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232215584"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:25:39 -0700
Message-ID: <80e5932e-df03-4619-bcd4-375537538c0d@linux.intel.com>
Date: Fri, 15 May 2026 14:25:36 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Ian Rogers <irogers@google.com>, "Falcon, Thomas"
 <thomas.falcon@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>
Cc: "atrajeev@linux.ibm.com" <atrajeev@linux.ibm.com>,
 "venkat88@linux.ibm.com" <venkat88@linux.ibm.com>,
 "Shivani.Nittor@ibm.com" <Shivani.Nittor@ibm.com>,
 "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
 "hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>,
 "mpetlan@redhat.com" <mpetlan@redhat.com>,
 "Tanushree.Shah@ibm.com" <Tanushree.Shah@ibm.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>, "Chen, Zide"
 <zide.chen@intel.com>, "vmolnaro@redhat.com" <vmolnaro@redhat.com>,
 "Tejas.Manhas1@ibm.com" <Tejas.Manhas1@ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com>
 <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
 <CAP-5=fWR6v7kKSMVD+ANwMTmOdc4zKLEVY+9tNR5n+kq0F=Mkg@mail.gmail.com>
 <ec1e04d3-4235-4593-80bb-270a86e6b01f@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ec1e04d3-4235-4593-80bb-270a86e6b01f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/7/2026 8:48 AM, Mi, Dapeng wrote:
> On 4/3/2026 11:39 PM, Ian Rogers wrote:
>> On Fri, Apr 3, 2026 at 12:36 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>> On 4/3/2026 1:32 AM, Falcon, Thomas wrote:
>>>> On Wed, 2026-04-01 at 13:40 -0700, Ian Rogers wrote:
>>>>> On Mon, Mar 23, 2026 at 3:40 AM Venkat <venkat88@linux.ibm.com>
>>>>> wrote:
>>>>>>> On 15 Mar 2026, at 4:27 PM, Athira Rajeev
>>>>>>> <atrajeev@linux.ibm.com> wrote:
>>>>>>>
>>>>>>> Currently in "perf all PMU test", for "perf stat -e <event>
>>>>>>> true",
>>>>>>> below checks are done:
>>>>>>> - if return code is zero, look for "not supported" to decide pass
>>>>>>>  scenario
>>>>>>> - check for "not supported" to ignore the event
>>>>>>> - looks for "No permission to enable" to skip the event.
>>>>>>> - If output has "Bad event name", fail the test.
>>>>>>> - Use "Access to performance monitoring and observability
>>>>>>> operations is
>>>>>>>  limited." to ignore fail due to access limitations
>>>>>>>
>>>>>>> If we failed to see event and it is supported, retries with
>>>>>>> longer
>>>>>>> workload "perf bench internals synthesize".
>>>>>>> - Here if output has <event>, the test is a pass.
>>>>>>>
>>>>>>> Snippet of code check:
>>>>>>>  ```
>>>>>>>  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>>>>>>>  if echo "$output" | grep -q "$p"
>>>>>>>  ```
>>>>>>> - if output doesn't have event printed in logs, considers it
>>>>>>> fail.
>>>>>>>
>>>>>>> But this results in false pass for events in some cases.
>>>>>>> Example, if perf stat fails as below:
>>>>>>>
>>>>>>> # ./perf stat -e pmu/event/  true
>>>>>>> event syntax error: 'pmu/event/'
>>>>>>>                     \___ Bad event or PMU
>>>>>>>
>>>>>>> Unable to find PMU or event on a PMU of 'pmu'
>>>>>>> Run 'perf list' for a list of valid events
>>>>>>>
>>>>>>>  Usage: perf stat [<options>] [<command>]
>>>>>>>
>>>>>>>    -e, --event <event>   event selector. use 'perf list' to list
>>>>>>> available events
>>>>>>> # echo $?
>>>>>>> 129
>>>>>>>
>>>>>>> Since this has non-zero return code and doesn't have the
>>>>>>> fail strings being checked in the test, it will enter check using
>>>>>>> longer workload. and since the output fail log has event, it
>>>>>>> declares test as "supported".
>>>>>>>
>>>>>>> Since all the fail strings can't be added in the check, update
>>>>>>> the testcase to check return code before proceeding to longer
>>>>>>> workload run.
>>>>>>>
>>>>>>> Another missing scenario is when system wide monitoring is
>>>>>>> supported
>>>>>>> example:
>>>>>>> # ./perf stat -e pmu/event/ true
>>>>>>> Error:
>>>>>>> No supported events found.
>>>>>>>  Unsupported event (pmu/event/H) in per-thread mode, enable
>>>>>>> system wide with '-a'.
>>>>>>>
>>>>>>> Update testcase to check with "perf stat -a -e $p" as well
>>>>>>>
>>>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>>>> ---
>>>>>> Tested this patch.
>>>>>>
>>>>>>
>>>>>> With this patch:
>>>>>>
>>>>>> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero
>>>>>> return code
>>>>>> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero
>>>>>> return code
>>>>>>
>>>>>>
>>>>>>
>>>>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>>> Testing on an Intel Alderlake the test is now failing:
>>>>> ```
>>>>> ...
>>>>> Testing offcore_requests_outstanding.l3_miss_demand_data_rd --
>>>>> supported
>>>>> Testing ocr.full_streaming_wr.any_response -- perf stat failed with
>>>>> non-zero return code
>>>>> Testing ocr.partial_streaming_wr.any_response -- perf stat failed
>>>>> with
>>>>> non-zero return code
>>>>> Testing ocr.streaming_wr.any_response -- supported
>>>>> ...
>>>>> ```
>>>>>
>>>>> Running `perf stat` manually reveals an issue with the event:
>>>>> ```
>>>>> $ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
>>>>> 1
>>>>> Using CPUID GenuineIntel-6-B7-1
>>>>> Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
>>>>> ..after resolving event:
>>>>> cpu_atom/event=0xb7,period=0x186a3,umask=0x1,offcore_rsp=0x8000000100
>>>>> 00/
>>>>> ocr.full_streaming_wr.any_response ->
>>>>> cpu_atom/ocr.full_streaming_wr.any_response/
>>>>> Control descriptor is not initialized
>>>>> ------------------------------------------------------------
>>>>> perf_event_attr:
>>>>>  type                             10 (cpu_atom)
>>>>>  size                             144
>>>>> ------------------------------------------------------------
>>>>> perf_event_attr:
>>>>>  type                             0 (PERF_TYPE_HARDWARE)
>>>>>  config                           0xa00000000
>>>>> (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
>>>>>  disabled                         1
>>>>> ------------------------------------------------------------
>>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>>>>> ------------------------------------------------------------
>>>>> perf_event_attr:
>>>>>  type                             0 (PERF_TYPE_HARDWARE)
>>>>>  config                           0x400000000
>>>>> (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
>>>>>  disabled                         1
>>>>> ------------------------------------------------------------
>>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>>>>>  config                           0x1b7
>>>>> (ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
>>>>>  sample_type                      IDENTIFIER
>>>>>  read_format
>>>>> TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>>>  disabled                         1
>>>>>  inherit                          1
>>>>>  { bp_addr, config1 }             0x800000010000
>>>>> ------------------------------------------------------------
>>>>> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
>>>>> sys_perf_event_open failed, error -22
>>>>> switching off deferred callchain support
>>>>> Warning:
>>>>> ocr.full_streaming_wr.any_response event is not supported by the
>>>>> kernel.
>>>>> The sys_perf_event_open() syscall failed for event
>>>>> (ocr.full_streaming_wr.any_response): Invalid argument
>>>>> "dmesg | grep -i perf" may provide additional information.
>>>>>
>>>>> Error:
>>>>> No supported events found.
>>>>> The sys_perf_event_open() syscall failed for event
>>>>> (ocr.full_streaming_wr.any_response): Invalid argument
>>>>> "dmesg | grep -i perf" may provide additional information.
>>>>> ```
>>>>>
>>>>> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>>> Hmm, it looks the error is caused by the invalid bitmask of OFFCORE_RSP_x
>>> MSRs. Currently the valid bitmask of OFFCORE_RSP_x MSR is set to
>>> 0x3fffffffff in intel_grt_extra_regs[], while the msr value is set
>>> 0x800000010000 for the ocr.full_streaming_wr.any_response event. The bit 47
>>> is recognized an invalid bit and then abort the event creation.
>>>
>>> Base on the description "Table 21-56. MSR_OFFCORE_RSPx Request Type
>>> Definition" in SDM, bit 47 should be a valid bit now. Suppose bit 47 should
>>> not be a valid bit when adding the ADL PMU support, but it's updated and
>>> becomes valid later.
>>>
>>> Along with the constant updates of perf event lists
>>> (https://github.com/intel/perfmon), we have noticed there are mismatches
>>> more or less between the driver hardcoded events and perfmon event list.
>>> Currently we are summarizing the mismatches. Once these mismatches are
>>> finalized. we would submit a patchset to fix these mismatches.
>> That's great, if it takes too long perhaps we could just remove the
>> events for now.
> Suppose it won't be too long. I plan to post the patchset in next release
> cycle. The code changes are simple but need much time to verify on all
> kinds of platforms. Thanks.

The patch
(https://lore.kernel.org/all/20260515061143.338553-5-dapeng1.mi@linux.intel.com/)
would fix this issue. Thanks.


>
>
>> Thanks,
>> Ian
>>
>>> Thanks.
>>>
>>>> +Dapeng, Zide, Andi
>>>>
>>>> Thanks,
>>>> Tom
>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> Regards,
>>>>>> Venkat.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
>>>>>>> 1 file changed, 20 insertions(+)
>>>>>>>
>>>>>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh
>>>>>>> b/tools/perf/tests/shell/stat_all_pmu.sh
>>>>>>> index 9c466c0efa85..6c4d59cbfa5f 100755
>>>>>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>>>>>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>>>>>>> @@ -53,6 +53,26 @@ do
>>>>>>>     continue
>>>>>>>   fi
>>>>>>>
>>>>>>> +  # check with system wide if it is supported.
>>>>>>> +  output=$(perf stat -a -e "$p" true 2>&1)
>>>>>>> +  stat_result=$?
>>>>>>> +  if echo "$output" | grep -q "not supported"
>>>>>>> +  then
>>>>>>> +    # Event not supported, so ignore.
>>>>>>> +    echo "not supported"
>>>>>>> +    continue
>>>>>>> +  fi
>>>>>>> +
>>>>>>> +  # checked through possible access limitations and permissions.
>>>>>>> +  # At this step, non-zero return code from "perf stat" needs to
>>>>>>> +  # reported as fail for the user to investigate
>>>>>>> +  if [ $stat_result -ne 0 ]
>>>>>>> +  then
>>>>>>> +    echo "perf stat failed with non-zero return code"
>>>>>>> +    err=1
>>>>>>> +    continue
>>>>>>> +  fi
>>>>>>> +
>>>>>>>   # We failed to see the event and it is supported. Possibly the
>>>>>>> workload was
>>>>>>>   # too small so retry with something longer.
>>>>>>>   output=$(perf stat -e "$p" perf bench internals synthesize
>>>>>>> 2>&1)
>>>>>>> --
>>>>>>> 2.47.3
>>>>>>>


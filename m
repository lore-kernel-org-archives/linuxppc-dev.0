Return-Path: <yao.jin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77qb070fzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:11:54 +1000 (AEST)
Subject: Re: [PATCH v4 4/5] perf report: Show branch type statistics for stdio
 mode
From: "Jin, Yao" <yao.jin@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-5-git-send-email-yao.jin@linux.intel.com>
 <20170418185331.GC15584@krava>
 <2cc8fa33-f0f8-d202-f663-d3b6cfef43d0@linux.intel.com>
Message-ID: <8a75c7ac-5802-7e45-08d2-a83ec2e05f8e@linux.intel.com>
Date: Wed, 19 Apr 2017 12:11:49 +0800
MIME-Version: 1.0
In-Reply-To: <2cc8fa33-f0f8-d202-f663-d3b6cfef43d0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/19/2017 8:53 AM, Jin, Yao wrote:
>
>
> On 4/19/2017 2:53 AM, Jiri Olsa wrote:
>> On Wed, Apr 12, 2017 at 06:21:05AM +0800, Jin Yao wrote:
>>
>> SNIP
>>
>>> +const char *branch_type_name(int type)
>>> +{
>>> +    const char *branch_names[PERF_BR_MAX] = {
>>> +        "N/A",
>>> +        "JCC",
>>> +        "JMP",
>>> +        "IND_JMP",
>>> +        "CALL",
>>> +        "IND_CALL",
>>> +        "RET",
>>> +        "SYSCALL",
>>> +        "SYSRET",
>>> +        "IRQ",
>>> +        "INT",
>>> +        "IRET",
>>> +        "FAR_BRANCH",
>>> +    };
>>> +
>>> +    if ((type >= 0) && (type < PERF_BR_MAX))
>>> +        return branch_names[type];
>>> +
>>> +    return NULL;
>> looks like we should add util/branch.c with above functions
>> and merge it with util/parse-branch-options.c
>>
>> we create new file even for less code ;-)
>>
>> thanks,
>> jirka
>
> Could we directly add branch_type_name() in util/parse-branch-options.c?
>
> I just feel it's a bit waste of creating a new file for less code. :)
>
> Thanks
> Jin Yao

After considering again, yes, creating util/branch.c should be better. I 
will do that.

Thanks
Jin Yao

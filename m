Return-Path: <srs0=ls+1=3s=linux.vnet.ibm.com=tyreld@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1yTV1KdtzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 03:53:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1yTT5Bptz8tCT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 03:53:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1yTT0ybVz9sNZ
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 03:53:16 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3AHnOTn035436
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:53:14 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29r99tscxd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:53:14 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 11:53:13 -0600
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
 <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
 <8760ig983f.fsf@concordia.ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 10:53:08 -0700
MIME-Version: 1.0
In-Reply-To: <8760ig983f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <89aec36c-e352-e055-5e80-1235449762ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2017 09:04 PM, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> 
>> On 04/06/2017 03:27 AM, Sachin Sant wrote:
>>> On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
>>> any I/O adapter results in the following warning
>>>
>>> This problem has been in the code for some time now. I had first seen this in
>>> -next tree.
>>>

<snip>

>>> Have attached the dmesg log from the system. Let me know if any additional
>>> information is required to help debug this problem.
>>
>> I remember you mentioning this when the issue was brought up for CPUs. I
>> assume the case is the same here where the issue is only seen with
>> adapters that were hot-added after boot (ie. hot-remove of adapter
>> present at boot doesn't trip the warning)?
> 
> So who's fixing this?

I started looking at it when Bharata submitted a patch trying to fix the
issue for CPUs, but got side tracked by other things. I suspect that
this underflow has actually been an issue for quite some time, and we
are just now becoming aware of it thanks to the recount_t patchset being
merged. I'll look into it again this week.

-Tyrel

> 
> cheers
> 

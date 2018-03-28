Return-Path: <prvs=06254833f8=hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BDsK6wT8zF1k0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 04:10:10 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SH6xNx080342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 13:10:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0eefj0v4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 13:10:07 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 18:10:02 +0100
Subject: Re: [RFC PATCH] powerpc/xmon: Use OPAL_DEBUG to debug srest in OPAL
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
References: <20180326150946.23555-1-npiggin@gmail.com>
 <25588979-81cd-2a63-59f8-728686855117@linux.vnet.ibm.com>
 <20180327172856.252ec56b@roar.ozlabs.ibm.com>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 22:39:58 +0530
MIME-Version: 1.0
In-Reply-To: <20180327172856.252ec56b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ddc6bb66-9a9c-0ce8-2f49-669c5f124cf1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2018 12:58 PM, Nicholas Piggin wrote:
> On Tue, 27 Mar 2018 12:42:32 +0530
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> 
>> On 03/26/2018 08:39 PM, Nicholas Piggin wrote:
>>> xmon can be entered via sreset NMI (from a management sreset, or an
>>> NMI IPI), which can interrupt OPAL. Add checks to xmon to see if pc
>>> or sp are within OPAL memory, and if so, then use OPAL_DEBUG to
>>> print the opal stack and return the Linux stack, which can then be
>>> dumped by xmon
>>
>> Nick,
>>
>>
>> OPAL uses FSP/cronus interface for many of debug interface (like OPAL assert,
>> getting opal console, triggering FSP R/R etc). May be in future we may add new
>> debug capability.
> 
> It would be good to ensure an API could accommodate them, or at least
> not get in the way.

Agree.

> 
>> Once secureboot is enabled none of these interface work and we have limited debug
>> capability.
>>
>> Here you are using very generic API name (OPAL_DEBUG). May be we should have generic
>> interface (exported via debugfs?) here rather than SRESET specific one.
> 
> OPAL_DEBUG here actually uses the sub-function OPAL_DEBUG_DUMP_STACK (1),
> but I didn't bring that constant across from skiboot which I should have.

Nick,

May be we should define sub-function usage.  Also current API limits number of 
arguments
and its type. may be we should have argument 2 as "void *" ?
something like :
   s64 opal_debug(u32 debug_type, void *data, u64 dsize);

That way individual sub-function can parse/use based on its need.

> 
> But I don't think this is SRESET specific. If Linux has any way to get
> an r1 for a CPU in OPAL, then it can use this function. If it does not,
> then it simply can't use it.
> 
> I haven't really followed what's happening with secure boot, but presumably
> we can still get NMIs (at least machine check, even if all system reset
> sources are suppressed).

AFAIK secureboot won't block us here. It mostly blocks external entity (like 
FSP/cronus) from
accessing host memory. (like they can't directly read, write to host memory, 
SCOM operations
are restricted etc).

-Vasant

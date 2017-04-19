Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7WCY2nWmzDq9K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 04:45:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JIiUmo000894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:45:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x728kxu7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:45:14 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 14:45:13 -0400
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Steven Rostedt <rostedt@goodmis.org>, Frank Rowand <frowand.list@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <58F6C088.8020304@gmail.com>
 <20170418224953.685943a3@grimm.local.home>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com,
 mpe@ellerman.id.au, mingo@redhat.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 11:45:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170418224953.685943a3@grimm.local.home>
Content-Type: text/plain; charset=windows-1252
Message-Id: <641aa8ee-9b54-716a-77a1-076cafb95e3a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2017 07:49 PM, Steven Rostedt wrote:
> On Tue, 18 Apr 2017 18:42:32 -0700
> Frank Rowand <frowand.list@gmail.com> wrote:
> 
>> And of course the other issue with using tracepoints is the extra space
>> required to hold the tracepoint info.  With the pr_debug() approach, the
>> space usage can be easily removed for a production kernel via a config
>> option.
> 
> Now if you are saying you want to be able to enable debugging without
> the tracing infrastructure I would agree. As the tracing infrastructure
> is large. But I'm working on shrinking it more.

The primary consumers of OF_DYNAMIC seem to be pseries and powernv where
we are generally going to see the trace infrastructure enabled by
default in production.

-Tyrel

> 
>>
>> Tracepoints are wonderful technology, but not always the proper tool to
>> use for debug info.
> 
> But if you are going to have tracing enabled regardless, adding a few
> more tracepoints isn't going to make the difference.
> 
> -- Steve
> 
>>
>>> If Rob wants to convert printk() style data to trace data (and I can't
>>> convince him otherwise) then I will have further comments on this specific
>>> patch.
>>>

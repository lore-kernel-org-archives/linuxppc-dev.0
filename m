Return-Path: <prvs=06254833f8=hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BF1d5VgzzF21H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 04:17:25 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2SHGP3v112429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 13:17:23 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0eefj9kb-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 13:17:22 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 18:17:20 +0100
Subject: Re: [PATCH] powerpc/powernv/nvram: opal_nvram_write handle unknown
 OPAL errors
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
References: <20180326150233.23089-1-npiggin@gmail.com>
 <ad352964-1b12-8556-a876-a10e84336a5e@linux.vnet.ibm.com>
 <20180327173857.0d195b66@roar.ozlabs.ibm.com>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 22:47:15 +0530
MIME-Version: 1.0
In-Reply-To: <20180327173857.0d195b66@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <aacd893e-d6be-a92d-bd15-04ecf026d2e8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2018 01:08 PM, Nicholas Piggin wrote:
> On Tue, 27 Mar 2018 12:47:31 +0530
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> 
>> On 03/26/2018 08:32 PM, Nicholas Piggin wrote:
>>> opal_nvram_write currently just assumes success if it encounters an
>>> error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
>>> on other errors instead.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    arch/powerpc/platforms/powernv/opal-nvram.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
>>> index 9db4398ded5d..13bf625dc3e8 100644
>>> --- a/arch/powerpc/platforms/powernv/opal-nvram.c
>>> +++ b/arch/powerpc/platforms/powernv/opal-nvram.c
>>> @@ -59,6 +59,8 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
>>>    		if (rc == OPAL_BUSY_EVENT)
>>>    			opal_poll_events(NULL);
>>
>> Current code does continuous poller here. May be we have small breathing time
>> here. What you say?
> 
> Yeah that's probably not a bad idea. I cc'ed skiboot list -- what's a
> reasonable delay between retries?

I think it depends on individual API. Like in case of dump retrival I've 20ms 
delay... as FSP takes time to copy data to host memory. But may be here we can 
have smaller delay.

> Linux has a bunch of similar kind of
> loops if you grep for opal_poll_events and OPAL_BUSY. It would be good
> to convert them all to a standard form with a standard delay as
> recommended by OPAL, and where specific calls have different delay
> for a good reason, that would be documented in the OPAL API docs.

Yes. We should update API documentation.

-Vasant

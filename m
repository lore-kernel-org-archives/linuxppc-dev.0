Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spC0y36pKzDrPW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 19:35:46 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u948WYK7072719
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 04:35:43 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25v8pt0vtf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 04:35:43 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 4 Oct 2016 09:35:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE91C1B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 09:37:34 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u948ZbLf6095168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 08:35:37 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u948Zbpi030412
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 02:35:37 -0600
Subject: Re: [PATCH] cxl: Flush PSL cache before resetting the adapter
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <87wphowtnu.fsf@vajain21.in.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 4 Oct 2016 10:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <87wphowtnu.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b743c589-85a9-621b-eb6a-9acb4495514b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,


Le 04/10/2016 à 07:49, Vaibhav Jain a écrit :
> Hi Fred,
>
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>>
>> +	/* the adapter is about to be reset, so ignore errors */
>> +	cxl_data_cache_flush(adapter);
>> +
> Will be a good idea if we return error and not let the reset to proceed,
> if cxl_data_cache_flush returns EBUSY as continuing again may cause the
> UE error.

I'm going to change cxl_data_cache_flush() to return ETIMEOUT instead of 
EBUSY, as it is misleading. With the current patch, EBUSY is not 
returned because there are active contexts running on the card. It is 
returned when the hardware/psl doesn't reply within 5 seconds to the 
flush request. It's not supposed to happen and would show an issue with 
the hardware/psl. In which case the adapter is close to useless, so we 
might as well try resetting it.

On a related note, we've talked with the folks from cxlflash, and we'll 
test a separate (complementary) patch to deny resetting the adapter if 
there are any active contexts, since, as you say, the likelihood of 
hitting a UE would be pretty high.

   Fred

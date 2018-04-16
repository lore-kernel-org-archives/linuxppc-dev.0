Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PVfD0fhnzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 11:09:39 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3G19BDc051668
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:09:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcg71b41e-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:09:36 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Sun, 15 Apr 2018 21:09:35 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w3G19Yqp50659436
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 01:09:34 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A15AAE04E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:11:20 -0400 (EDT)
Received: from [9.80.233.220] (unknown [9.80.233.220])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 44CB4AE03B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:11:20 -0400 (EDT)
Subject: Re: [PATCH] ibmvnic: Clear pending interrupt after device reset
To: linuxppc-dev@lists.ozlabs.org
References: <1523836416-16531-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20180415.205512.1546339550911332998.davem@davemloft.net>
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Sun, 15 Apr 2018 20:09:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180415.205512.1546339550911332998.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <6fc54993-ab6b-8b48-9854-379c549d3f2f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2018 07:55 PM, David Miller wrote:
> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Date: Sun, 15 Apr 2018 18:53:36 -0500
>
>> Due to a firmware bug, the hypervisor can send an interrupt to a
>> transmit or receive queue just prior to a partition migration, not
>> allowing the device enough time to handle it and send an EOI. When
>> the partition migrates, the interrupt is lost but an "EOI-pending"
>> flag for the interrupt line is still set in firmware. No further
>> interrupts will be sent until that flag is cleared, effectively
>> freezing that queue. To workaround this, the driver will disable the
>> hardware interrupt and send an H_EOI signal prior to re-enabling it.
>> This will flush the pending EOI and allow the driver to continue
>> operation.
>>
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Hey Thomas, I see two copies of this patch posted.  Any special
> reason for that?
>
> Thanks.
>
Sorry, I misspelled one of the email addresses and mistakenly resent it.  Please ignore this one.

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2wPs6nBKzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:22:41 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71AK0Ur071570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 06:22:38 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gpje8k50-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 06:22:38 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:22:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 371A12BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:22:33 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71AMXxO26869840
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:22:33 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71AMW1l020316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:22:32 +1000
Subject: Re: [RFC PATCH v2 10/11] powerpc: Support to replay PMIs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-11-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801180716.5d0a47de@roar.ozlabs.ibm.com>
 <1470041496.5978.364.camel@kernel.crashing.org>
Cc: mpe@ellerman.id.au, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 1 Aug 2016 15:52:28 +0530
MIME-Version: 1.0
In-Reply-To: <1470041496.5978.364.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1768c5de-fe51-8b59-ca4e-9c34b1251a49@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 01 August 2016 02:21 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2016-08-01 at 18:07 +1000, Nicholas Piggin wrote:
>> This will replay hardware_interrupt_common in the case we got a PMI
>> interrupt but no EE.
>>
>> Should we just follow the normal pattern here, return 0xf00 for PMI,
>> and replay the same as the other cases?
> Agreed.

OK. But can we handle that in the C itself.
With an additional check to see whether EE happended or not?
Because if PMI landed first, there will be no EE anyway?

Maddy
> Cheers,
> Ben.
>

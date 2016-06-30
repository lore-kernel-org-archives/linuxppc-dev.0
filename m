Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg75r4rLszDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:15:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U5EJHK145485
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:15:09 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhujqqx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:15:09 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 30 Jun 2016 15:15:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 209862CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:15:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5U5F31S11993494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:15:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5U5F3GM001405
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:15:03 +1000
Subject: Re: [PATCH] cxl: Fix NULL pointer dereference on kernel contexts with
 no AFU interrupts
To: Michael Ellerman <mpe@ellerman.id.au>, Ian Munsie <imunsie@au1.ibm.com>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
 <ac33c4a3-544f-2917-1cd7-14c62f176522@au1.ibm.com>
 <1467262824.7296.3.camel@ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 30 Jun 2016 15:15:02 +1000
MIME-Version: 1.0
In-Reply-To: <1467262824.7296.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e17203b8-0662-e110-f6f6-ab41617db45a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/06/16 15:00, Michael Ellerman wrote:
> On Thu, 2016-06-30 at 08:28 +1000, Andrew Donnellan wrote:
>> On 30/06/16 04:55, Ian Munsie wrote:
>>>
>>> From: Ian Munsie <imunsie@au1.ibm.com>
>>>
>>> If a kernel context is initialised and does not have any AFU interrupts
>>> allocated it will cause a NULL pointer dereference when the context is
>>> detached since the irq_names list will not have been initialised.
>>>
>>> Move the initialisation of the irq_names list into the cxl_context_init
>>> routine so that it will be valid for the entire lifetime of the context
>>> and will not cause a NULL pointer dereference.
>>>
>>> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
>
>> As it's nice having your machine not crash on every shutdown...
>
> Fixes: ????

Ian can correct me if I'm wrong, but I suspect this doesn't affect 
cxlflash (the only current user of the cxl kernel API) - this issue was 
hit while working on CAPI support for mlx5.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

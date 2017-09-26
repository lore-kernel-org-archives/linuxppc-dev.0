Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1YgW2GppzDsQN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 18:16:07 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q8DdL9034340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:16:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7jwh1e9c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:16:04 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 26 Sep 2017 09:16:02 +0100
Subject: Re: [PATCH V2] cxl: Fix memory page not handled
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
 <87mv5imdwr.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 10:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <87mv5imdwr.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8d0099bd-a470-7f8c-a665-9540e012361e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 26/09/2017 à 03:44, Vaibhav Jain a écrit :
> Hi Christophe,
>
> A minor nitpick
>
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>
>> +	for (dar = (addr & ~(page_size - 1)); dar < (addr + size); dar += page_size) {
>> +		if (dar < vma->vm_start || dar > vma->vm_end) {
> Code comment in mm_types.h for vm_end says it "The first byte after our
> end address within vm_mm". So this condition should be
> (dar < vma->vm_start || dar >= vma->vm_end)
>
> ~ Vaibhav


You are right. Thanks for the review

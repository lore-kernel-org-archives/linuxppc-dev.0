Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfJcZ2l0NzDsjJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 22:20:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sfJcY5X7vz9sQw
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:20:45 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LCJ1wE048231
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:20:44 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khtdd3qg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:20:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 22:20:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D82312BB0045
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:20:35 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LCKZBA54394970
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:20:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LCKZbD018041
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:20:35 +1000
Date: Wed, 21 Sep 2016 22:20:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] drivers/pci/hotplug: Support surprise hotplug
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1473905242-898-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <8737ktao99.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737ktao99.fsf@concordia.ellerman.id.au>
Message-Id: <20160921122047.GA9104@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2016 at 02:08:18PM +1000, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> This supports PCI surprise hotplug. The design is highlighted as
>> below:
>>
>>    * The PCI slot's surprise hotplug capability is exposed through
>>      device node property "ibm,slot-surprise-pluggable", meaning
>>      PCI surprise hotplug will be disabled if skiboot doesn't support
>>      it yet.
>>    * The interrupt because of presence or link state change is raised
>>      on surprise hotplug event. One event is allocated and queued to
>>      the PCI slot for workqueue to pick it up and process in serialized
>>      fashion. The code flow for surprise hotplug is same to that for
>>      managed hotplug except: the affected PEs are put into frozen state
>>      to avoid unexpected EEH error reporting in surprise hot remove path.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pnv-pci.h |   9 ++
>>  drivers/pci/hotplug/pnv_php.c      | 219 +++++++++++++++++++++++++++++++++++++
>
>Can you please resend this and Cc linux-pci and Bjorn, thanks.
>

Thanks for the tips that I should have followed last time when posting the patches.
This series was resent and Bjorn/linux-pci are copied. Please ignore this copy.

Thanks,
Gavin

>cheers
>

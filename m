Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZ0X81M00zDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 07:01:44 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rZ0X74v9lz9t0J
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2016 07:01:43 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LKxLR0120427
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 17:01:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qcxdgbk8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 17:01:41 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 15:01:39 -0600
Date: Wed, 22 Jun 2016 02:31:27 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@ozlabs.org>
CC: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI capability
 is enabled
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160113070809.20248.80811.stgit@aravindap>
 <20160620051853.GA29366@fergus.ozlabs.ibm.com>
In-Reply-To: <20160620051853.GA29366@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <5769AB27.7040604@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 20 June 2016 10:48 AM, Paul Mackerras wrote:
> Hi Aravinda,
> 
> On Wed, Jan 13, 2016 at 12:38:09PM +0530, Aravinda Prasad wrote:
>> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
>> exit reasons upon a machine check exception (MCE) in
>> the guest address space if the KVM_CAP_PPC_FWNMI
>> capability is enabled (instead of delivering 0x200
>> interrupt to guest). This enables QEMU to build error
>> log and deliver machine check exception to guest via
>> guest registered machine check handler.
>>
>> This approach simplifies the delivering of machine
>> check exception to guest OS compared to the earlier
>> approach of KVM directly invoking 0x200 guest interrupt
>> vector. In the earlier approach QEMU was enhanced to
>> patch the 0x200 interrupt vector during boot. The
>> patched code at 0x200 issued a private hcall to pass
>> the control to QEMU to build the error log.
>>
>> This design/approach is based on the feedback for the
>> QEMU patches to handle machine check exception. Details
>> of earlier approach of handling machine check exception
>> in QEMU and related discussions can be found at:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> 
> Are you in the process of doing a new version of this patch with the
> requested changes?

Yes, I am working (intermittently) on the new version. But, not able to
finish off and post it. Will complete it and post the new version.

Regards,
Aravinda

> 
> Paul.
> 

-- 
Regards,
Aravinda

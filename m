Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0Dc75vx3zDqWL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 18:22:47 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v0Dc71cWFz9t1P
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 18:22:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0D7KrGn006457
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 02:22:44 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27xnar1vf4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 02:22:43 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 00:22:43 -0700
Subject: Re: [PATCH v4 1/2] KVM: PPC: Add new capability to control MCE
 behaviour
To: Paul Mackerras <paulus@ozlabs.org>
References: <148396203530.1471.16105350692124392705.stgit@aravinda>
 <20170112095628.GA29786@fergus.ozlabs.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 13 Jan 2017 12:52:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170112095628.GA29786@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <a862df9e-b08c-ebbc-a231-092575de1524@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 January 2017 03:26 PM, Paul Mackerras wrote:
> On Mon, Jan 09, 2017 at 05:10:35PM +0530, Aravinda Prasad wrote:
>> This patch introduces a new KVM capability to control
>> how KVM behaves on machine check exception (MCE).
>> Without this capability, KVM redirects machine check
>> exceptions to guest's 0x200 vector, if the address in
>> error belongs to the guest. With this capability KVM
>> causes a guest exit with NMI exit reason.
>>
>> The new capability is required to avoid problems if
>> a new kernel/KVM is used with an old QEMU for guests
>> that don't issue "ibm,nmi-register". As old QEMU does
>> not understand the NMI exit type, it treats it as a
>> fatal error. However, the guest could have handled
>> the machine check error if the exception was delivered
>> to guest's 0x200 interrupt vector instead of NMI exit
>> in case of old QEMU.
> 
> You need to add a description of the new capability to
> Documentation/virtual/kvm/api.txt.

sure.

> 
> Paul.
> 

-- 
Regards,
Aravinda

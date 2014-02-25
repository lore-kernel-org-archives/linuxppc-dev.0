Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A0A42C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 03:01:01 +1100 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 16:00:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2C4F11B08061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 16:00:34 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PG0faj66256974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 16:00:41 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1PG0qA0026286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 09:00:52 -0700
Message-ID: <530CBE34.4000004@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 17:00:52 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: KVM: Introduce hypervisor call H_GET_TCE
References: <20140221153110.8190.6271.stgit@nimbus>
 <75FB1EEB-910A-49A9-A4CC-0A2E5403C54C@suse.de>
In-Reply-To: <75FB1EEB-910A-49A9-A4CC-0A2E5403C54C@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/02/2014 16:57, Alexander Graf wrote:
> 
> On 21.02.2014, at 16:31, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> This fix introduces the H_GET_TCE hypervisor call which is basically the
>> reverse of H_PUT_TCE, as defined in the Power Architecture Platform
>> Requirements (PAPR).
>>
>> The hcall H_GET_TCE is required by the kdump kernel which is calling it to
>> retrieve the TCE set up by the panicing kernel.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Thanks, applied to kvm-ppc-queue. Btw, why exactly are we using struct page pointers and alloc_page rather than __get_free_page() and simple page start pointers?

FWIW, I'm not so familiar with that part of code, it seems that this is
due to the page fault handler (kvm_spapr_tce_fault) which is part of the
mmap file operation handlers associated to the fd returned by
kvm_vm_ioctl_create_spapr_tce. Underlying vma's operation requires the
page fault handler to return a struct page value in the vm_fault structure.

Cheers,
Laurent.

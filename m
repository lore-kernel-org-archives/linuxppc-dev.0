Return-Path: <clg@kaod.org>
Received: from 17.mo3.mail-out.ovh.net (17.mo3.mail-out.ovh.net [87.98.178.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqyp432SPzDwNN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 19:33:47 +1100 (AEDT)
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id B5173177D67
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 08:58:36 +0100 (CET)
Subject: Re: [PATCH] KVM: PPC: Book3S HV: check for XIVE device before
 executing the XICS hcalls
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20171127073017.25463-1-clg@kaod.org>
 <20171204010409.rasszyk4rsc3bbhm@oak.ozlabs.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a3627aed-9796-e77d-96fd-86cb4ed62d8d@kaod.org>
Date: Mon, 4 Dec 2017 08:58:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171204010409.rasszyk4rsc3bbhm@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2017 02:04 AM, Paul Mackerras wrote:
> On Mon, Nov 27, 2017 at 08:30:17AM +0100, Cédric Le Goater wrote:
>> When QEMU is started with the option kernel_irqchip=òff, the kvm XICS
>> hcalls are being used even though a kvm XICS device has not been
>> created on the host, resulting quickly in a failure and a broken
>> guest.
>>
>> The test checking if there is a XIVE device in the VM before executing
>> the XICS hcalls is missing from the recent XICS-over-XIVE glue.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> I think this is fixing the same bug that commit 00bb6ae50062 ("KVM:
> PPC: Book3S HV: Don't call real-mode XICS hypercall handlers if not
> enabled", 2017-10-26) addresses.
> 
> Do you think this patch is needed in addition to 00bb6ae50062?

No. I think 00bb6ae50062 is fine. 

It is a bit redundant for P8 systems because the XICS device 
availability in the VM is already tested in the xics_rm_h_* hcalls 
with : 
 
	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;

	if (!xics || !xics->real_mode)
		return H_TOO_HARD;

But, as the XICS-over-XIVE glue also assigns the VCPU 'arch.irq_type' 
field to KVMPPC_IRQ_XICS, we can use the macro kvmppc_xics_enabled()
for both backend in the top level hcalls.

Letting each backend decide whether H_TOO_HARD should be returned 
might be more precise. I think we will clarify that when XIVE 
exploitation mode support is added to KVM.

Thanks,

C.

Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyG7V5XYSzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 13:24:38 +1100 (AEDT)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 10 Jan 2017 07:54:28 +0530
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 paulus@ozlabs.org, linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] KVM: PPC: Add new capability to control MCE
 behaviour
Message-ID: <20170110022428.GA7781@localhost.localdomain>
References: <148396203530.1471.16105350692124392705.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <148396203530.1471.16105350692124392705.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 09, 2017 at 05:10:35PM +0530, Aravinda Prasad wrote:
> This patch introduces a new KVM capability to control
> how KVM behaves on machine check exception (MCE).
> Without this capability, KVM redirects machine check
> exceptions to guest's 0x200 vector, if the address in
> error belongs to the guest. With this capability KVM
> causes a guest exit with NMI exit reason.
>
> The new capability is required to avoid problems if
> a new kernel/KVM is used with an old QEMU for guests
> that don't issue "ibm,nmi-register". As old QEMU does
> not understand the NMI exit type, it treats it as a
> fatal error. However, the guest could have handled
> the machine check error if the exception was delivered
> to guest's 0x200 interrupt vector instead of NMI exit
> in case of old QEMU.
> 

Can you move these to a cover letter, the description
here does not match the changes
 
> QEMU part can be found at:
> http://lists.nongnu.org/archive/html/qemu-ppc/2015-12/msg00199.html
>

Balbir Singh. 

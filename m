Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzyf750dWzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 07:53:35 +1100 (AEDT)
Date: Thu, 12 Jan 2017 20:56:28 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH v4 1/2] KVM: PPC: Add new capability to control MCE
 behaviour
Message-ID: <20170112095628.GA29786@fergus.ozlabs.ibm.com>
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

You need to add a description of the new capability to
Documentation/virtual/kvm/api.txt.

Paul.

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35kD606VzDx69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:24:04 +1100 (AEDT)
In-Reply-To: <20171212172356.2397-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: KVM: PPC: Book3S HV: Fix pending_pri value in
 kvmppc_xive_get_icp()
Message-Id: <3z35kD3TMXz9sMN@ozlabs.org>
Date: Fri, 22 Dec 2017 22:24:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-12 at 17:23:56 UTC, Laurent Vivier wrote:
> When we migrate a VM from a POWER8 host (XICS) to a POWER9 host
> (XICS-on-XIVE), we have an error:
> 
> qemu-kvm: Unable to restore KVM interrupt controller state \
>           (0xff000000) for CPU 0: Invalid argument
> 
> This is because kvmppc_xics_set_icp() checks the new state
> is internaly consistent, and especially:
> 
> ...
>    1129         if (xisr == 0) {
>    1130                 if (pending_pri != 0xff)
>    1131                         return -EINVAL;
> ...
> 
> On the other side, kvmppc_xive_get_icp() doesn't set
> neither the pending_pri value, nor the xisr value (set to 0)
> (and kvmppc_xive_set_icp() ignores the pending_pri value)
> 
> As xisr is 0, pending_pri must be set to 0xff.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7333b5aca412d6ad02667b5a513485

cheers

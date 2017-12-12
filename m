Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxB3g0mxMzDrXZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 07:18:38 +1100 (AEDT)
Message-ID: <1513109890.2303.42.camel@kernel.crashing.org>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix pending_pri value in
 kvmppc_xive_get_icp()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Paul
 Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Wed, 13 Dec 2017 07:18:10 +1100
In-Reply-To: <20171212172356.2397-1-lvivier@redhat.com>
References: <20171212172356.2397-1-lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-12 at 18:23 +0100, Laurent Vivier wrote:
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

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

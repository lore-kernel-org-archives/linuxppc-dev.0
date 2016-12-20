Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjr5c46x2zDwH1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 08:09:56 +1100 (AEDT)
Date: Wed, 21 Dec 2016 08:09:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Don't try to use radix MMU under a hypervisor
Message-ID: <20161220210953.GB19107@fergus.ozlabs.ibm.com>
References: <20161220114002.GA19107@fergus.ozlabs.ibm.com>
 <87lgvau04h.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgvau04h.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 08:19:02PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > Currently, if the kernel is running on a POWER9 processor under a
> > hypervisor, it will try to use the radix MMU even though it doesn't
> > have the necessary code to use radix under a hypervisor (it doesn't
> > negotiate use of radix, and it doesn't do the H_REGISTER_PROC_TBL
> > hcall).  The result is that the guest kernel will crash when it tries
> > to turn on the MMU, because it will still actually be using the HPT
> > MMU, but it won't have set up any SLB or HPT entries.  It does this
> > because the only thing that the kernel looks at in deciding to use
> > radix, on any platform, is the ibm,pa-features property on the cpu
> > device nodes.
> >
> > This fixes it by looking for the /chosen/ibm,architecture-vec-5
> > property, and if it exists, clearing the radix MMU feature bit.
> > We do this before we decide whether to initialize for radix or HPT.
> > This property is created by the hypervisor as a result of the guest
> > calling the ibm,client-architecture-support method to indicate
> > its capabilities, so it only exists on systems with a hypervisor.
> > The reason for using this property is that in future, when we
> > have support for using radix under a hypervisor, we will need
> > to check this property to see whether the hypervisor agreed to
> > us using radix.
> 
> Hypervisor that doesn't support radix should clear the ibm,pa-features
> radix feature bit right ? We look at that before setting
> MMU_FTR_TYPE_RADIX. So how did we end up enabling radix in the above
> case ?

Two points in response:

1. The ibm,pa-features property specifies the capabilities of the
processor, not the platform.  The radix bit would be set on POWER9
even if the hypervisor doesn't support radix.

2. The hypervisor might well support radix, but the kernel definitely
cannot operate with radix under a hypervisor, because it doesn't put
the necessary things in the ibm,client-architecture support call, and
it doesn't call the H_REGISTER_PROC_TBL hcall.  That means that the
CPU has no way to find our 1st level (process scoped) radix trees even
if the partition was in radix mode.  Most likely the hypervisor will
put the partition into HPT mode because the kernel didn't ask for
radix in the CAS call, but even if the hypervisor put the partition
into radix mode, it still wouldn't work.

Paul.

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPmCk31fkzDqPv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:18:58 +1000 (AEST)
Message-ID: <1465384736.13854.5.camel@ellerman.id.au>
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Cyril Bur
 <cyrilbur@gmail.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, Ulrich.Weigand@de.ibm.com, peterz@infradead.org,
 palves@redhat.com, emachado@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>,
 shuahkh@osg.samsung.com, dhowells@redhat.com,  linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, oleg@redhat.com, davej@redhat.com,  tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, davem@davemloft.net,  sam.bobroff@au1.ibm.com
Date: Wed, 08 Jun 2016 21:18:56 +1000
In-Reply-To: <57553AE7.3060704@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com>
 <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com> <5748004F.7040408@linux.vnet.ibm.com>
 <1464649951.16938.5.camel@ellerman.id.au>
 <201606010827.u518O0bl023243@mx0a-001b2d01.pphosted.com>
 <CAN-ccASsMPA2=rXnCQaDnnzYAFqkMACVyrM-Oz=OH76-SbogCw@mail.gmail.com>
 <57553AE7.3060704@linux.vnet.ibm.com>
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

On Mon, 2016-06-06 at 14:27 +0530, Anshuman Khandual wrote:
> On 06/03/2016 03:56 AM, Cyril Bur wrote:
> > 
> > At the moment is is rather confusing since pt_regs is the always the 'live'
> > state and theres a ckpt_regs that is the pt_regs for the checkpointed state.
> > FPU/VMX/VSX is done differently which is really only creating confusion so I'm changing
> > it to do the same at for pt_regs/ckpt_regs. Ultimately this is part of more work from me
> 
> But that changes the basic semantics on which this ptrace series is written.
> With this change, a significant part of the ptrace series has to be changed.

Yes, that's the whole point.

In fact half of the code should vanish, because the only difference between
copying the live or checkpointed state out to userspace should be which regs
struct you pass to the function.

> Its just an improvement on how we store running and check pointed values for
> FP/VSX/VMX registers inside the kernel. How does it improve ptrace interface
> from the user point of view ? If not, then why this change is necessary for
> the acceptance of this patch series ?

Because the clean-ups never happen once a series is merged, and I'm left to deal
with it.

cheers

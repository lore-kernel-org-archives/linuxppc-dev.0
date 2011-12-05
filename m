Return-Path: <B29237@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9DD8BB6F99
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 17:11:45 +1100 (EST)
From: Shi Xuelin-B29237 <B29237@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: RE: [PATCH][RFC] fsldma: fix performance degradation by optimizing
 spinlock use.
Date: Mon, 5 Dec 2011 06:11:31 +0000
Message-ID: <DBB740589CE8814680DECFE34BE197AB14BED0@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1321937705-19587-1-git-send-email-b29237@freescale.com>
 <20111122185924.GA23323@ovro.caltech.edu>
 <DBB740589CE8814680DECFE34BE197AB148CDD@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111128163814.GA10919@ovro.caltech.edu>
 <3F607A5180246847A760FD34122A1E052E07B7@039-SN1MPN1-003.039d.mgd.msft.net>
 <20111129172539.GB15331@ovro.caltech.edu>
 <DBB740589CE8814680DECFE34BE197AB14A1E0@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111130170737.GA25892@ovro.caltech.edu>
 <DBB740589CE8814680DECFE34BE197AB14BCBC@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111202171334.GA19677@ovro.caltech.edu>
In-Reply-To: <20111202171334.GA19677@ovro.caltech.edu>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Iris,

>Remember, without barriers, CPU-B can observe CPU-A's memory accesses in *=
any possible order*. Memory accesses are not guaranteed to be *complete* by=
=20
>the time fsl_dma_tx_submit() returns!

fsl_dma_tx_submit is enclosed by spin_lock_irqsave/spin_unlock_irqrestore, =
when this function returns, I believe the memory access are completed. spin=
_unlock_irqsave is an implicit memory barrier and guaranteed this.

Thanks,
Forrest


-----Original Message-----
From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]=20
Sent: 2011=1B$BG/=1B(B12=1B$B7n=1B(B3=1B$BF|=1B(B 1:14
To: Shi Xuelin-B29237
Cc: vinod.koul@intel.com; dan.j.williams@intel.com; linuxppc-dev@lists.ozla=
bs.org; linux-kernel@vger.kernel.org; Li Yang-R58472
Subject: Re: [PATCH][RFC] fsldma: fix performance degradation by optimizing=
 spinlock use.

On Fri, Dec 02, 2011 at 03:47:27AM +0000, Shi Xuelin-B29237 wrote:
> Hi Iris,
>=20
> >I'm convinced that "smp_rmb()" is needed when removing the spinlock.=20
> >As noted, Documentation/memory-barriers.txt says that stores on one CPU =
can be observed by another CPU in a different order.
> >Previously, there was an UNLOCK (in fsl_dma_tx_submit) followed by a=20
> >LOCK (in fsl_tx_status). This provided a "full barrier", forcing the ope=
rations to complete correctly when viewed by the second CPU.
>=20
> I do not agree this smp_rmb() works here. Because when this smp_rmb() exe=
cuted and begin to read chan->common.cookie, you still cannot avoid the ord=
er issue. Something like one is reading old value, but another CPU is updat=
ing the new value.=20
>=20
> My point is here the order is not important for the DMA decision.
> Completed DMA tx is decided as not complete is not a big deal, because ne=
xt time it will be OK.
>=20
> I believe there is no case that could cause uncompleted DMA tx is decided=
 as completed, because the fsl_tx_status is called after fsl_dma_tx_submit =
for a specific cookie. If you can give me an example here, I will agree wit=
h you.
>=20

According to memory-barriers.txt, writes to main memory may be observed in =
any order if memory barriers are not used. This means that writes can appea=
r to happen in a different order than they were issued by the CPU.

Citing from the text:

> There are certain things that the Linux kernel memory barriers do not gua=
rantee:
>
>  (*) There is no guarantee that any of the memory accesses specified befo=
re a
>      memory barrier will be _complete_ by the completion of a memory barr=
ier
>      instruction; the barrier can be considered to draw a line in that CP=
U's
>      access queue that accesses of the appropriate type may not cross.

Also:

> Without intervention, CPU 2 may perceive the events on CPU 1 in some=20
> effectively random order, despite the write barrier issued by CPU 1:

Also:

> When dealing with CPU-CPU interactions, certain types of memory=20
> barrier should always be paired.  A lack of appropriate pairing is almost=
 certainly an error.
>
> A write barrier should always be paired with a data dependency barrier=20
> or read barrier, though a general barrier would also be viable.

Therefore, in an SMP system, the following situation can happen.

descriptor->cookie =3D 2
chan->common.cookie =3D 1
chan->completed_cookie =3D 1

This occurs when CPU-A calls fsl_dma_tx_submit() and then CPU-B calls
dma_async_is_complete() ***after*** CPU-B has observed the write to
descriptor->cookie, and ***before*** before CPU-B has observed the write=20
descriptor->to
chan->common.cookie.

Remember, without barriers, CPU-B can observe CPU-A's memory accesses in *a=
ny possible order*. Memory accesses are not guaranteed to be *complete* by =
the time fsl_dma_tx_submit() returns!

With the above values, dma_async_is_complete() returns DMA_COMPLETE. This i=
s incorrect: the DMA is still in progress. The required invariant
chan->common.cookie >=3D descriptor->cookie has not been met.

By adding an smp_rmb(), I force CPU-B to stall until *both* stores in
fsl_dma_tx_submit() (descriptor->cookie and chan->common.cookie) actually h=
it main memory. This avoids the above situation: all CPU's observe
descriptor->cookie and chan->common.cookie to update in sync with each
other.

Is this unclear in any way?

Please run your test with the smp_rmb() and measure the performance impact.

Ira

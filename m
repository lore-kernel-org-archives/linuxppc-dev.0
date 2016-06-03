Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLWTX31sSzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 14:34:40 +1000 (AEST)
Message-ID: <1464928427.26773.26.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
Cc: paulus@samba.org, mpe@ellerman.id.au, peterz@infradead.org,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com
Date: Fri, 03 Jun 2016 14:33:47 +1000
In-Reply-To: <57510353.1020209@linux.vnet.ibm.com>
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464917520.26773.11.camel@kernel.crashing.org>
 <1464917548.26773.12.camel@au1.ibm.com>
 <57510353.1020209@linux.vnet.ibm.com>
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

On Fri, 2016-06-03 at 12:10 +0800, xinhui wrote:
> On 2016年06月03日 09:32, Benjamin Herrenschmidt wrote:
> > On Fri, 2016-06-03 at 11:32 +1000, Benjamin Herrenschmidt wrote:
> >> On Thu, 2016-06-02 at 17:22 +0800, Pan Xinhui wrote:
> >>>
> >>> Base code to enable qspinlock on powerpc. this patch add some
> >>> #ifdef
> >>> here and there. Although there is no paravirt related code, we
> can
> >>> successfully build a qspinlock kernel after apply this patch.
> >> This is missing the IO_SYNC stuff ... It means we'll fail to do a
> >> full
> >> sync to order vs MMIOs.
> >>
> >> You need to add that back in the unlock path.
> >
> > Well, and in the lock path as well...
> >
> Oh, yes. I missed IO_SYNC stuff.
> 
> thank you, Ben :)

Ok couple of other things that would be nice from my perspective (and
Michael's) if you can produce them:

 - Some benchmarks of the qspinlock alone, without the PV stuff,
   so we understand how much of the overhead is inherent to the
   qspinlock and how much is introduced by the PV bits.

 - For the above, can you show (or describe) where the qspinlock
   improves things compared to our current locks. While there's
   theory and to some extent practice on x86, it would be nice to
   validate the effects on POWER.

 - Comparative benchmark with the PV stuff in on a bare metal system
   to understand the overhead there.

 - Comparative benchmark with the PV stuff under pHyp and KVM

Spinlocks are fiddly and a critical piece of infrastructure, it's
important we fully understand the performance implications before we
decide to switch to a new model.

Cheers,
Ben.

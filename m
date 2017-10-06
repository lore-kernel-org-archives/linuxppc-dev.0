Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7bxJ71XgzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 15:19:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 cyrilbur@gmail.com
Subject: Re: [PATCH] powerpc/tm: P9 disabled suspend mode workaround
In-Reply-To: <20171005045516.26145-1-mikey@neuling.org>
References: <20171005045516.26145-1-mikey@neuling.org>
Date: Fri, 06 Oct 2017 15:19:00 +1100
Message-ID: <878tgozz63.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Each POWER9 core is made of two super slices. Each super slice can
> only have one thread at a time in TM suspend mode. The super slice
> restricts ever entering a state where both threads are in suspend by
> aborting transactions on tsuspend or exceptions into the kernel.
>
> Unfortunately for context switch we need trechkpt which forces suspend
> mode. If a thread is already in suspend and a second thread needs to
> be restored that was suspended, the trechkpt must be executed.
> Currently the trechkpt will hang in this case until the other thread
> exits suspend. This causes problems for Linux resulting in hang and
> RCU stall detectors going off.
>
> To workaround this, we disable suspend in the core. This is done via a
> firmware change which stops the hardware ever getting into suspend.
> The hardware will always rollback a transaction on any tsuspend or
> entry into the kernel.
...
> A future firmware change will allow suspend mode on POWER9 but that is
> going to require additional Linux changes to support. In the interim,
> this allows TM to continue to (partially) work while stopping
> userspace from crashing Linux.

But in the absence of the firmware change it doesn't achieve that,
userspace can still hang the machine.

I don't want to knowingly leave the machine in a state where users can
kill their box just by running TM enabled software.

I also don't want the machine to boot into some completely novel and
untested mode where suspend doesn't work, without the user opting into
that.

So as discussed offline, until we have the additional changes to enable
suspend mode, we should default to TM off on P9, unless the user
explicitly requests no-suspend mode.

cheers

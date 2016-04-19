Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq0Yn2MkWzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:47:57 +1000 (AEST)
Message-ID: <1461059270.17661.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Add a kernel thread to check the coherent platform
 function's state
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 19 Apr 2016 19:47:50 +1000
In-Reply-To: <1460984701-21490-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1460984701-21490-1-git-send-email-clombard@linux.vnet.ibm.com>
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

On Mon, 2016-04-18 at 15:05 +0200, Christophe Lombard wrote:

> In the POWERVM environement, the PHYP CoherentAccel component manages

PowerVM is correct I think.

> the state of the Coherant Accelerator Processor Interface adapter and
							   ^
							   (CAPI)
> virtualizes CAPI resources, handles CAPP, PSL, PSL Slice errors - and
> interrupts - and provides a new set of HCALLs for the OS APIs to utilize
					 ^
					 hcall (as below?)
> AFUs.

AFUs ? (you define it below)

> During the course of operation, a coherent platform function can
> encounter errors. Some possible reason for errors are:
> • Hardware recoverable and unrecoverable errors
> • Transient and over-threshold correctable errors
> 
> PHYP implements its own state model for the coherent platform function.
> The current state of this Acclerator Fonction Unit (AFU) is available
> through a hcall.
> 
> In case of low-level troubles (or error injection), The PHYP component
> may reset the card and change the AFU state. The PHYP interface doesn't
> provide any way to be notified when that happens.

Ugh.

> The current implementation of the cxl driver, for the POWERVM
> environment, follows the general error recovery procedures required to

What are "the general error recovery procedures" ?

> reset operation of the coherent platform function. The platform firmware
> resets and reconfigures hardware when an external action is required -
> attach/detach a process, link ok, ....

Platform firmware does that at our request or by itself?

> The purpose of this patch is to interact with the external driver

What's an external driver?

> (where the AFU is shown) even if no action is required. A kernel thread

But no action is required, so why do we need to do anything?

> is needed to check every x seconds the current state of the AFU to see
> if we need to enter an error recovery path.


I don't really understand what this is doing and why we want it. It sounds like
we're waking the cpu up every 3 seconds and having it poll the hypervisor, for
each AFU?

As far as the implementation, I can't see any reason why you need your own
kthreads, can't you just use queue_work() ?

cheers

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYj48h1zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:41 +1000 (AEST)
In-Reply-To: <1461332362-5309-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2] cxl: Check periodically the coherent platform function's
 state
Message-Id: <3r4CYj1N4Rz9t5R@ozlabs.org>
Date: Wed, 11 May 2016 07:48:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-04 at 13:39:22 UTC, Christophe Lombard wrote:
> In the PowerVM environment, the PHYP CoherentAccel component manages
> the state of the Coherent Accelerator Processor Interface adapter and
> virtualizes CAPI resources, handles CAPP, PSL, PSL Slice errors - and
> interrupts - and provides a new set of hcalls for the OS APIs to utilize
> Accelerator Function Unit (AFU).
> 
> During the course of operation, a coherent platform function can
> encounter errors. Some possible reason for errors are:
> • Hardware recoverable and unrecoverable errors
> • Transient and over-threshold correctable errors
> 
> PHYP implements its own state model for the coherent platform function.
> The state of the AFU is available through a hcall.
> 
> The current implementation of the cxl driver, for the PowerVM
> environment, checks this state of the AFU only when an action is
> requested - open a device, ioctl command, memory map, attach/detach a
> process - from an external driver - cxlflash, libcxl. If an error is
> detected the cxl driver handles the error according the content of the
> Power Architecture Platform Requirements document.
> 
> But in case of low-level troubles (or error injection), the PHYP
> component may reset the card and change the AFU state. The PHYP
> interface doesn't provide any way to be notified when that happens thus
> implies that the cxl driver:
> • cannot handle immediatly the state change of the AFU.
> • cannot notify other drivers (cxlflash, ...)
> 
> The purpose of this patch is to wake up the cpu periodically to check
> the current state of each AFU and to see if we need to enter an error
> recovery path.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6afa221da4fc9bdf6ba2cf7fa8

cheers

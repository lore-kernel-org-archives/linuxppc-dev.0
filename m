Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRV1JkBzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:54 +1000 (AEST)
In-Reply-To: <1464020045-1385-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Update process element after allocating interrupts
Message-Id: <3rYTRT2Cxyz9t18@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-23-05 at 16:14:05 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> In the kernel API, it is possible to attempt to allocate AFU interrupts
> after already starting a context. Since the process element structure
> used by the hardware is only filled out at the time the context is
> started, it will not be updated with the interrupt numbers that have
> just been allocated and therefore AFU interrupts will not work unless
> they were allocated prior to starting the context.
> 
> This can present some difficulties as each CAPI enabled PCI device in
> the kernel API has a default context, which may need to be started very
> early to enable translations, potentially before interrupts can easily
> be set up.
> 
> This patch makes the API more flexible to allow interrupts to be
> allocated after a context has already been started and takes care of
> updating the PE structure used by the hardware and notifying it to
> discard any cached copy it may have.
> 
> The update is currently performed via a terminate/remove/add sequence.
> This is necessary on some hardware such as the XSL that does not
> properly support the update LLCMD.
> 
> Note that this is only supported on powernv at present - attempting to
> perform this ordering on PowerVM will raise a warning.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/292841b09648ce7aee5df16ab7

cheers

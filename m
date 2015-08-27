Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53A4C1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:58:33 +1000 (AEST)
In-Reply-To: <1440141915-27716-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au.ibm.com,
 Ryan Grimm <grimm@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: cxl: Remove racy attempt to force EEH invocation in reset
Message-Id: <20150827215833.2F0331401AF@ozlabs.org>
Date: Fri, 28 Aug 2015 07:58:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-21-08 at 07:25:15 UTC, Daniel Axtens wrote:
> cxl_reset currently PERSTs the slot, and then repeatedly tries to
> read MMIO space in order to kick off EEH.
> 
> There are 2 problems with this: it's unnecessary, and it's racy.
> 
> It's unnecessary because the PERST will bring down the PHB link.
> That will be picked up by the CAPP, which will send out an HMI.
> Skiboot, noticing an HMI from the CAPP, will send an OPAL
> notification to the kernel, which will trigger EEH recovery.
> 
> It's also racy: the EEH recovery triggered by the CAPP will
> eventually cause the MMIO space to have its mapping invalidated
> and the pointer NULLed out. This races with our attempt to read
> the MMIO space. This is causing OOPSes in testing.
> 
> Simply drop all the attempts to force EEH detection, and trust
> that Skiboot will send the notification and that we'll act on it.
> The Skiboot code to send the EEH notification has been in Skiboot
> for as long as CAPP recovery has been supported, so we don't need
> to worry about breaking obscure setups with ancient firmware.
> 
> Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 62fa19d4b4fd ("cxl: Add ability to reset the card")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d8e27673c45927fee9e7d89

cheers

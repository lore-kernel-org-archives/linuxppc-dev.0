Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnBM2SwyzF0yB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:35:23 +1000 (AEST)
In-Reply-To: <3a742dd7a457874516daaf615ac0b883f87c2139.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: [v2] powerpc/powernv/pci: Work around races in PCI bridge enabling
Message-Id: <41vnBM15nLz9s8F@ozlabs.org>
Date: Tue, 21 Aug 2018 20:35:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-17 at 07:30:39 UTC, Benjamin Herrenschmidt wrote:
> The generic code is race when multiple children of a PCI bridge try to
> enable it simultaneously.
> 
> This leads to drivers trying to access a device through a not-yet-enabled
> bridge, and this EEH errors under various circumstances when using parallel
> driver probing.
> 
> There is work going on to fix that properly in the PCI core but it will
> take some time.
> 
> x86 gets away with it because (outside of hotplug), the BIOS enables all
> the bridges at boot time.
> 
> This patch does the same thing on powernv by enabling all bridges that
> have child devices at boot time, thus avoiding subsequent races. It's suitable
> for backporting to stable and distros, while the proper PCI fix will probably
> be significantly more invasive.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/db2173198b9513f7add8009f225afa

cheers

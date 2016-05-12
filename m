Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59p049vHzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:32:40 +1000 (AEST)
In-Reply-To: <1460402243-24346-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, gwshan@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [1/2,
 v3] Revert "powerpc/eeh: Fix crash in eeh_add_device_early() on Cell"
Message-Id: <3r59nz2L05z9s8d@ozlabs.org>
Date: Thu, 12 May 2016 21:32:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-04 at 19:17:22 UTC, "Guilherme G. Piccoli" wrote:
> This reverts commit 89a51df5ab1d38b257300b8ac940bbac3bb0eb9b.
> 
> The function eeh_add_device_early() is used to perform EEH initialization in
> devices added later on the system, like in hotplug/DLPAR scenarios. Since the
> commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
> a new check was introduced in this function - Cell has no EEH capabilities
> which led to kernel oops if hotplug was performed, so checking for
> eeh_enabled() was introduced to avoid the issue.
> 
> However, in architectures that EEH is present like pSeries or PowerNV, we might
> reach a case in which no PCI devices are present on boot time and so EEH is not
> initialized. Then, if a device is added via DLPAR for example,
> eeh_add_device_early() fails because eeh_enabled() is false, and EEH end up
> not being enabled at all.
> 
> This reverts the aforementioned patch since a new verification was introduced by
> the commit d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
> and so the original Cell issue does not happen anymore.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2078d9ef600bdbe568c89e5dd

cheers

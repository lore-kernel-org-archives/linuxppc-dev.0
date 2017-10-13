Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD1LK171GzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 19:37:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 maurosr@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Enable reset_devices parameter to issue
 a PHB reset
In-Reply-To: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
References: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 19:37:27 +1100
Message-ID: <87fuantpdk.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> During a kdump kernel boot in PowerPC, we request a reset of the
> PHBs to the FW. It makes sense, since if we are booting a kdump
> kernel it means we had some trouble before and we cannot rely in
> the adapters' health; they could be in a bad state, hence the
> reset is needed.
>
> But not only in a kdump kernel we could use this reset - there are
> situations, specially when debugging drivers, that we could break
> an adapter in a way it requires such reset. One can tell to just
> go ahead and reboot the machine, but happens that many times doing
> kexec is much faster, and so preferable than a full power cycle.
> Also, we could have situations in which adapters are in bad state
> due to adapter's FW issue, and only a PHB Fundamental Reset could
> revive them.
>
> This patch enables the reset_devices parameter to perform such reset.
> The parameter is barely used - only few drivers make use of it.
> This is a PowerPC-only change.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
> This patch was built/tested against powerpc/next branch.
>
> We recently had a situation in which i40e driver couldn't start,
> even after a full power cycle, due to a bug in its FW triggered
> by a DCB condition in switch (thanks Mauro for narrowing this).
> This patch enabled us to revive the adapter and use network
> while debugging.

I really dislike this.

You're basically saying the kernel can't work out how to get a device
working, so let's leave it up to the user.

The driver should be fixed to detect that the device is not responding
and request a reset.

cheers

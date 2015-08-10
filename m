Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC7C1A182D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:05 +1000 (AEST)
In-Reply-To: <20150731155312.30819.80637.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: powernv: Invoke opal_cec_reboot2() on unrecoverable machine check
 errors.
Message-Id: <20150810092705.227B3140321@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-31-07 at 15:54:38 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> On non-recoverable MCE errors in kernel space, Linux kernel panics
> and system reboots. On BMC based system opal-prd runs as a daemon
> in the host. Hence, kernel crash may prevent opal-prd to detect and
> analyze this MCE error. This may land us in a situation where the faulty
> memory never gets de-configured and Linux would keep hitting same MCE error
> again and again. If this happens in early stage of kernel initialization,
> then Linux will keep crashing and rebooting in a loop.
> 
> This patch fixes this issue by invoking new opal_cec_reboot2() call with
> reboot type OPAL_REBOOT_PLATFORM_ERROR to inform BMC/OCC about this
> error, so that BMC can collect relevant data for error analysis and
> decide what component to de-configure before rebooting.
> 
> This patch is dependent on OPAL patchset posted on skiboot mailing list
> at https://lists.ozlabs.org/pipermail/skiboot/2015-July/001771.html that
> introduces opal_cec_reboot2() opal call.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e784b6499d9cba83b7f3

cheers

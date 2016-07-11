Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kz38sCzDqyQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:35 +1000 (AEST)
In-Reply-To: <146602104462.23192.4267928292361711364.stgit@bahia.lan>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [v2] powerpc/pseries: start rtasd before PCI probing
Message-Id: <3rp1Ky5q41z9t10@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-15-06 at 20:26:41 UTC, Greg Kurz wrote:
> A strange behaviour is observed when comparing PCI hotplug in QEMU, between
> x86 and pseries. If you consider the following steps:
> - start a VM
> - add a PCI device via the QEMU monitor before the rtasd has started (for
>   example starting the VM in paused state, or hotplug during FW or boot
>   loader)
> - resume the VM execution
> 
> The x86 kernel detects the PCI device, but the pseries one does not.
> 
> This happens because the rtasd kernel worker is currently started under
> device_initcall, while PCI probing happens earlier under subsys_initcall.
> 
> As a consequence, if we have a pending RTAS event at boot time, a message
> is printed and the event is dropped.
> 
> This patch moves all the initialization of rtasd to arch_initcall, which is
> run before subsys_call: this way, logging_enabled is true when the RTAS
> event pops up and it is not lost anymore.
> 
> The proc fs bits stay at device_initcall because they cannot be run before
> fs_initcall.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c6a0a1f4041f19559538649e0

cheers

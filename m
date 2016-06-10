Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQr6w6XF5zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 15:18:32 +1000 (AEST)
In-Reply-To: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/pseries: start rtasd before PCI probing
Message-Id: <3rQr6w4ck4z9sBf@ozlabs.org>
Date: Fri, 10 Jun 2016 15:18:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-23-05 at 08:28:28 UTC, Greg Kurz wrote:
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
> Tested-by: Thomas Huth <thuth@redhat.com>

Has this been tested on PowerVM ?

cheers

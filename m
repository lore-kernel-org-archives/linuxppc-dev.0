Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD6Nt3J6JzDqMp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 04:23:26 +1000 (AEST)
Subject: Re: powerpc/pseries: start rtasd before PCI probing
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57434A97.90501@redhat.com>
Date: Mon, 23 May 2016 20:23:19 +0200
MIME-Version: 1.0
In-Reply-To: <146399210850.26372.5857516772891352049.stgit@bahia.huguette.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.05.2016 10:28, Greg Kurz wrote:
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
> ---
>  arch/powerpc/kernel/rtasd.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

By the way, same is true for device UNplugging: When unplugging devices
in QEMU while the firmware is still running, they are never properly
removed from the guest. I've checked it, and your patch fixes this
problem as well! Great :-)

Tested-by: Thomas Huth <thuth@redhat.com>

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyt4LCfzDr62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:14 +1100 (AEDT)
In-Reply-To: <1506644360-8688-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 stable@vger.kernel.org, nfont@linux.vnet.ibm.com
Subject: Re: powerpc/vio: dispose of virq mapping on vdevice unregister
Message-Id: <3yWlyt3Phkz9sMN@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 00:19:20 UTC, Tyrel Datwyler wrote:
> When a vdevice is DLPAR removed from the system the vio subsystem doesn't
> bother unmapping the virq from the irq_domain. As a result we have a virq
> mapped to a hardware irq that is no longer valid for the irq_domain. A side
> effect is that we are left with /proc/irq/<irq#> affinity entries, and
> attempts to modify the smp_affinity of the irq will fail.
> 
> In the following observed example the kernel log is spammed by
> ics_rtas_set_affinity errors after the removal of a VSCSI adapter. This is a
> result of irqbalance trying to adjust the affinity every 10 seconds.
> 
> rpadlpar_io: slot U8408.E8E.10A7ACV-V5-C25 removed
> ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3
> ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3
> 
> This patch fixes the issue by calling irq_dispose_mapping() on the virq of the
> viodev on unregister.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b8f89fea599d91e674497aad572613

cheers

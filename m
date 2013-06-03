Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFDC92C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 20:43:32 +1000 (EST)
Date: Mon, 3 Jun 2013 18:43:15 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/sysfs: disable hotplug for the boot cpu
Message-ID: <20130603104315.GA1365@localhost.localdomain>
References: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
 <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
 <1370036984.3928.144.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1370036984.3928.144.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 01, 2013 at 07:49:44AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-05-28 at 15:59 +0800, Zhao Chenhui wrote:
> > Some features depend on the boot cpu, for instance, hibernate/suspend.
> > So disable hotplug for the boot cpu.
> 
> Don't we have code to "move" the boot CPU around when that happens ?
> 
> Ben.
> 

Currently, the code in generic_cpu_disable() likes this:

        if (cpu == boot_cpuid)                                                 
	                return -EBUSY;

If the dying cpu is the boot cpu, it will return -EBUSY. In the subsequent error handling,
cpu_notify_nofail(CPU_DOWN_FAILED) in _cpu_down() will be called. Unfortunately, some
cpu notifier callbacks handled CPU_DOWN_PREPARE, but not CPU_DOWN_FAILED, such as sched_cpu_inactive().
So it will cause issues.

If we set the hotpluggable for the boot cpu, we can prevent user applications from disabling the boot cpu.

-Chenhui

> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> >  arch/powerpc/kernel/sysfs.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > index e68a845..294b1c4e 100644
> > --- a/arch/powerpc/kernel/sysfs.c
> > +++ b/arch/powerpc/kernel/sysfs.c
> > @@ -655,8 +655,10 @@ static int __init topology_init(void)
> >  		 * CPU.  For instance, the boot cpu might never be valid
> >  		 * for hotplugging.
> >  		 */
> > -		if (ppc_md.cpu_die)
> > +		if (ppc_md.cpu_die && cpu != boot_cpuid)
> >  			c->hotpluggable = 1;
> > +		else
> > +			c->hotpluggable = 0;
> >  
> >  		if (cpu_online(cpu) || c->hotpluggable) {
> >  			register_cpu(c, cpu);
> 
> 
> 

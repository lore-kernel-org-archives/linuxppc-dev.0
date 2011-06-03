Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09FD2B6FAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 13:52:15 +1000 (EST)
Subject: Re: PROBLEM: 2.6.39 =?UTF-8?Q?doesn=E2=80=99t?= boot on POWER MAC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: stable@kernel.org
In-Reply-To: <1307068891.23876.2.camel@pasglop>
References: <4DE0AA62.4070909@list.ru>  <20110603000012.4ce5c45f@Jay>
	<1307068891.23876.2.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Jun 2011 13:10:45 +1000
Message-ID: <1307070645.23876.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrey Gusev <ronne@list.ru>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-03 at 12:41 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2011-06-03 at 00:00 +0200, Giuliano Pochini wrote:
> > On Sat, 28 May 2011 11:55:14 +0400
> > Andrey Gusev <ronne@list.ru> wrote:
> > 
> > > Hi!
> > > A kernel 2.6.39 doesn't boot on my POWER MAC G4.
> > 
> > Same problem with my dual-G4 MDD. A few more infos:
> > The machine hangs just after the message "Returning from prom_init" (still
> > in the OF screen).
> > The kernel works fine with the option maxcpus=1, but it locks up as soon as
> > I try to enable the second CPU with echo 1 > /sys.../online.
> 
> I just verified that current upstream 3.0-rc1+ does boot fine.

The fix is:

  c560bbceaf6b06e52f1ef20131b76a3fdc0a2c19
  powerpc/4xx: Fix regression in SMP on 476

It looks like the regression wasn't specific to 476 but to all ppc
32-bit SMP setups. The bugs is specific to 2.6.39.

Greg, it should cherry-pick as-is but here's a copy in case you need it.

Cheers,
Ben.

>From c560bbceaf6b06e52f1ef20131b76a3fdc0a2c19 Mon Sep 17 00:00:00 2001
From: kerstin jonsson <kerstin.jonsson@ericsson.com>
Date: Tue, 17 May 2011 23:57:11 +0000
Subject: [PATCH] powerpc/4xx: Fix regression in SMP on 476

commit c56e58537d504706954a06570b4034c04e5b7500 breaks SMP support in PPC_47x chip.
 secondary_ti must be set to current thread info before callin kick_cpu or else
 start_secondary_47x will jump into void when trying to return to c-code.
 In the current setup secondary_ti is initialized before the CPU idle task is started
 and only the boot core will start. I am not sure this is the correct solution, but it
 makes SMP possible in my chip.
 Note! The HOTPLUG support probably need some fixing to, There is no trampoline code
 available in head_44x.S - start_secondary_resume?

Signed-off-by: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index cbdbb14..f2dcab7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -410,8 +410,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 {
 	int rc, c;
 
-	secondary_ti = current_set[cpu];
-
 	if (smp_ops == NULL ||
 	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
 		return -EINVAL;
@@ -421,6 +419,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	if (rc)
 		return rc;
 
+	secondary_ti = current_set[cpu];
+
 	/* Make sure callin-map entry is 0 (can be leftover a CPU
 	 * hotplug
 	 */

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6AF3DDF06
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 05:12:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5MJC2rE031338
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 15:12:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5MJC1XO216078
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 13:12:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5MJC1gT032553
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 13:12:01 -0600
Subject: Re: [patch] powerpc: sysfs fix compiler warning
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <467C1E58.6070702@ru.mvista.com>
References: <20070622194853.72fb652a@localhost>
	<1182537519.1554.14.camel@weaponx.rchland.ibm.com>
	<467C1BB5.2040600@ru.mvista.com>
	<1182539095.1554.18.camel@weaponx.rchland.ibm.com>
	<467C1E58.6070702@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 14:12:00 -0500
Message-Id: <1182539520.1554.19.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: Christian Krafft <krafft@de.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-22 at 23:09 +0400, Sergei Shtylyov wrote:
> Josh Boyer wrote:
> > On Fri, 2007-06-22 at 22:57 +0400, Sergei Shtylyov wrote:
> > 
> >>Hello.
> >>
> >>Josh Boyer wrote:
> >>
> >>
> >>>>From: Christian Krafft <krafft@de.ibm.com>
> >>
> >>>>This patch fixes the following compiler warning:
> >>>>arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
> >>>>`sysfs_create_group',
> >>
> >>>>Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> >>
> >>>>Index: linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> >>>>===================================================================
> >>>>--- linux-2.6.22-rc5.orig/arch/powerpc/kernel/sysfs.c
> >>>>+++ linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> >>>>@@ -380,16 +380,23 @@ int cpu_add_sysdev_attr_group(struct att
> >>>>{
> >>>>	int cpu;
> >>>>	struct sys_device *sysdev;
> >>>>+	int error;
> >>>>
> >>>>	mutex_lock(&cpu_mutex);
> >>>>
> >>>>	for_each_possible_cpu(cpu) {
> >>>>		sysdev = get_cpu_sysdev(cpu);
> >>>>-		sysfs_create_group(&sysdev->kobj, attrs);
> >>>>+		error |= sysfs_create_group(&sysdev->kobj, attrs);
> 
> >>>Why are you or'ing the return value with whatever is in the
> >>>uninitialized variable?
> 
> >>    To make it always fail, no doubt. ;-)
> >>    ISO accumulation error, it makes more sense to start cleanup created 
> >>groups right after the first creation failure -- although with the callers opf 
> >>this function ignoring the result anyway, who cares. :-)
> 
> > I care because he does an if (error) below that.  Since error isn't
> > initialized, it could be some random value and or'ing a 0 return code
> > from sysfs_create_group would still trigger the error path.
> 
> > Plus, it's bogus anyway and should be fixed.
> 
>     You misunderstood: I didn't at all object to fixing the bogosity you've 
> pointed out, just mused about how/if the error cleanup should be done.

Ah, gotcha.  Sorry, it's Friday and I shouldn't be here ;)

josh

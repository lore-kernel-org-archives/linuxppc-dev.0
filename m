Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EC8CDE005
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:25:14 +1000 (EST)
Date: Wed, 10 Oct 2007 11:18:28 -0500 (CDT)
Message-Id: <200710101618.l9AGISIP010663@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: crash on shutdown on rs/6000 powerpc
In-Reply-To: <470CF38F.3080809%40austin.ibm.com>
References: <470CF38F.3080809%40austin.ibm.com>,
	<18187.31582.236420.418530@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Joel Schoopp wrote:
>Paulus wrote:
>> [c00000003f923c40] c00000000003bff4 .xics_migrate_irqs_away+0x3c/0x20c
>> [c00000003f923d00] c000000000040d54 .pseries_cpu_disable+0x98/0xb4
>> [c00000003f923d80] c000000000028e4c .__cpu_disable+0x44/0x58
>> [c00000003f923df0] c00000000007e204 .take_cpu_down+0x34/0x60
>> [c00000003f923e70] c00000000008ba3c .do_stop+0x144/0x1e4
>> [c00000003f923f00] c00000000006fd74 .kthread+0x78/0xc4
>> [c00000003f923f90] c0000000000272a8 .kernel_thread+0x4c
>>
>> I don't have time tonight or tomorrow to track this down further.  I'm
>> taking the kids to the coast tommorow. :)
>>
> This looks like the problem Olof and Milton sent out patches to fix.  The 
> Power3 shouldn't be doing cpu hotplug.

Paul's comment prompted both of us.

Actually, cpu_hotplug (offline calling rtas stop-self, not dlpar
remove) should be supported on POWER3 and RS64, its just that the
pseries disable code calls over into xics directly.  offline support
would help preserve system uptime under a "failing processor"
scenerio.

To fix that, we need a mpic version of migrate_irqs_away.   powermac
is using the "bury head in sand" approach for that right now (ie
if you bind an interrupt and offline all the cpus in the mask, the
interrupt won't be delivered until you reset the affinity).  Its also
a broken in that bringing a cpu back online adds the cpu to all
interrupts not just those who have the cpu mask bit set.

milton

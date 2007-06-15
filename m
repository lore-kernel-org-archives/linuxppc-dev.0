Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0F790DDFBF
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 02:36:01 +1000 (EST)
In-Reply-To: <20070612145157.GA7562@in.ibm.com>
References: <20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
	<20070604105455.GA4916@in.ibm.com>
	<c1b8d82c8241fc3750c1339c34ecc799@bga.com>
	<20070606113134.GC4916@in.ibm.com>
	<ac119a2f080a47cf41f7c916010eaccd@bga.com>
	<20070612145157.GA7562@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <984f2f169b3e60daa032eb31147241b4@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Fri, 15 Jun 2007 11:35:49 -0500
To: mohan@in.ibm.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 12, 2007, at 9:51 AM, Mohan Kumar M wrote:
>
> Attached patch uses cpumask_scnprintf function.


> In some of the PPC970 based systems, interrupt would be distributed to
> offline cpus also even when booted with "maxcpus=1". So check whether
> cpu online map and cpu present map are equal or not. If they are equal
> default_distrib_server is used as interrupt server otherwise boot cpu
> (default_server) used as interrupt server.
>
> In addition to this, if an interrupt is assigned to a specific cpu (ie
> smp affinity) and if that cpu is not online, the earlier code used to
> return the default_distrib_server as interrupt server. This patch
> introduces an additional paramter to the get_irq function ie
> strict_check, based on this parameter, if the cpu is not online either
> default_distrib_server or -1 is returned.
>
> Cc: Milton Miller <miltonm@bga.com>,
>     Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
>

Acked-by: Milton Miller <miltonm@bga.com>

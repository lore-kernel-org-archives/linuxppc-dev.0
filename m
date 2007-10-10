Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19599DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 01:45:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9AFjOLF000554
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 11:45:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9AFjNTZ440644
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 09:45:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9AFjN49025835
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 09:45:23 -0600
Message-ID: <470CF38F.3080809@austin.ibm.com>
Date: Wed, 10 Oct 2007 10:45:19 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: crash on shutdown on rs/6000 powerpc
References: <18187.31582.236420.418530@cargo.ozlabs.ibm.com>
In-Reply-To: <18187.31582.236420.418530@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: lkml@rtr.ca, torvalds@linux-foundation.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> [c00000003f923c40] c00000000003bff4 .xics_migrate_irqs_away+0x3c/0x20c
> [c00000003f923d00] c000000000040d54 .pseries_cpu_disable+0x98/0xb4
> [c00000003f923d80] c000000000028e4c .__cpu_disable+0x44/0x58
> [c00000003f923df0] c00000000007e204 .take_cpu_down+0x34/0x60
> [c00000003f923e70] c00000000008ba3c .do_stop+0x144/0x1e4
> [c00000003f923f00] c00000000006fd74 .kthread+0x78/0xc4
> [c00000003f923f90] c0000000000272a8 .kernel_thread+0x4c/0x68
> 
> I don't have time tonight or tomorrow to track this down further.  I'm
> taking the kids to the coast tommorow. :)

This looks like the problem Olof and Milton sent out patches to fix.  The 
Power3 shouldn't be doing cpu hotplug.

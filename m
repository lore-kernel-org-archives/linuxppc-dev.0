Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1481BDDE24
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 12:20:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m351IYnA017742
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 21:18:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m351KOV1182076
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 19:20:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m351KO5V003594
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 19:20:24 -0600
Date: Fri, 4 Apr 2008 20:19:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: [PATCH] [v4] Add idle wait support for 44x platforms
Message-ID: <20080404201932.45aa8862@zod.rchland.ibm.com>
In-Reply-To: <bff8b51bd3e1c38518c3.1207326507@thinkpadL>
References: <bff8b51bd3e1c38518c3.1207326507@thinkpadL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 04 Apr 2008 11:28:27 -0500
Jerone Young <jyoung5@us.ibm.com> wrote:

> 2 files changed, 87 insertions(+), 1 deletion(-)
> arch/powerpc/platforms/44x/Makefile |    2 
> arch/powerpc/platforms/44x/idle.c   |   86 +++++++++++++++++++++++++++++++++++
> 
> 
> - adds MSR_DE to MSRs to enable while in wait state
> 
> This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.
> 
> 1) Command line
> 	idle=spin <-- CPU will spin (this is the default)
> 	idle=wait <-- set CPU into wait state when idle
> 
> 2) The device tree will be checked for the "/hypervisor" node
>    If this node is seen it will use "wait" for idle, so that
>    the hypervisor can know when guest Linux kernel it is in
>    an idle state.
> 
> This patch, unlike the last, isolates the code to 44x platforms.
> 
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

This one looks great to me.  Thanks for being persistent.

I'll keep it queued up until early next week.  I've emailed the CPU
engineers to see what exactly wait state does to the core and if they
know of any issues with it.

If it comes back clean from them and we get good test results with it
enabled, then we can likely reverse the default to use it and remove
the check for the hypervisor node.

josh

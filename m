Return-Path: <jyoung5@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2F06DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 17:15:18 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m346HJdB023588
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:17:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m346FF6C228846
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:15:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m346FES7014798
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:15:15 -0400
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle wait support for 44x platforms
From: Jerone Young <jyoung5@us.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <200804031813.59297.hollisb@us.ibm.com>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<200804031813.59297.hollisb@us.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 01:15:13 -0500
Message-Id: <1207289713.6971.20.camel@thinkpadL>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Stuart Yoder <stuart.yoder@freescale.com>
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-03 at 18:13 -0500, Hollis Blanchard wrote:
> On Thursday 03 April 2008 17:43:02 Jerone Young wrote:
> > # HG changeset patch
> > # User Jerone Young <jyoung5@us.ibm.com>
> > # Date 1207262487 18000
> > # Node ID 7226bef216680748a50327900572c2fbc3e762b0
> > # Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
> > Add idle wait support for 44x platforms
> >
> > This patch adds the ability for the CPU to go into wait state while in
> > cpu_idle loop. This helps virtulization solutions know when the guest Linux
> > kernel is in an idle state. There are two ways to do it.
> >
> > 1) Command line
> > 	idle=spin <-- CPU will spin (this is the default)
> > 	idle=wait <-- set CPU into wait state when idle
> >
> > 2) The device tree will be checked for the "/hypervisor" node
> >    If this node is seen it will use "wait" for idle, so that
> >    the hypervisor can know when guest Linux kernel it is in
> >    an idle state.
> >
> > This patch, unlike the last, isolates the code to 44x platforms.
> >
> > Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> 
> Very nice.
> 
> > +static void ppc44x_idle(void)
> > +{
> > +	unsigned long msr_save;
> > +
> > +	msr_save = mfmsr();
> > +	/* set wait state MSR */
> > +	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);
> > +	/* return to initial state */
> > +	mtmsr(msr_save);
> > +}
> > +
> > +int __init ppc44x_idle_init(void)
> > +{
> > +	if(of_find_node_by_path("/hypervisor") != NULL) {
> > +		/* if we find /hypervisor node is in device tree,
> > +		   set idle mode to wait */
> > +		current_mode = 1; /* wait mode */
> > +	}
> > +
> > +	ppc_md.power_save = modes[current_mode].entry;
> > +	return 0;
> > +}
> 
> By the way, watch that space in "if(". Also, you need to call of_node_put()
Got it.

> 
> The one thing I don't like is the hardcoded assumption that 1 means "wait". 
> Instead, you could do something like this (not even compile-tested):
> 
> int __init ppc44x_idle_init(void)
> {
> 	void *func = modes[current_mode].entry;
> 	struct device_node *node;
> 
> 	node = of_find_node_by_path("/hypervisor") 
> 	if (node) {
> 		/* if we find /hypervisor node is in device tree,
> 		 * set idle mode to wait */
> 		func = &ppc44x_idle;
> 		of_node_put(node);
> 	}
> 
> 	ppc_md.power_save = func;
> 	return 0;
> }
> 
Will change.

> Stuart, we're getting into ePAPR territory. Do you think we need to worry 
> about a hypervisor not handling mtmsr(MSR_WE)? In that case, we'd need to be 
> more specific than just testing for "/hypervisor". IMHO every hypervisor 
> should implement it... but maybe /hypervisor/idle = "wait" would be more 
> explicit and therefore better?

This is the problem with just looking for the /hypervisor node. I'll
submit another with all the comments from everyone. But I have a feeling
this is going to lead to a longer discussion.

> 

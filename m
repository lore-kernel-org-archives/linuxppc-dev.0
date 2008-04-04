Return-Path: <jyoung5@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D349DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 17:12:44 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m346Ei4U017466
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:14:44 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m346CeRc220342
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:12:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m346Ceiv010103
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 02:12:40 -0400
Subject: Re: [PATCH] Add idle wait support for 44x platforms
From: Jerone Young <jyoung5@us.ibm.com>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20080403230356.GJ20457@bakeyournoodle.com>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<20080403230356.GJ20457@bakeyournoodle.com>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 01:12:38 -0500
Message-Id: <1207289558.6971.15.camel@thinkpadL>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-04 at 10:03 +1100, Tony Breeds wrote:
> On Thu, Apr 03, 2008 at 05:43:02PM -0500, Jerone Young wrote:
> 
> Hi Jerone,
> 	A few minor nits.
> > Add idle wait support for 44x platforms
> > 
> > This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.
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
> Can you include a diffstat in here?

I think there is a way. I can see if I can do it. Though I may have to
do it out side of my normal hg tools.

> 
> > +static int current_mode = 0;
> 
> Leave this as: static int current_mode;, so it'll end up in the bss

The problem here is that this defines the default case. Is there really
a benefit having this in bss ?

> 
> > +int __init ppc44x_idle_init(void)
> > +{
> > +	if(of_find_node_by_path("/hypervisor") != NULL) {
>           ^ space
> > +		/* if we find /hypervisor node is in device tree,
> > +		   set idle mode to wait */
> > +		current_mode = 1; /* wait mode */
> > +	}
> 
> You don't really need the braces {} here.
> 
> > +static int __init idle_param(char *p)
> > +{ 
> > +	int i;
> > +
> > +	for (i = 0; i < sizeof(modes)/sizeof(struct sleep_mode); i++) {
> 
> ARRAY_SIZE(modes)

I'll do this.

> 
> Yours Tony
> 
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
> 

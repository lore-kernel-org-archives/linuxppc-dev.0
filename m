Return-Path: <kevcorry@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D222DDFB5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 23:27:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l43DQvw4018445
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 09:26:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l43DQuQG205882
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 07:26:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l43DQutR016379
	for <linuxppc-dev@ozlabs.org>; Thu, 3 May 2007 07:26:56 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] powerpc: change topology_init() to a subsys_initcall
Date: Thu, 3 May 2007 08:26:54 -0500
References: <200705021208.59068.kevcorry@us.ibm.com>
	<200705021211.49331.kevcorry@us.ibm.com>
	<1178154707.5338.11.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1178154707.5338.11.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705030826.55427.kevcorry@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Carl Love <carll@us.ibm.com>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Michael,

On Wed May 2 2007 8:11 pm, Michael Ellerman wrote:
> On Wed, 2007-05-02 at 12:11 -0500, Kevin Corry wrote:
> > Change the powerpc version of topology_init() from an __initcall to
> > a subsys_initcall to match all other architectures.
> >
> > Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
> >
> > Index: linux-2.6.21/arch/powerpc/kernel/sysfs.c
> > ===================================================================
> > --- linux-2.6.21.orig/arch/powerpc/kernel/sysfs.c
> > +++ linux-2.6.21/arch/powerpc/kernel/sysfs.c
> > @@ -498,4 +498,4 @@ static int __init topology_init(void)
> >
> >  	return 0;
> >  }
> > -__initcall(topology_init);
> > +subsys_initcall(topology_init);
>
> topology_init() depends on the register_one_node() stuff being
> available, which relies on register_node_type() being called AFAICT -
> which is a postcore_initcall(). So that's OK.
>
> It also creates sysfs files, which is OK because long before initcalls
> run vfs_caches_init() called mnt_init() which called sysfs_init().
>
> Just to be super safe it'd be good to diff your sysfs before and after
> the change. But assuming that show's nothing this looks fine to me.

I booted with and without this patch applied, and the file listings of /sys on 
both kernels show no differences (other than timestamps).

Thanks for the feedback.
-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/

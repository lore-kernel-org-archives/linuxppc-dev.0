Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5420B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 16:19:38 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB65GZfi004616
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Dec 2009 16:16:35 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB65Fq981675462
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Dec 2009 16:15:53 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB65JaWs026156
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Dec 2009 16:19:37 +1100
Date: Sun, 6 Dec 2009 10:49:28 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [v10 PATCH 2/9]: cpuidle: cleanup drivers/cpuidle/cpuidle.c
Message-ID: <20091206051928.GA18300@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<20091202095705.GC27251@linux.vnet.ibm.com>
	<200912042320.01320.duwe@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200912042320.01320.duwe@lst.de>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Torsten Duwe <duwe@lst.de> [2009-12-04 23:20:00]:

> On Wednesday 02 December 2009, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-12-02 15:24:27]:
> >
> > This patch cleans up drivers/cpuidle/cpuidle.c
> > Earlier cpuidle assumed pm_idle as the default idle loop. Break that
> > assumption and make it more generic.
> 
> Is there a problem with the old pm_idle? Couldn't it be integrated more 
> transparently, instead of replacing it this intrusively?
> 

Hi Torsten,

Peter objected to the idea of integrating this with the old pm_idle
because it has already caused a lot of problems on x86 and we wouldn't
want to be doing the same mistake on POWER. The discussion related to
that could be found here http://lkml.org/lkml/2009/8/26/233

> > --- linux.trees.git.orig/include/linux/cpuidle.h
> > +++ linux.trees.git/include/linux/cpuidle.h
> > @@ -41,7 +41,7 @@ struct cpuidle_state {
> >  	unsigned long long	usage;
> >  	unsigned long long	time; /* in US */
> >
> > -	int (*enter)	(struct cpuidle_device *dev,
> > +	void (*enter)	(struct cpuidle_device *dev,
> >  			 struct cpuidle_state *state);
> >  };
> 
> While it may be a good idea to move the residency calculation to one central 
> place, at least in theory a cpuidle_state->enter() function could have a 
> better method to determine its value.
>

This would mean a lot of code replication, which Pavel pointed out in
the previous iteration. So I moved the residency calculation to a
central place.

> Either way you're implicitly introducing an API change here, and you're at 
> least missing two functions on ARM and SuperH, respectively. Could you 
> separate this API change out, and not take it for granted in the other 
> patches?
>
> 	Torsten

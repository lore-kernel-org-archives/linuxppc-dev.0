Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81881B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 08:35:53 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id nABLWw7O031079
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2009 08:32:58 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nABLWdpW1372330
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2009 08:32:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nABLZpOB025048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2009 08:35:52 +1100
Subject: Re: [PATCH v5 0/4] pseries: Add cede support for cpu-offline
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1257945935.4372.36.camel@twins>
References: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
	<1257945935.4372.36.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Nov 2009 08:35:50 +1100
Message-ID: <1257975350.2140.49.camel@pasglop>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-11 at 14:25 +0100, Peter Zijlstra wrote:
> On Fri, 2009-10-30 at 10:52 +0530, Gautham R Shenoy wrote:
> 
> > Gautham R Shenoy (4):
> >       pseries: Serialize cpu hotplug operations during deactivate Vs deallocate
> >       pseries: Add code to online/offline CPUs of a DLPAR node.
> >       pSeries: Add hooks to put the CPU into an appropriate offline state
> >       pSeries: extended_cede_processor() helper function.
> > 
> > 
> >  Documentation/cpu-hotplug.txt                   |    6 +
> >  arch/powerpc/include/asm/lppaca.h               |    9 +
> >  arch/powerpc/platforms/pseries/dlpar.c          |  129 ++++++++++++++++
> >  arch/powerpc/platforms/pseries/hotplug-cpu.c    |  182 ++++++++++++++++++++++-
> >  arch/powerpc/platforms/pseries/offline_states.h |   18 ++
> >  arch/powerpc/platforms/pseries/plpar_wrappers.h |   22 +++
> >  arch/powerpc/platforms/pseries/smp.c            |   19 ++
> >  arch/powerpc/xmon/xmon.c                        |    3 
> >  drivers/base/cpu.c                              |    2 
> >  include/linux/cpu.h                             |   13 ++
> >  10 files changed, 387 insertions(+), 16 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/pseries/offline_states.h
> 
> Not quite sure how you solved the DLPAR communication but since pretty
> much everything is under arch/powerpc/ I really don't have much to say.

Allright. I was hoping to have your ack for the drivers/base/cpu.c
change :-)

Cheers,
Ben.

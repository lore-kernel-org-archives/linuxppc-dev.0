Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4D9A2B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 21:32:29 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7QBWLuZ019233
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 17:02:21 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7QBWLvU2715806
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 17:02:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7QBWKOG020410
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 17:02:20 +0530
Date: Wed, 26 Aug 2009 17:02:17 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v2 PATCH 2/2]: pseries: Implement Pseries Processor Idle idle
	module.
Message-ID: <20090826113217.GA14758@linux.vnet.ibm.com>
References: <20090826110721.GA29759@linux.vnet.ibm.com>
	<20090826111003.GC29759@linux.vnet.ibm.com>
	<1251286038.1329.1.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1251286038.1329.1.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-08-26 13:27:18]:

> On Wed, 2009-08-26 at 16:40 +0530, Arun R Bharadwaj wrote:
> > +void (*pm_idle)(void);
> > +EXPORT_SYMBOL_GPL(pm_idle);
> 
> Seriously.. this caused plenty problems over on x86 and you're doing the
> exact same dumb thing?
> 

Hi Peter,

Cpuidle assumes pm_idle to be the default idle power management
function. So i should either do this, or change the stuff in cpuidle.c
so that it is more abstract.

--arun

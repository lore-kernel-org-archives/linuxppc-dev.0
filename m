Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06C59B6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Dec 2009 21:56:21 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id nB7AuJQN026872
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 16:26:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB7AuJW52625660
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 16:26:19 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB7AuIAp021493
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 16:26:18 +0530
Date: Mon, 7 Dec 2009 16:26:16 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [v10 PATCH 2/9]: cpuidle: cleanup drivers/cpuidle/cpuidle.c
Message-ID: <20091207105616.GC21290@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<200912042320.01320.duwe@lst.de>
	<20091206051928.GA18300@linux.vnet.ibm.com>
	<200912071117.58163.duwe@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200912071117.58163.duwe@lst.de>
Cc: Arun Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Torsten Duwe <duwe@lst.de> [2009-12-07 11:17:57]:

> On Sunday 06 December 2009, Arun R Bharadwaj wrote:
> 
> > Peter objected to the idea of integrating this with the old pm_idle
> > because it has already caused a lot of problems on x86 and we wouldn't
> > want to be doing the same mistake on POWER. The discussion related to
> > that could be found here http://lkml.org/lkml/2009/8/26/233
> 
> And BenH has sketched how it should be done on ppc, in that thread:
> http://lkml.org/lkml/2009/8/26/624 AFAIS this comment is still valid for v10.
> 
> Not only I would like to understand what is the conceptual idea behind the 
> other changes. Nothing wrong with cleanups, but there's got to be a purpose 
> and benefits.
> 
> 	Torsten

The reason for the cleanups is that we should have just one idle
function manager instead of having one for each arch, which needs to
be exported and hence really ugly. So thats why we
decided to do away with pm_idle and make cpuidle as _the_ idle
function manager. So in case of POWER, we have the ppc_md.power_save
which is the pm_idle equivalent. We discussed that in this thread
http://lkml.org/lkml/2009/9/2/20

thanks
arun

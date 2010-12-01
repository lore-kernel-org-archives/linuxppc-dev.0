Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8E8B1007D1
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2010 15:38:05 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id oB14X12F002387
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 15:33:01 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB14c4ID1650816
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 15:38:04 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB14c3TP006184
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 15:38:03 +1100
Date: Wed, 1 Dec 2010 10:07:58 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
Message-ID: <20101201043758.GA2219@in.ibm.com>
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
	<m38w0c77vs.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m38w0c77vs.fsf@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 29, 2010 at 11:15:51AM +0100, Andreas Schwab wrote:
> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> 
> > Although ppc_set_hwdebug() can set DABR through set_dabr() in
> > arch/powerpc/kernel/process.c, it is good to have it converted to use
> > register_user_hw_breakpoint().
> 
> What do you mean with "good to have"?  It doesn't work without it unless
> I disable PERF_EVENTS (which is the only way to disable
> HAVE_HW_BREAKPOINT).
> 
> Andreas.
>

Let me see if I can cook up a patch for this i.e. make set_dabr() invoke
register_user_hw_breakpoint() when CONFIG_PPC_BOOK3S is defined; before I
head out on my vacation (starting second week of this month).

Thanks,
K.Prasad
 

Return-Path: <vatsa@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8F26DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 22:58:13 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0SBwAOY019074
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 06:58:10 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0SBwA8I242132
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 06:58:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0SBw95E008636
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 06:58:10 -0500
Date: Mon, 28 Jan 2008 17:41:49 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
To: Michel.=?iso-8859-1?Q?D=E4nzer_=3Cmichel=40tungstengraphics=2Ecom=3E?=@snowy.in.ibm.com
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080128121149.GA29867@linux.vnet.ibm.com>
References: <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy>
	<1201511673.5923.46.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1201511673.5923.46.camel@thor.sulgenrain.local>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linuxppc-dev@ozlabs.org
Reply-To: vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 28, 2008 at 10:14:33AM +0100, Michel Dänzer wrote:
> > >       * With CONFIG_FAIR_USER_SCHED enabled, X becomes basically
> > >         unusable with a niced CPU hog, with or without top running. I
> > >         don't know when this started, possibly when this option was
> > >         first introduced.
> > 
> > Srivatsa found an issue that might explain the very bad behaviour under
> > group scheduling. But I gather you're not at all interested in this
> > feature?
> 
> That's right, but it's good to hear you have a lead there as well, and
> if you can't find any interested testers, let me know and I'll try.

Michel,
	Thanks for offering to test! The issue I found wrt preemption latency 
(when FAIR_USER_SCHED is turned on) is explained here:

http://marc.info/?l=linux-kernel&m=120148675326287

Does the patch in that URL help bring FAIR_USER_SCHED interactivity to the same
level as !FAIR_USER_SCHED?

-- 
Regards,
vatsa

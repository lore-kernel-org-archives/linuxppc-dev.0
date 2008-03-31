Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B157DE1FD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 03:52:11 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VHq86p011404
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 13:52:08 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VHpx9U158640
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:51:59 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VHpw3F016997
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 11:51:59 -0600
Date: Mon, 31 Mar 2008 12:48:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jyoung5@us.ibm.com
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle power save for ppc 4xx
Message-ID: <20080331124814.4ebfc405@zod.rchland.ibm.com>
In-Reply-To: <1206982322.9165.7.camel@thinkpadL>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206980871.5919.5.camel@basalt>
	<1206982322.9165.7.camel@thinkpadL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 31 Mar 2008 11:52:02 -0500
Jerone Young <jyoung5@us.ibm.com> wrote:

> > void ppc4xx_idle(void)
> > 
> > > +{
> > > +	unsigned long msr_save;
> > > +
> > > +	/* set wait state MSR */
> > > +	local_irq_enable();
> > > +	msr_save = mfmsr();
> > > +	mtmsr(msr_save|MSR_WE);
> > 
> > Why don't you |MSR_WE|MSR_EE at the same time?
> 
> You technically can do this. But the question is do all 4xx cpus use
> MSR_EE to enable interrupts? I can assume they do (from what I know),

They do for enabling external interrupts of normal priority.  MSR_CE
might also be used/needed if someone has the watchdog enabled or has an
external device with the UIC pin mapped as a CE.

josh

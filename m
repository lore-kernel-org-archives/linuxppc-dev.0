Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92DA0DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 07:37:11 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9UKdhQh032594
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 16:39:43 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9UKal2T103614
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 16:36:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9UKadaB023300
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 16:36:40 -0400
Date: Thu, 30 Oct 2008 16:36:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: 44x _tlbie() ME/CE/DE disabling unnecessary?
Message-ID: <20081030163645.4385a67c@zod.rchland.ibm.com>
In-Reply-To: <1225397640.8004.171.camel@pasglop>
References: <fb412d760810301104s228a6036s50adba8605a13a98@mail.gmail.com>
	<1225397640.8004.171.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David, Gibson <david@gibson.dropbear.id.au>,
	Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Oct 2008 07:14:00 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2008-10-30 at 13:04 -0500, Hollis Blanchard wrote:
> > 
> > I don't think it's necessary at all to disable ME/CE/DE inside
> > _tlbie() on 440, because the interrupt handlers for those types save
> > and restore MMUCR (they're all the same code path; see
> > mcheck_transfer_to_handler in entry_32.S).
> 
> This was written before the saving of MMUCR was added I think.

I was thinking that but git was being annoying.

> > However, I think EE does need to be disabled, since the normal EE
> > handler doesn't deal with MMUCR. So instead of all these MSR
> > manipulations, I think a simple wrteei 0/1 pair should do the trick?
> > Or maybe mfmsr/wrteei/wrtee, in case _tlbie() happens to be called
> > with interrupts disabled already.
> 
> Yes.

Agreed.  Hollis and I had this discussion on IRC and I pointed out that
the patch originally just started with wrteei's.

(And aren't you supposed to be on vacation...)

josh

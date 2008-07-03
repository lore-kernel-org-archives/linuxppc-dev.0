Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 489C1DDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 23:36:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63DaZCV027794
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:36:35 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63DaZlR173864
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 07:36:35 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63DaYqa004262
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 07:36:35 -0600
Date: Thu, 3 Jul 2008 09:33:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
Message-ID: <20080703093313.478e6773@zod.rchland.ibm.com>
In-Reply-To: <200806262041.12275.sr@denx.de>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<4863BBE2.2060107@freescale.com>
	<20080626142732.0ff6e64c@lappy.seanm.ca>
	<200806262041.12275.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jun 2008 20:41:12 +0200
Stefan Roese <sr@denx.de> wrote:

> On Thursday 26 June 2008, Sean MacLennan wrote:
> > > Well, there's a lot of disagreement on this subject.  Not only do we
> > > not agree on a method of enumerating devices, a lot of people have a
> > > problem with the concept of enumerating them in the first place!
> >
> > An interesting point is that I enforced an index in the i2c-ibm_iic
> > driver with no disagreement at all ;)
> 
> You have been lucky I suppose. :)
> 
> I could easily just have used this existing "index" property for the other 4xx 
> boards, but expected NAK's for this. That and because FSL uses "cell-index" 
> is why I asked prior to sending patches.
> 
> Now I have no idea how to support I2C on the other 4xx boards. Perhaps Josh 
> could advise how this should be done?

As David said elsewhere, cell-index is fine for figuring out how to
access the CPM registers, etc.  But it's not good for enumerating
across the whole system.

For I2C specifically, I think Sean already has a patch to switch the
4xx driver to not use the numbered functions, which eliminates the need
for the enumeration all together.  That seems like the right approach
to me.

josh

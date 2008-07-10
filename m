Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B54FDDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 10:48:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6A0lw0X024528
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 20:47:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6A0lwxu165396
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 18:47:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6A0lwcC020008
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 18:47:58 -0600
Date: Wed, 9 Jul 2008 20:44:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with
	more than 2GB of RAM
Message-ID: <20080709204435.4214f277@zod.rchland.ibm.com>
In-Reply-To: <1215635979.8970.385.camel@pasglop>
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<1215633758.8970.372.camel@pasglop>
	<20080709162219.4c07a67e@zod.rchland.ibm.com>
	<1215635979.8970.385.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Jul 2008 06:39:39 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2008-07-09 at 16:22 -0400, Josh Boyer wrote:
> > On Thu, 10 Jul 2008 06:02:38 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Wed, 2008-07-09 at 15:44 +0200, Stefan Roese wrote:
> > > > This patch enables 32bit PPC's (with 36bit physical address space, e.g.
> > > > IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
> > > > replacing types (unsigned long -> phys_addr_t).
> > > > 
> > > > Tested on an AMCC Katmai with 4GB of DDR2.
> > > > 
> > > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > 
> > > But DMAs will break no ?
> > 
> > How?
> 
> Hrm... forget it. It's fine up to 4G of RAM... (ie. as long as DMA is
> below 32 bits).

Right.  We haven't really dealt with anything larger than 4 GiB, and we
certainly aren't dealing with discontiguous DRAM due to I/O ranges.

josh

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D2E3DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 02:43:56 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALFhqdv011917
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 10:43:52 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALFhq5Q064256
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:43:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALFhpnk013990
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:43:51 -0700
Date: Wed, 21 Nov 2007 09:43:50 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] ibm_newemac: Fix possible lockup on close
Message-ID: <20071121094350.44a18e26@weaponx>
In-Reply-To: <20071121154123.GB23589@lst.de>
References: <1195625198.76200.922309668615.qpush@grosgo>
	<20071121060729.71A1FDDE01@ozlabs.org>
	<20071121154123.GB23589@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 16:41:23 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Nov 21, 2007 at 05:06:39PM +1100, Benjamin Herrenschmidt wrote:
> > It's a bad idea to call flush_scheduled_work from within a
> > netdev->stop because the linkwatch will occasionally take the
> > rtnl lock from a workqueue context, and thus that can deadlock.
> > 
> > This reworks things a bit in that area to avoid the problem.
> 
> So from the name of the driver you want to keep the previous emac
> driver around.  Is there a good reason for that?

It's being kept around until arch/ppc dies.  Then things should get
renamed.

josh

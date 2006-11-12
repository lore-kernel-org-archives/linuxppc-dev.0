Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20CDA67DB9
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 11:45:30 +1100 (EST)
Subject: Re: [PATCH 13/16] powerpc: add ps3 platform lpar addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061111112847.GD24288@lst.de>
References: <4554DB14.3070900@am.sony.com>  <20061111112847.GD24288@lst.de>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 11:45:16 +1100
Message-Id: <1163292316.4982.240.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 12:28 +0100, Christoph Hellwig wrote:
> On Fri, Nov 10, 2006 at 12:03:32PM -0800, Geoff Levand wrote:
> > Adds some needed bits for a config option PS3PF_USE_LPAR_ADDR that disables
> > the ps3pf lpar address translation mechanism.  This is a currently needed
> > workaround for limitations in the design of the spu support.
> 
> So make the code do the sane thing and don't put the config in the
> kernel tree.

Well... I'd like to keep the option for a little while.

There are performances issues with sparsemem the way it's used by
ps3pf.. the problem is that the memory map looks like you get a bunch of
memory at 0 (the RMO, not sure exactly how much in practice) and the
rest in a chunk all the way up the 48 bits or so max physical space.

So sparsemem ends up with an enormous mapping only populated at the very
beginning and the very end.

Thus, I'd like Geoff to keep the option of doing the manual translation
in the hash code for now until I finally get some HW and thus can do
some measurements, and possibly figure out a nicer way to deal with
that.

Cheers,
Ben.

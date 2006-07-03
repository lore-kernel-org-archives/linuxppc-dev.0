Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10EE567B54
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jul 2006 21:09:02 +1000 (EST)
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
In-Reply-To: <200607020818.27603.pantelis.antoniou@gmail.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<200607011750.05019.pantelis.antoniou@gmail.com>
	<DCEAAC0833DD314AB0B58112AD99B93B07B36F@ismail.innsys.innovsys.com>
	<200607020818.27603.pantelis.antoniou@gmail.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 21:08:49 +1000
Message-Id: <1151924929.19419.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-07-02 at 08:18 +0300, Pantelis Antoniou wrote:
> On Sunday 02 July 2006 06:54, Rune Torgersen wrote:
> > From: Pantelis Antoniou
> > Sent: Sat 7/1/2006 9:50 AM
> > >Since genalloc is the blessed linux thing it might be best to use that & remove
> > >rheap completely. Oh well...
> > 
> > Two problems with genalloc that I can see (for CPM programming):
> > 1) (minor) Does not have a way to specify alignment (genalloc does it for you)
> > 2) (major problerm, at least for me) Does not have a way to allocate a specified address in the pool.
> > 
> > 2 is needed esp when programming MCC drivers, since a lot of the datastructures must be in DP RAM _and_ be in a specific spot. And if you cannot tell the allocator that I am using a specific address, then the allocator might very well give somebody else that portion of RAM. The only solution without a fixed allocator is to allocate ALL memory in the DP RAM and use your own allocator. 
> > 
> 
> Yeah, that too.
> 
> Too bad there are no main tree drivers like that, but they do exist.
> 
> One could conceivably hack genalloc to do that, but will end up with
> something complex too.
> 
> BTW, there are other uEngine based architectures with similar alignment
> requirements.
> 
> So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm memory allocator.
> For some out of tree drivers, it is not.

Sounds like a good enough justification to keep rheap for now then.

Ben.

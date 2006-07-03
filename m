Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 076A2679E7
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jul 2006 22:19:10 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k63CJ9OK024035
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Jul 2006 05:19:09 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k63CJ7Cd026910
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Jul 2006 07:19:08 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E05000@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, Pantelis Antoniou
	<pantelis.antoniou@gmail.com>
Subject: RE: [PATCH] powerpc:Fix rheap alignment problem
Date: Mon, 3 Jul 2006 20:19:05 +0800 
MIME-Version: 1.0
Content-Type: text/plain
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

> > > Two problems with genalloc that I can see (for CPM programming):
> > > 1) (minor) Does not have a way to specify alignment (genalloc does it for
> you)
> > > 2) (major problerm, at least for me) Does not have a way to allocate a
> specified address in the pool.
> > >
> > > 2 is needed esp when programming MCC drivers, since a lot of the
> datastructures must be in DP RAM _and_ be in a specific spot. And if you cannot
> tell the allocator that I am using a specific address, then the allocator might
> very well give somebody else that portion of RAM. The only solution without
> a fixed allocator is to allocate ALL memory in the DP RAM and use your own
> allocator.
> > >
> >
> > Yeah, that too.
> >
> > Too bad there are no main tree drivers like that, but they do exist.
> >
> > One could conceivably hack genalloc to do that, but will end up with
> > something complex too.
> >
> > BTW, there are other uEngine based architectures with similar alignment
> > requirements.
> >
> > So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm
> memory allocator.
> > For some out of tree drivers, it is not.
> 
> Sounds like a good enough justification to keep rheap for now then.

As the reason I stated in the last mail, rheap should continue being used not only for this fix-address situation but also for CPM/QE buffer descriptor management.  Rheap and genalloc are two different implementations of dynamic memory allocator, which have different suitable cases.  Both of them should be kept for different applications.
> 
> Ben.

Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 776582BD46
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 11:17:00 +1000 (EST)
Date: Sun, 24 Oct 2004 18:16:54 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Jaeger <g.jaeger@sysgo.com>, linuxppc-embedded@ozlabs.org,
	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>,
	Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20041025011654.GA3290@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
	<20041022020226.GC22069@gate.ebshome.net>
	<200410220826.40794.g.jaeger@sysgo.com>
	<20041022082955.GA27169@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041022082955.GA27169@gate.ebshome.net>
Cc: 
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 01:29:55AM -0700, Eugene Surovegin wrote:
> FWIW, I haven't seen any problems when testing my new EMAC driver with 
> 100Mb hub, maybe it's only 10Mb related.
> 
> Anyway, this is first time I'm hearing about half duplex problems, 
> Matt just mentioned them on IRC to me.
> 
> I'll try to do some tests this weekend, although I have to admit half 
> duplex doesn't seem very important these days, nevertheless, if this 
> can be fixed, we better do this :).

OK, I did some tests with 2.4.28-pre4, 2.6.9 & 2.6.9-emac (2.6.9 with 
my new EMAC driver). I used Ocotea rev.3 with 440GX rev.C (533MHz).

I can confirm I see some problems in 10HDX mode - there is visible 
slow down during system boot up (NFS root). Just after logging into 
system, nfsstat shows around 350 retransmits.

My 2.6.9-emac tree doesn't show this behavior, I see no visible 
slow-down and nfsstat shows 0 retransmits.

I tried some quick hacks for 2.6.9 driver but was unable to find 
settings which could help (my new driver was almost re-written from 
scratch and I did a lot of things differently).

For *adventurous*, this new EMAC driver is available as a patch against 
2.6.9 BK tree at http://kernel.ebshome.net/. Please, note, it's still 
project in progress and it lacks support for all new 440GX features 
(GigE, TAH, jumbo frames, EMAC2/EMAC3). This is NAPI version with 
correct (I hope) error handling, chip access etc. On Ebony I was able 
to route around 144Kpps. I plan to implement support for _some_ 440GX 
new features soon (during next month, hopefully).

If there is an interest, I can make a patch against current 2.4 BK 
tree, but this will take some time (I'm a little swamped right now).

--
Eugene

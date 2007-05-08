Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B91ECDDE3E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:45:57 +1000 (EST)
Subject: Re: kernel expection generated with 2.6.21-mm1 kernel boot up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070508162350.GM4452@austin.ibm.com>
References: <463F06E2.5060308@linux.vnet.ibm.com>
	<1178538912.24522.12.camel@concordia.ozlabs.ibm.com>
	<463F1CA9.40501@linux.vnet.ibm.com> <4640675C.6090104@in.ibm.com>
	<20070508162350.GM4452@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:45:37 +1000
Message-Id: <1178667937.14928.128.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-08 at 11:23 -0500, Linas Vepstas wrote:
> On Tue, May 08, 2007 at 05:34:44PM +0530, Srinivasa Ds wrote:
> > 
> > Looks like problem is in SLUB layer, I unmarked SLUB(CONFIG_SLUB)
> > option and now system is booting.
> 
> Its been repored by others (and I can reproduce it),
> its a problem with a bad interaction with SLUB and pg_tables
> A patch flew by recetnly that would not use slub for pg_tables, 
> but I don't know if that's the permanent fix.

Working on it... we'll be using __get_free_page() for the lowest level
of page tables.

Ben.

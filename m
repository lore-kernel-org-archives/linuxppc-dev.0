Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 504EEB7D1B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 09:15:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3MNFcfX021721
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 16:15:49 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3MNNqSs015528
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 18:23:52 -0500 (CDT)
Date: Thu, 22 Apr 2010 18:27:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
Message-Id: <20100422182714.b591f3e2.kim.phillips@freescale.com>
In-Reply-To: <1271897416.2330.186.camel@pasglop>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
	<20100421194419.3edf2c80.kim.phillips@freescale.com>
	<1271897416.2330.186.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Csdncannon <csdncannon@gmail.com>,
	zhouminggang@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Apr 2010 10:50:16 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2010-04-21 at 19:44 -0500, Kim Phillips wrote:
> > I took an 8377 rdb board, and let it run timebase.c (with the isync &
> > long long casts) all weekend, and have failed to reproduce the issue.
> > That was on linux 2.6.33, and I've got another machine running the
> > same
> > thing under 2.6.28 for the last couple of hours, still unable to
> > reproduce the issue.
> 
> Do we need to add an isync to the vdso and kernel gettimeofday() ?

don't see why: I put two gettimeofday calls in a tight loop, checking
if (t2.tv_sec < t1.tv_sec) || (t2.tv_sec > t1.tv_sec + 1), and the
condition was never met.  I also removed all {i,}sync instructions from
timebase.c (but left the long long casts in), and no failures were
reported.

Kim

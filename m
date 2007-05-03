Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75CB2DDF60
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:09:02 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17977.9796.15991.630737@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:08:56 +1000
Message-Id: <1178150936.17299.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 10:01 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > On Wed, 2007-05-02 at 16:33 +0200, Johannes Berg wrote:
> > > On Wed, 2007-05-02 at 20:55 +1000, Paul Mackerras wrote:
> > > 
> > > > Ultimately we want to put the disabled cpus in sleep mode, but that
> > > > will require a suitable cache flush routine.
> > > 
> > > I don't have any docs for the particular processors the G5s have, do
> > > they have a sleep mode?
> > 
> > They have, but the cache flush is not trivial to do (and might imply
> > access to non documented bits). So let's put that on the to-do list and
> > stick to NAP for now while I dig something.
> 
> Hmmm, I went looking in the 970FX manual for sleep mode and didn't
> find it, only nap and doze...

Ah... hrm... so it's possible that Darwin goes NAP but flushes the cache
before suspend-to-ram bcs the CPU is going down... let me check.

Nah, darwin uses HID0:sleep

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 647CF679A6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 16:02:18 +1000 (EST)
Subject: Re: windfarm got signal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1150847482.16662.13.camel@johannes>
References: <1150847482.16662.13.camel@johannes>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 16:02:03 +1000
Message-Id: <1150956123.3633.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-21 at 01:51 +0200, Johannes Berg wrote:
> Hey,
> 
> after cpu hotplug I decided to write some fake suspend routines for
> ppc64 that always fail to see what all the drivers would say... The
> first thing I saw was during the phase where all threads are stopped,
> that windfarm got a signal!
> 
> Shortly after that, the fans were revved up fully but I guess that's
> expected if the wf control loop exits.
> 
> So now I'm trying to see *why* it got a signal there. Any ideas? Is that
> expected with pm and windfarm just does the wrong thing there by taking
> the signal as a reason to exit the control thread?
> 
> [code in question is windfarm_core.c:wf_thread_func]

I think it's the way the freezer works ... it sends a pseudo signal to
all kernel threads who are then supposed to do something like test for
PF_FREEZE or something like that.

Ben.

Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 2C33D67A41
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 21:27:07 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] windfarm got signal
Date: Thu, 22 Jun 2006 13:03:19 +0200
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
In-Reply-To: <1150956123.3633.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606221303.19860.rjw@sisk.pl>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 June 2006 08:02, Benjamin Herrenschmidt wrote:
> On Wed, 2006-06-21 at 01:51 +0200, Johannes Berg wrote:
> > Hey,
> > 
> > after cpu hotplug I decided to write some fake suspend routines for
> > ppc64 that always fail to see what all the drivers would say... The
> > first thing I saw was during the phase where all threads are stopped,
> > that windfarm got a signal!
> > 
> > Shortly after that, the fans were revved up fully but I guess that's
> > expected if the wf control loop exits.
> > 
> > So now I'm trying to see *why* it got a signal there. Any ideas? Is that
> > expected with pm and windfarm just does the wrong thing there by taking
> > the signal as a reason to exit the control thread?
> > 
> > [code in question is windfarm_core.c:wf_thread_func]
> 
> I think it's the way the freezer works ... it sends a pseudo signal to
> all kernel threads who are then supposed to do something like test for
> PF_FREEZE or something like that.

Yes.  More precisely, they are supposed to use try_to_freeze().

Please see Documentation/power/kernel_threads.txt.

Greetings,
Rafael

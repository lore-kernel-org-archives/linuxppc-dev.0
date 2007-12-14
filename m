Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 7D292DE153
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 11:10:12 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: apm_emulation regression
Date: Fri, 14 Dec 2007 01:10:43 +0100
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
In-Reply-To: <1197482587.6558.145.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712140110.44406.rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday, 12 of December 2007, Johannes Berg wrote:
> 
> On Wed, 2007-12-12 at 13:45 +1100, Benjamin Herrenschmidt wrote:
> > I only just noticed a huge regression that was introduced when we moved
> > PowerPC to the generic APM emulation code instead of our own. I'm in
> > large part to blame since I acked the patch...
> > 
> > Basically, what we lost is the mechanism for notifying user applications
> > and waiting for their ACK before proceeding to system suspend. The new
> > generic code will still do that ... only when the actual suspend request
> > initiates from an APM suspend ioctl.
> 
> Indeed.
> 
> > For any other suspend (via our private PMU ioctl or via the sysfs
> > interface), userspace will -not- be notified.
> 
> Right.
> 
> > That basically means X will break. That's why X broke on the latest
> > ubuntu until I whacked some new scripts in them to force console
> > switching, among other things. Possibly other apps that relied
> > on /dev/apm_bios to be notified of system suspend/resume broke as well.
> 
> Ah. I guess I never noticed because I had the scripts to do console
> switching all along.
> 
> > Now the question is that is it still work trying to fix it ? That would
> > probably require APM emulation hooking at a fairly high level into the
> > generic PM code to trigger the signaling & waiting of processes before
> > freeze & device suspend among others...
> 
> Yeah, bit icky... but doable. Rafael, any ideas?

Hmm.

I'm not that familiar with the APM emulation code, but the description of the
problem above suggests that the APM emulation can install a suspend
notifier for this purpose.

Greetings,
Rafael

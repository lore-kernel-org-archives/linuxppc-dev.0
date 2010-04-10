Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id C9F27B7D0C
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 09:40:51 +1000 (EST)
Date: Sun, 11 Apr 2010 08:39:09 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: A better way to sequence driver initialization?
Message-ID: <20100410233909.GA16099@linux-sh.org>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
	<4BC07EAD.9020307@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BC07EAD.9020307@billgatliff.com>
Cc: linux-embedded <linux-embedded@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 10, 2010 at 08:35:41AM -0500, Bill Gatliff wrote:
> Benjamin Herrenschmidt wrote:
> > On Fri, 2010-04-09 at 14:23 -0500, Bill Gatliff wrote:
> >   
> >> My recent post, "Requesting a GPIO that hasn't been registered yet", and
> >> Anton's reply thereto (thanks, Anton!) on linuxppc-dev got me thinking
> >> about the problem of dependencies between devices in different  classes,
> >> and/or between drivers/devices in general.  I'd like to float an idea to
> >> see if it's worth pursuing. 
> >>     
> >
> > I'd rather do things a bit more explicitely and less prone to break
> > existing stuff... something along the lines of, first defining a variant
> > of the initcalls to enable that "multithreaded" stuff, along with an
> > explicit wait_for_service("subsys:hid"); for example.
> >
> > One could also expose service deps via the module info, thus delaying
> > module init, or things like that (in fact, initcalls could even come
> > with a list of dependencies).
> >   
> 
> The general problem with your approach is that the module in question
> might not know what services it needs to wait for.
> 
> Specific to my situation, the gpio-led code doesn't have any way of
> knowing that it needs to wait until my pca953x i2c devices have all been
> installed so that the gpio pin I have specified even exists.  And short
> of setting up some kind of table in the board-specific code (or device
> tree, actually), I don't know how to communicate such a dependency
> without touching the generic gpio-led code--- which I'm trying to avoid.
> 
This is a common problem for drivers that are all stuck on the same
initcall level and as a result are entirely dependent on link order. Some
more intelligent logic via the bus notifiers would help with some of
this, but it wouldn't help with drivers that are effectively unable to
probe for devices and that are entirely dependent on registration timing
to make sure that their backing device has become available.

You could also look at doing multi-threaded probing at the bus level
where the semantics and implications are better understood, but that
still doesn't necessarily help with ordering. (ie, registering a GPIO
expander on a PCI MFD before being able to bring up gpio-leds or
so). There has been past work for both multi-threading the probe routines
as well as constraining it and only doing it for things like PCI.

In cases where you can specifically note that dependencies, doing so will
save you a world of pain. Despite that, it's simply not possible to do
this as a free-for-all. Devices or busses that can tolerate multi-threaded
probing need to be converted over one at a time, but even then you still
need the dependency tracking for those that depend on link order today.

Vendors often end up doing this sort of work for device-specific kernels
where the underlying set of drivers is fixed, so there are also some
alternative approaches you can investigate there (OLPC comes to mind).

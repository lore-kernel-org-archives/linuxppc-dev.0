Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5AB1B7D1C
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 17:18:57 +1000 (EST)
Subject: Re: A better way to sequence driver initialization?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mundt <lethal@linux-sh.org>
In-Reply-To: <20100410233909.GA16099@linux-sh.org>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop> <4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Apr 2010 17:18:48 +1000
Message-ID: <1270970328.6865.119.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Bill Gatliff <bgat@billgatliff.com>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-04-11 at 08:39 +0900, Paul Mundt wrote:
> This is a common problem for drivers that are all stuck on the same
> initcall level and as a result are entirely dependent on link order. Some
> more intelligent logic via the bus notifiers would help with some of
> this, but it wouldn't help with drivers that are effectively unable to
> probe for devices and that are entirely dependent on registration timing
> to make sure that their backing device has become available.

Right. Exactly my problem with EMAC for example.

> You could also look at doing multi-threaded probing at the bus level
> where the semantics and implications are better understood, but that
> still doesn't necessarily help with ordering. (ie, registering a GPIO
> expander on a PCI MFD before being able to bring up gpio-leds or
> so). There has been past work for both multi-threading the probe routines
> as well as constraining it and only doing it for things like PCI.

I'd like to detatch the ordering problem from the threading feature,
those are mostly orthogonal. We could solve the ordering problem with
either some creative way of defining dependencies statically (but I
personally think that's doomed) or a way for probe() to return -EAGAIN
after the driver got a chance to attach itself to some kind of mechanism
to re-trigger the probing when some condition is satisfied (bus
notifier ? exported service names as in my previous example ? some combo
of these ?).

Then for archs like powerpc, we can add a layer to automate maybe the
dependency resolution by using the device-tree, though the underlying
mechanism doesn't need to be device-tree based.

> In cases where you can specifically note that dependencies, doing so will
> save you a world of pain. Despite that, it's simply not possible to do
> this as a free-for-all. Devices or busses that can tolerate multi-threaded
> probing need to be converted over one at a time, but even then you still
> need the dependency tracking for those that depend on link order today.
> 
> Vendors often end up doing this sort of work for device-specific kernels
> where the underlying set of drivers is fixed, so there are also some
> alternative approaches you can investigate there (OLPC comes to mind).

As I said above, I think we should keep the dependency handling from the
threading two separate things :-)

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E23642C017B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 09:12:21 +1000 (EST)
Message-ID: <1373843487.19894.304.camel@pasglop>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cbf123@mail.usask.ca>
Date: Mon, 15 Jul 2013 09:11:27 +1000
In-Reply-To: <51E32F76.5070502@mail.usask.ca>
References: <51DF1BBB.5060904@mail.usask.ca>
 <51DF2229.5010604@mail.usask.ca> <20130712012142.GA24112@concordia>
 <51E07056.8040007@mail.usask.ca> <51E08A40.80900@mail.usask.ca>
 <51E0F41A.20904@mail.usask.ca> <20130714043600.GA30717@concordia>
 <1373779584.19894.270.camel@pasglop> <51E32F76.5070502@mail.usask.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-07-14 at 17:08 -0600, Chris Friesen wrote:
> > So for memory starting at 0 it should be memory@0
> 
> There are a fair number of dts files in the kernel tree that don't 
> specify an address for the memory node.
> 
> If the kernel accepts it without an address, it seems logical that kexec 
> should as well.

As long as kexec doesn't start being stupid when there are several nodes
and doesn't pick up the "first one in device-tree order" instead of the
one at 0...

I've been hit by that sort of bugs before (though not specifically in
kexec).

> Or maybe the kernel should just implicitly assume an address of zero and 
> export it as such in /proc/device-tree?

I don't want /proc/device-tree to expose something different than what's in
the actual device-tree, that would be the source for endless horrors.

We already are borderline with the occasional renaming we do in the case of
duplicate name+property...

Cheers,
Ben.

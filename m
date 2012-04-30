Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33871B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 15:00:14 +1000 (EST)
Message-ID: <1335762005.20866.35.camel@pasglop>
Subject: Re: [PATCH] Disable /dev/port interface on powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Mon, 30 Apr 2012 15:00:05 +1000
In-Reply-To: <1332314613.2982.38.camel@pasglop>
References: <1332308237.23222.49.camel@hbabu-laptop>
 <1332314613.2982.38.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 18:23 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2012-03-20 at 22:37 -0700, Haren Myneni wrote:
> > Some power systems do not have legacy ISA devices. So, /dev/port is not
> > a valid interface on these systems. User level tools such as kbdrate is
> > trying to access the device using this interface which is causing the
> > system crash. 
> > 
> > This patch will fix this issue by not creating this interface on these
> > powerpc systems. 
> 
> Doesn't fix 32-bit... not a big deal for now I suppose... But I'd rather
> you change the patch a tiny bit to change legacy_isa_device_found() to
> arch_has_dev_port() instead. There may be other reason than legacy ISA
> to enable dev/port or not so let's make the arch hook more generic.
> 
> Another approach which might be even better is to filter per-access,
> ie for each read/write to /dev/port, have a hook to check if that
> specific port is valid, but that may be overkill for what is
> essentially a legacy interface that should have died a long time ago :)

The more I think about this the less I like it ...

At the end of the day, the bug is in kbdrate (or the distro, whatever)

It's just completely broken to have a bit of userspace running as root
randomly whacking IO ports or MMIO registers based on the assumption
that there must be some kind of ISA kbd controller there... It's going
to break on more than just powerpc (ARM anyone ?).

So kbdrate is busted and needs to be either fixed or removed.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3B8B679F8
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 08:07:35 +1000 (EST)
Subject: Re: ppc32 kernel boot problem (pmu related?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Pilatzke <nathanpilatzke@gmail.com>
In-Reply-To: <98889dd30605160804i78fc6a31w5147aba1dc5562b@mail.gmail.com>
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
	<1147403525.7343.19.camel@localhost.localdomain>
	<98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
	<1147658309.21291.73.camel@localhost.localdomain>
	<98889dd30605152106m9090ba3ga1a4c7706aace3ef@mail.gmail.com>
	<1147754594.13588.17.camel@localhost.localdomain>
	<98889dd30605160804i78fc6a31w5147aba1dc5562b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 08:07:27 +1000
Message-Id: <1147817247.6753.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-16 at 11:04 -0400, Nathan Pilatzke wrote:
> On 5/16/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Can you try editing arch/powerpc/platforms/powermac/low_i2c.c, in
> > function pmac_i2c_init(), comment out the call to pmac_i2c_devscan() and
> > tell me if that makes a difference.
> >
> > Thanks,
> > Ben.
> >
> >
> Commenting out the call to pmac_i2c_devscan() in function
> pmac_i2c_init() allowed the kernel to boot.  I am typing this email
> booted under it.  The kernel messages were printed a bit strangely
> though.  There was no scrolling or clearing of the screen.  The kernel
> messages would start at the top and overwrite old messages, with the
> cursor jumping back to the top of the screen every so often.

That's because of the change you did to udbg.c for debugging :)

> The /proc/device-tree is attached for the booting 2.6.17-rc3 kernel with
> pmu enabled, as is the new dmesg output.  If you need the
> /proc/device-tree from a 2.6.15 working kernel with pmu enabled
> instead, let me know.

No, it should be the same regardless of the kernel

> Is this kernel fairly safe/stable to use?  What can be done next?

Well, I need to figure out what's going on with the i2c stuff... there
is a chip that hangs off the PMU and that says something like "do that
at boot"... but when I do it, it causes the crash you are seeing. So
either I'm not doing what it tells me to do properly or I should just
blacklist this machine (Apple doesn't execute the platform functions
from the device-tree on older machines I think).

I'm investigating, will come back to you.

Ben.

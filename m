Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <4540F16E.2050305@246tNt.com>
References: <453FB582.20802@bplan-gmbh.de>
	<4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
	<4540F16E.2050305@246tNt.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:03:02 +1000
Message-Id: <1161918182.25682.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since the bestcomm init is in a module, a different module could be
> implemented,
> (like bestcomm-chrp5k2.ko) that instead of clearing SRAM and doing
> everything
> from scrtch, would rely on the bootloader more. This would allow
> "custom" tasks
> to be marked as "don't touch". So if the bootloader want to load
> something that
> will not be altered by the linux driver (for whatever reason ...)

I don't think we should have two different modules.

We are talking here about arch/powerpc where the presence of a
device-tree is mandatory. Thus, we should rely on that and define
something based on that.

In any case, I strongly think a single module with a single API should
be able to deal with all the cases we need to define for loading the
tasks. As I defined in a separate email, that includes wether the tasks
are preloaded, provided as a blob in the device-tree (possibly via the
zImage wrapper, and thus still in the kernel tree), or hard coded in the
kernel driver (I don't like that solution though).

It's mostly a matter on how the thing initializes anyway. Once it's up
and running, the code path should be identical.

> However, for the tasks like FEC and ATA and everything supported in the
> kernel
> natively, I would still recommend reload the task code (anyway the
> driver is gonna
> reset the task and everything ...) Trying to reuse the microcode loaded
> by the
> bootloader is not a great idea IMHO. (Imagine, the fec driver is changed
> to use
> the latest microcode, but the bootloader is not ... both have to be in
> perfect sync ...)

Is there some versionning available with the microcode ? I'm afraid
there might not be (since that whole bestcomm business seems to be
immune to good ideas from whoever design the whole chip), but that would
be useful. I agree that having the task code coming from the firmware
might not be the best idea if there is no versionning, but it nicely
solves some of the problems related to distributing "binary blobs" ...
I'm sure debian would have issues with bestcomm code shipped with the
kernel....

If no versionning is available we might want to create one ourselves,
via a wiki possibly and one person (you ?) responsible for distributing
the "releases" and assigning them versions...

At which point, the device-tree can contain version information along
with the task code or pointers to the code in sram.

> We would still have to compare the internal FDT and the preloaded one
> though since
> they have to match ...

Ben.

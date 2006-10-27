Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Rigby <jcrigby@gmail.com>
In-Reply-To: <4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
References: <453FB582.20802@bplan-gmbh.de>
	<4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 12:57:41 +1000
Message-Id: <1161917861.25682.46.camel@localhost.localdomain>
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

On Thu, 2006-10-26 at 11:17 -0600, John Rigby wrote:
> >
> > * mpc5k2_bestcomm.c (& helpers): I've been in contact with others people
> > using bestcomm and please to see the development was still active. I'm
> > already using latest code on my board but this is not include in this
> > patch. Indeed, it needs some changes for ARCH=powerpc. Moreover, we have
> > a different approach for the tasks. I'll be pleased to work with the
> > bestcomm folks.
> >
> 
> So you preload the bestcomm task code in your boot loader?  Do those
> of us using other bootloaders still have the option of loading the
> task code later in linux?
> 
> What api are you using?  Sylvain's proposed one based on Dale's with
> some additions from me?  Or have you come up with your own?

I think we need to look into 3 options for the bestcomm task code:

 - Preloaded by the firmware
 - In the device-tree but not preloaded
 - In the kernel

Though we might want to completely dismiss the 3rd option and decide
that it has to be in the device-tree, wether it's provided by the
zImage wrapper, or by the firmware.

Do you see any other case ?

So we need to define the content of the various device nodes for those
3 cases. The 3rd case is easy: probably nothing to put there, purely an
in-kernel thing, unless the bestcomm task IDs related to a given cell
are always the same.

The two first ones are similar, with the exception that the "blob" is in
one case preloaded (thus we provide a property telling where it is in
the sram) and in the other case, the blob is in the DT itself, thus we
have a bit of "bootstrap" code that loads it. In both cases, tasks IDs
are known and thus the device-tree might contain the necessary binding
informations.

Now, in any case, the "drivers" need a way to link to their respective
"tasks". That is, the function drivers (FEC, ...) need to use functions
provided by the "bestcomm" driver to setup and use tasks. In order to do
that the function drivers need to provide enough information of course
to allow the bestcomm to properly find out the tasks.

That's why my idea is that we associate to "known" bestcomm tasks a name
(a string), for example, "fec-tx" and "fec-rx" and the function drivers
pass their device-node to the bestcomm drivers. The Bestcomm "driver"
can then look into the device-tree node for a property "bestcomm-task-%
s" where %s is the task "name", containing the task informations (ID,
position in a table, whatever, I don't remember the details, it's up to
you guys to define something).

That property can then be in the device own node, in the bestcomm node,
or absent in the case where the whole bestcom ucode is embedded in the
kernel itself, in which case the driver has an internal table to resolve
that, but I wonder if we shouldn't make madantory to at least have it in
the device-tree and thus ignore that case 3...

Ben.

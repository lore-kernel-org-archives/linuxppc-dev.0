Message-ID: <3A2FCFFF.79119495@mvista.com>
Date: Thu, 07 Dec 2000 12:59:27 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: jlhagen@collins.rockwell.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: prepboot, head.S questions.
References: <Pine.HPX.4.10.10012071058180.25689-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Actually I would like to see a lot of the functionality of kernel/head.S
> moved to the bootloader.

I disagree (and you knew I would :-).  I think we currently have the
proper separation here.  The code in kernel/head.S is entered with
everything properly located in memory (usually), MMUs and caches
disabled (or at least in a consistent state).  The code in kernel/head.S
initializes the system as the rest of the Linux kernel requires.

The code in the "boot" directories should do things that are unique
to the different platform environments.

> ...... I have a version of "prepboot" which is able to
> read OF device tree and put it in some place for late use by the kernel,

OK....but that doesn't require changes to kernel/head.S.  The OF/RTAS
is used by other kernel functions, the code in head.S doesn't care.
Just allocate a register or memory location and pass the information.
We need to clean up the parameter passing stuff between the boot loader
and the Linux kernel, and you could just pass it in there.

> This is much cleaner that the whole mess of running code at an address it
> has not been foreseen to run. prepboot is compliled with -mrelocatable and
> will run anywhere

I think all of the boot loaders do this (at least any I have used).
They determine where they are, move things around in memory and set up
parameter blocks so the kernel and initrd (or whatever) can run  in
their proper places.

> ..... It could be used on machines
> which do not have RAM at 0 with very minor modifications affecting only
> the installation of the exception handlers.

I already have minor modifications from folks at MontaVista to allow
the kernel to run from masked rom at a relatively arbitrary location.
I am trying to make these more generic and will be checking them into
the sources pretty soon.  It is based upon the structure of the
software as it is today, which seems to work pretty well.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3A63840E.4C724E03@mvista.com>
Date: Mon, 15 Jan 2001 18:13:18 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: kernel mapping
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How come we don't use iopa() and friends for all kernel mapping
information?  It is only defined for CONFIG_APUS, but is the right
thing to use on 8xx and 4xx, and probably all processors.  The
virt_to_bus/bus_to_virt contain the quickie arithmetic hack with
KERNELBASE, but that isn't the right thing to do for any kmalloc()
or valloc() space or if you don't have BAT mapping.

I am considering making these functions more generic, removing the
#ifdefs, and implementing "simulated" BAT mapping for processors
like the 8xx and 4xx that don't have BATs (not for 2.4, of course :-).

Why shouldn't I do this?

	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

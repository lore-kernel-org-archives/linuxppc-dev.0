From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15526.51621.991410.781713@argo.ozlabs.ibm.com>
Date: Sun, 31 Mar 2002 18:32:37 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <3C99801A.8070002@embeddededge.com>
References: <0203210213.AA15856@ivan.Harhan.ORG>
	<3C99801A.8070002@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> I don't agree.  I believe if you can't configure the software in the usual
> way with configuration options, you can't do it cleanly with bi_recs, either.
> There are pin multiplex configurations on 8xx that you just can't (or shouldn't
> due to lots of complexity) define in a dynamic manner.  The purpose of the
> current Linux configuration is to create a binary that fits a particular board
> and architecture.

I don't particularly like the way we define what is on a given
embedded board with what boils down to a shell script.  It seems ugly
and clumsy to me, as does the pile of #defines and #ifdefs that we end
up with as the way for drivers to know where their devices are.

What I would like to see is a readable, compact, clear description of
the hardware (for a given embedded board) in one place, i.e. one file.
Probably not in C code, rather some sort of syntax that can be parsed
with lex/yacc and describe a tree as the main structure but with other
cross-connections as well.

What do we do with such a machine description?  I see three things we
could use it for:

1. Derive a set of config option values (or recommendations for those
   values, at least) for including the necessary kernel drivers to
   support the devices on the board.

2. Make a list of devices and the information that their drivers will
   need about them, such as register base addresses, interrupt
   assignments, etc., for inclusion in the kernel.

3. Make such a list for inclusion in a bootloader so that it can
   supply it to the kernel, for people who aren't so worried about the
   size of their kernels and who want to be able to use the same
   kernel binary on several different boards.

The idea of 2 (and 3) is to make it easy for drivers to find out how
many instances of their device exist, and for each instance, the
critical information that the driver needs about it.  This could be
implemented in various ways.  The simplest would be to have a list in
one place with query functions defined which the drivers would use.
That would be relatively easy to implement but would maybe take up
more bytes than absolutely necessary.

For the situations where every byte is precious, we could get a little
cleverer and have preprocessing code which would scan the driver code
and convert the query function calls into references to an initialized
array, or even into just a constant if there is only one instance of
the device.

This would be needed primarily for on-chip or on-board peripherals
that are not self-describing, i.e. not for PCI devices.  We already
have enumeration and query functions for PCI devices.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

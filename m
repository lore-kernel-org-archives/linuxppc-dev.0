Message-ID: <3BD0EC63.EC375D7D@mvista.com>
Date: Fri, 19 Oct 2001 23:15:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel clutter
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Thoughts?  Objections?

Matt Porter made a very good comment the other day that must not get
lost.  Any of the software we have available here should be useful to
and able to be enhanced by others.  To me, it doesn't make sense to
have a large number of subdirectories and matrix of configuration options.
For all practical purposes, a "board" will define everything we need
to know about a configuration.  We can have a variety of implied
options from this point, but things like this need to evolve as we
gain experience.

I'm not objecting to changes, I just want to ensure we don't go 180
degrees off the deep end in the other direction :-).  Just look at
the mess we created with the "simple" piggyback loader reorganization
that is still in progress.

> Another thing I would like to do is to generalize the drivers for the
> various on-chip peripherals a bit more.

I don't understand what you mean.  There are the 8xx, 8260, and 405
peripherals.  The only reason the 8xx has it's own IO directory was
back in those days it was difficult to get any write access into
something outside of our architecture tree.  They are also unique to
that processor family, not useful for anyone else.  The only advantage
to having them in the drivers/* directory is to recognize functional
interface changes when they occur.


> The configuration scripts could force CONFIG_XYZZY on when this
> platform is selected and that would compile in the xyzzy driver.

Isn't that what happens today?  Selecting a configuraion option isn't
related to a directory structure unless you want to somehow automate
the Makefile processing and derive knowledge from the option itself.

> This would be a bit of work in the short term to implement but would
> mean that we could potentially reuse code more easily for new
> platforms.

Do you actually understand how the current embedded platforms work?
To implement a new 8xx or 8260 today takes me just a few hours.
Matt does something similar with PreP/CHRP cPCI platforms.  Don't
confuse the ability to quickly turn out a new platform port with
moving some files out of the kernel directory.  I don't notice the
clutter in the kernel directory because of the way files are named
and simply using wildcard on commands works pretty well :-).

> This could extend to things like interrupt controllers and PCI host
> bridges as well as regular I/O devices, too.

Don't get me started on interrupt controllers.......I've been complaining
about this for many years since I did the first 8xx port.  My changes
either get reverted or fscked up further upstream when someone decides
only part of what we do is generically useful :-).  I think we finally
have a pretty nice PCI bridge management that should be part of the
generic kernel.  Until Linux determines the design baseline isn't a PeeCee
we are stuck with a bunch of legacy crap that doesn't extend well into
flexible architectures like we use every day.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

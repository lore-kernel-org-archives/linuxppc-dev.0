From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 18 Nov 2003 10:37:11 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Juergen Kienhoefer <juergen@kienhoefer.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cache coherence problem
Message-ID: <20031118093711.GB3924@iram.es>
References: <3FB972E8.5090701@kienhoefer.com> <1069122238.7168.63.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1069122238.7168.63.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 18, 2003 at 02:02:28PM +1100, Benjamin Herrenschmidt wrote:
>
> On Tue, 2003-11-18 at 12:16, Juergen Kienhoefer wrote:
> > Guys,
> > Look at the folloging test program. It mmaps memory, puts some
> > instructions in it and executes it.
> > Sometimes it works, sometimes it crashes with illegal instruction.
> > This smells like cache problems.
> > Should the kernel clean the instruction cache for these addresses
> > in mmap system call?
> > Thanks for any thoughts!
> > Juergen
>
> It's your duty to ensure cache coherency. Actually, the kernel
> will eventually clean the icache for newly mapped in blank pages,

If you mean zeroed pages for blanked, I believe that it is wrong.
The reason being that 0 is an invalid instruction so that the code
would trap in any case.

Maybe I'm wrong, but I seem to remember this as an optimization
that Paulus implemented some time ago.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

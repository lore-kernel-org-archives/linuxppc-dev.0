Subject: Re: BriQ & Linux 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamie Heilman <jamie@audible.transient.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040522064520.GM8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net>
	 <1085181034.6755.7.camel@gaston>
	 <20040521233523.GJ8520@audible.transient.net>
	 <1085199239.9230.4.camel@gaston>
	 <20040522064520.GM8520@audible.transient.net>
Content-Type: text/plain
Message-Id: <1085209944.9234.7.camel@gaston>
Mime-Version: 1.0
Date: Sat, 22 May 2004 17:12:26 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-05-22 at 16:45, Jamie Heilman wrote:
> Benjamin Herrenschmidt wrote:
> >
> > Well... the base clock isn't what the driver thinks, so it must be
> > hacked. But the driver doesn't provide a clean way to set another
> > base clock, I'm trying to find something better than what the hack
> > in the patch does.
>
> Well progress so far, I have 2.6.6 booting now, had to fumble a little
> to apply one chunk but the rest was easy.  Problems so far: during the
> entire boot, my console is line-noise-like hash[1], until runlevel 2,
> then it starts behaving correctly.  The NICs (I have the PCI
> expansion + extra NIC board) are having some issues....

Linux console starts at 9600 while the briq firmware use a different
speed (I don't remember which). Try adding the speed ot the kernel
command line

console=ttyS0,<speed>

For example

console=ttyS0,38400

>           RX packets:118521 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:57244 dropped:0 overruns:0 carrier:57244
>
> ...and yet, strangly I don't seem to be having any obvious network
> performance problems.

Interesting. I keep seeing reports of problems with pcnet32 driver,
that's weird though.

> Now this isn't the first time I've had issues with either of those,
> and I think there are some patches in the Total Impact kernel source
> for the NIC issue.  So I'm definately a lot closer than I was.
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: hollis@austin.ibm.com
Date: Wed, 7 Nov 2001 16:01:49 -0600
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org, davidm@amberdata.demon.co.uk,
	Sven.Dickert@planb.de
Subject: Re: RFC: i8259.c cleanup
Message-ID: <20011107160149.A26707@austin.ibm.com>
References: <20011107110630.G9471@austin.ibm.com> <Pine.LNX.4.33.0111072015560.17428-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111072015560.17428-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 10:17:05PM +0100, Gabriel Paubert wrote:
>
> On Wed, 7 Nov 2001 hollis@austin.ibm.com wrote:
>
> > I laid out what I saw in
> > http://lists.linuxppc.org/linuxppc-workstation/200109/msg00030.html . I
> > could be wrong, but our code doesn't seem to match the datasheet very
> > well.
>
> Have you ever see code matching the datasheet, or a chip matching the
> datasheet for that matter ? :-)

To be honest I think I was wrong. Reading the 8259 datasheet yet again has
enlightened me as the the exact nature of "INTA" and polling. What I thought
were ISR/IRR reads were actually INTA's (returning the ISR in the process).

So the stock code is definately funny (there's no need at all to explicitly
switch between the ISR and IRR), but correct AFAICS. Which is unfortunate for
me... :/

I've changed it a little to avoid this ISR selection and it's more robust (I
can boot), but still falls over pretty easily. All routines are spin_lock()
protected though; I'm not sure what sort of timing problem I might look for.

> > Would you say poking the 8259 directly is more "right" than using
> > 0xbffffff0 (or equivalent)?
>
> Certainly not. Most ISA bridges (which are the part which contains the
> dual 8259 Pathetic Interrupt Controller), are tested in an x86
> environment, which generate PCI interrupt acknowledge cycles. So hitting
> hardware bugs is much less likely than with polling.

I'm worried this is my problem. I'm looking at the "Poll Command" section of
the 8259 docs, and i8259.c seems completely legit...

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12
Date: Tue, 16 Oct 2001 16:08:21 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <200110151533.f9FFXSY50083@aslan.scsiguy.com>
In-Reply-To: <200110151533.f9FFXSY50083@aslan.scsiguy.com>
MIME-Version: 1.0
Message-Id: <20011016200607.YCVX2701.tomts7-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I can confirm this for my machine.  It seems recompiling and changing
unrelated things does seem to impact the performance of the driver.

Since changing the memory footprint seems to impact the driver, I was
wondering about a few things:

- Is hardware "DMA" being used to swap in and out scb blocks of memory?
If so, are there scb memory "alignment" issues at work here when doing DMA?

- what about issues with locking when doing the DMA to prevent other reads
and or writes colliding?  Ben's trouble with SMP machines might be
indicative of something here?

- data cache flushing issues?

Is there any specific code we should focus on in the driver when trying to
figure this thing out?

Thanks,

Kevin

On October 15, 2001 11:33, Justin T. Gibbs wrote:
> >Today, I recompiled that same kernel, but with different drivers
> > built-in (nothing related to SCSI, but that did change the kernel size
> > and boot timing), I'm getting a  similar error as above (referenced
> > scb not valid) followed by a panic (using the 6.2.1 driver).
>
> Do you know if anything changed in the PCI code that might affect
> the initialization of PCI devices?  It is almost as if some of our
> PCI register writes are not being honored (e.g. prefetching has
> suddenly been enabled for this card even though the prefetch bit
> if off in all of its BARs).  6.2.1 has been in the kernel for some
> time and was not changed in going from .10 -> .12.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

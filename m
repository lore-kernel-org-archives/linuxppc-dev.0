In-Reply-To: <38BF4A07.3474B5FB@redhat.com>
Date: Fri, 3 Mar 2000 11:55:13 +0100
To: Doug Ledford <dledford@redhat.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Need reports about PCI I/O conflicts
Message-Id: <20000303115513.005167@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 3, 2000, Doug Ledford <dledford@redhat.com> wrote:

>The driver wants to see a valid IO region in the config registers or else it
>interprets the card as disabled.  It also wants to see a unique value on each
>card or else it interprets everything but the first instance as duplicates of
>the first and ignores them (certain PCI busses have resulted in devices being
>in the list multiple times, and certain BIOSes use setting the IO space to 0
>to signal a card that is disabled in the BIOS).  The driver already
knows that
>on PPC it needs to use MMAP I/O registers, so there isn't any hints needed
>from the OF, and those hints only complicate matters further when trying to
>keep the driver uniform across multiple architectures.  If this is going
to be
>an ongoing problem, then I can make changes to the driver, it just means
>having a few more #ifdef(__powerpc__) type stuff (ick).

In our case, I beleive we need to change the driver so that it ignores
the PIO addresses when they have not been assigned and there's a valid
MMIO address. I'll look at the driver again but I beleive the only place
where it can be a problem is the code that detects multiple instances of
the card. We can probably safely disable that code on all PPCs, or
eventually make it use MMIO when PIO are not available.

I'll see what I can do on my side but I don't have an Adaptec card to
test with.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

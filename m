In-Reply-To: <Pine.HPX.4.10.10002111949390.1866-100000@gra-ux1.iram.es>
Date: Sat, 12 Feb 2000 15:15:31 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: Latest OpenPic changes
Message-Id: <20000212151531.019320@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 11, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>There is some confusion right now in the openpic code, the places where
>we use vectors and the places where we use interrupt source numbers should
>be clarified, although we could also say that vector is always source+16
>to leave room for a cascaded 8259 pair just in case. Adding a global
>variable for this as it is right now seems overkill, not to say bloat.

The problem is that PowerMacs with openpic have vectors starting at 0. So
changing that would require fixup of both the PCI interrupts and OF
device tree.

>It should but you should wait for the read to finish when you mask the
>irq source, which is not obvious with longer pipelines and memory queues
>like the 7400. eieio does not guarantee this, isync neither, but I think
>that you can force isync to actually wait for the read by inserting some
>instruction which uses the read value.

But is it really necessary ? We do use the returned value of the read
since we loop. So we are safe. The only thing that could bite us is
eventual speculative accesses done just after the read, but since we have
eieio, we should be protected. isync would be necessary only if the code
itself is changed (or the MMU context), which is not the case.

>That's the point: actually a read followed by an isync is insufficient
>since it does not guarantee that the access is performed on the bus (and
>could still cause a machine check for example): the only thing it
>guarantees is that the translation is valid (context synchronization just
>in case you change a mapping or the MSR DR bit just after).

But since we _use_ the result from the read for the loop in my code, we
know that the read was actually done and the result fetched. We don't
care about cache since we are on non-cachable & guarded space. I think my
code without the mb() should be enough. I see no cases were we would use
disable_irq or enable_irq and change MSR_DR/IR just after, and the places
were we change them are usually protected with sync/isync already.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

In-Reply-To: <199903182331.KAA23199@tango.anu.edu.au>
Date: Fri, 19 Mar 1999 00:41:54 +0100
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Thoughts about DBDMA and cache coherency
Message-Id: <19990319004154.018461@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 19, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>No, what happens (on the 60x bus) is that the read is snooped by the
>cache controller, which asserts a `backoff and retry' signal.  The
>PCI bridge then terminates the transaction, the cache controller gets
>the 60x bus and writes the cache line out to memory, then the PCI
>bridge retries the read and gets the right data from memory.

Ok, thanks for the clarification.

>One small wrinkle is that for all this to work, the bridge has to
>assert the GBL (global) signal for all its accesses.  On some
>Starmaxes, we weren't getting the cache coherency maintained, but
>someone (Harry Eaton, from memory) found a bit to set in the bridge's
>configuration space which turned on the cache coherency - most likely
>this bit controlled whether the GBL signal was asserted or not.

I beleive MacOS can run without it (MacOS probably assumes cache coherency
is not here since it makes DMA space uncachable).

>> That would mean that we need to flush the range occupied by DBDMA
>> descriptors, but also any buffers used by DBDMA when outputing via a
>> DBDMA channel.
>
>Fortunately we don't need to, on PCI powermacs at least.  As I said,
>nubus powermacs are a whole 'nother can of worms, as are 68k macs.

Hum, asun will have fun making them work... and I too since I promised I would
help fixing head.S and kernel mappings...

>> Either I missed something big, either linux fails to do so and may have
>> unreliable writes to DBDMA devices all the time (looks like it would
>> crash a lot more often than it does, I must be wrong somewhere).
>
>It would crash a lot more often.  Things just basically wouldn't work.

Yep

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

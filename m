Date: Thu, 25 Mar 2004 16:48:46 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linas@austin.ibm.com
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040325154845.GF3696@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com> <20040324142524.GA22701@smtp.barco.com> <20040324110814.E50148@forte.austin.ibm.com>
Mime-Version: 1.0
In-Reply-To: <20040324110814.E50148@forte.austin.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Excuse my total ignorance on this topic, but ... is it possible that
> the DSP is using some sort of oddball bookmark mechanism to read the
> data?

Not at all, we're at the point that we appreciate external comments,
clues, ...
The DSP gets the PCI address, configures a DMA transfer and fetches the
data to some predefined memory location. There is not further
functionality (next to checking the counter in the memory for data
consistency purposes) because we want to verify and debug the technique.

> This would be a rather poor design decision on the part of whomever
> wrote the DSP code, but not out of the realms of impossible. (I've
> seen equally bizarre code in the past whose only excuse for existence
> was stupidity.) It could also be a bug in the DSP code. The fact
> that 'everything is OK after DSP acks' is telling: in the end, the
> DSP *did* do the right thing, by the time it ack'ed even if it did
> something weird while data was flying around.

The DSP code is fairly simple, but I would not put it past a DSP/Bios
bug, it has happened before (unfortunately). The annoying thing is that
we are not able to pinpoint a location where it is happening (on the DSP
or the PPC side). Next to this, I have a bit more confidence in the guy
writing the code than that :)

The only pattern we notice is that the first 8 words (32 bit words) are
fine, the following 24 words are not, the rest of the buffer is fine
(tested with buffers of 512, 1024, 2048 and 4096).

We did some further experimentation and the minimum of data we need to
read back after a DSP ACK is 97 bytes. You will note that 24*4=96. I
don't believe in coincidences :) If we read 96 bytes or less, we get the
corrupted data again... I even tested and tried to verify that the code
which is being used by the kernel is the one from the 2.4.17 mvl for
memory management and not 'tainted' code.

Anyway, this is a workaround until we have some more time to try to
figure out where the problem lies (PPC/PCI/Kernel/DSP) and what it is...
As ever, insights are welcome :-/

  marc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

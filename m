Date: Tue, 27 Mar 2001 18:54:41 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: "Michael R. Zucca" <mrz5149@acm.org>, phandel@cise.ufl.edu,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010327175442.839792F002@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 27, 2001, Takashi Oe wrote:
> On Tue, 27 Mar 2001, Iain Sandoe wrote:
>
>> >  while (write_sq.active > 0) {
>> >   ...
>> >   if ((stat & ACTIVE) == 0) {
>> >    if (cp == bus_to_virt(in_le32(&awacs_txdma->cmdptr)))
>>
>> this would not work on dmasound because it is possible to get interrupts
>> when blocks are still in progress without requiring error handling (e.g. a
>> dbdma FLUSH command).
>
> I agree that it doesn't help the PowerComputing problem, but I do think
> that just checking xfer_status is not very reliable on DBDMA.

Well, when I first started "looking after" the driver I though this too.

but... the status in the controller relates to the currently active dbdma
command (I believe - please correct me if you know better ;-).

When we get the IRQ for the command completion - a new chained cmd may (in
fact *should* if sound is not to have breaks)  have started.

Therefore we *must* look at the stored result - because the one in the chip
doesn't have any relationship to the IRQ we are handling.

The same would apply to *any* dbdma work that involved chained commands
AFAICT.

>> we need to detect "DEAD" status for the PowerComputing problem.
>
> Ok, ok, this is a totally different problem then.  In the case of bmac,
> the packet had been transmitted without an error, and DBDMA had moved on
> to subsequent commands (if any).  It's just that "xfer_status" field was
> not written out by DBDMA for some reason.  I have seen similar phenomenun
> on Plan B DBDMA implementation, so I wasn't too surprised to see that on
> bmac.

yes, this is different - but that's also interesting to note in case
something like it occurs elsewhere.

> Now, I see that awacs driver never checks DBDMA controller's status, and
> that can't be good..

see comments above.

>I wonder why the sound problem doesn't occur under Mac OS, or does it?

MacOS had the problem and PowerComputing released an "extension" that fixes
it (PCI timing bug fix-up).  It's still on the Apple support site (I
downloaded it recently).

I haven't got around to "looking at" the extension code to see if we can
plumb it into PPC linux.

>I suppose you could use TB or something and
> recalculate how many bytes out of residual to send to mostly stay in sync.

Well, if we get horrendous IRQ hold-offs then maybe - but at the moment I
think that the residue information stored in the dbdma command buffer will
do.

Otherwise we are starting to make quite a complicated solution for a problem
that can probably be fixed by rev. engineering the MacOS extension.

>> I've got as fix coded which uses an 'emergency' dbdma block to retry the
>> command (but with adjusted pointers and count to reflect what is left).
>
> Is it not possible to "fix" the command in place and let DBDMA go?

That was my original idea too... but...

It gets messy to do that - because the buffer start addresses are assigned
in XXXX_dbdma_setup()

- I don't want to have to re-assign them every single time we do a
read/write (on the off-chance that one of them may have been bumped to cope
with an error).

a spare dbdma command block costs 16 bytes of memory.  I think this is
cheaper than the space for the code to cope with doing another way.

ciao,

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

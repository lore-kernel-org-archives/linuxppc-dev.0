Message-Id: <200003240701.IAA00309@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 08:01:28 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Synchronous SCSI at 10MB/s on Lombard? (fwd)
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38DA6E1D.F4F25255@execpc.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  23 Mar, this message from Joseph Garcia echoed through cyberspace:
> Derek Homeier wrote:
>> I didn't know you could set it at some speed in between - I rather thought
>> these were basically two different settings, with 5 or 10 MB/s being the
>> nominal transfer rate, and actual transfer rating below that. According

That's my understanding as well. The 5MB/s or 10 MB/s is the raw byte
througput of the SCSI bus; for net rate, you have to count driver
overhead, command overhead, idle times on the bus, disk slowness, etc...

>> to dmesg my Orb drive is found and communicated at 10MB/s, thus the 6.6
> ...
>> that you shouldn't mix HDs and CDROMs, scanners etc. on one chain, the
>> latter seem to tend to have worse SCSI implementation.
>
> Thats interesting.  I will have to try that some time.  Right now, my chain has
> the CDRW after the Syquest, and I never figured in the potential sync problems.

On my 7600's internal MESH, I had both hard drives (sync at 10MB/s) and
the factory-installed CDROM (sync at 5MB/s) and never had any
particular problem. SCSI host adapters do negotiate separate parameters
per target; that's how you can mix narrow and wide devices on one bus,
by the way.

> However, I recall one of my friends mentioning that 10M/s should not be possible
> because the compact connector on powerbooks is missing those extra 12 or so pins
> needed.  Maybe the Orb is reporting 10, but falling back or compensating for the
> lack of pins.  Or maybe connectors have changed.  My chain's Syquest has a
> Centronix connector, my RW has a 50 pin mini-trapezoid.  Could explain some
> things.  Whatever works i guess.

No, no, there's nothing with pin count involved here. Macs have always
had narrow buses (i.e. 8bits wide), and the difference in pin count of
the connector is compensated by having different numbers of ground
pins. On good cable material, this should have no influence on
throughput.

On  23 Mar, this message from Dan Bethe echoed through cyberspace:
> 	I second the question.  And what does "safe" mean?  Could these
> aggressive settings damage your data, your hardware, or both?  If it's
> just data, then that's okay for me to try.  I'll turn it off when I
> find corrupted data.

Setting the speed too high might corrupt data, but will never damage
hardware. As stated above, host and target negotiate a compatible set
of settings; this should already guarantee valid data transfers. The
reason Apple states 5MB/s as limit for external buses is to depend less
on the quality of the cables involved, and to permit longer chains
conneting many external devices. Think 'hassle-free plug&play'....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

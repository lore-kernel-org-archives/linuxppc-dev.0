Date: Sun, 4 Feb 2001 22:37:28 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>,
        LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
 dao mode
In-Reply-To: <14971.34502.222006.311092@diego.linuxcare.com.au>
Message-ID: <Pine.LNX.4.30.0102042212020.7438-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> As I said, it's been a while, and what I don't remember is whether the
> mesh gives you a phase mismatch interrupt if you tell it to receive
> data (do an IN operation) when the target also expects to receive data
> (i.e. do an OUT operation).  I have a vague idea that it might do so
> in PIO mode but not in DMA mode or something.  It's quite believable
> that the whole thing would lock up in this situation.

You probably check for this explicitly in PIO mode. Phase mismatch usually
happens if the target goes from data to message phase due to errors (I
haven't seen the MESH specs so I'm speculating here).

> The 53c94 is another story; I never found any decent documentation for
> it, I just had to work from the open firmware methods for it plus some
> other drivers which seemed to be for similar chips.  I got the
> mac53c94 driver to the stage where it seemed to work mostly but I
> never had the time and the motivation to stress-test it and to
> implement things like disconnect/reconnect.

Disconnect and reselect are implemented in the ESP driver which was used
as template for the 68k Mac 53C9x driver at one time. Maybe take a
page or two from these drivers to implement disconnect. That driver uses a
trick that might help avoiding the data direction lockup with MESH as
well: the chip is programmed for the whole arbitration/selection/command
phases but will interrupt right before data phase, at which point you
could check the data direction before setting up the DMA (assuming the
target asserts the data direction after seeing the command byte). One
additional interrupt taken. No additional overhead if you skip this step
for some well known commands like WRITE_* and READ_* :-)

> > 3)	It continues to be worrisome that the mesh driver doesn't handle
> > aborts right or retry lost arbitration (nor does mac53c94.)  Is there
> > anywhere that the way to do these things is documented?  I'm willing to
> > try my hand at fixing them.
>
> I was never sure exactly how the higher levels of the scsi code
> expected the host adaptor drivers (like mesh.c) to do aborts.  At the

The main pitfall used to be that active and disonnected commands needed
to be removed  from the host adapter queue on a bus or host reset, and
their completion routine had to be called to terminate the command with
error (thereby stopping the midlevel timeout).
Plain command aborts are tricky because you need to act differently for
commands that are in the process of being sent to the device,
disconnected, or actively transfering data (removing commands from the
host queue that haven't been issued yet is rather trivial). The easiest
course of action (read: cop-out) for a command that's being issued or
transfering data is to reset the bus.

The new SCSI error handling code was/is supposed to simplify all of this,
I just never got around to figuring out how it works. If someone could
point me to a SCSI errorhandling HOWTO that'd be much appreciated.

	Michael

P.S:: Daniel, I can send a copy of the SCSI-2 spec if you need it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

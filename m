Date: Fri, 11 Feb 2000 21:25:14 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Latest OpenPic changes
In-Reply-To: <20000211193808.018868@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002111949390.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 11 Feb 2000, Benjamin Herrenschmidt wrote:

> I implemented it in both enable and disable for "correctness" so that the
> status of the controller is guaranteed when exiting any of those 2
> functions. I agree that the unmask case may not be important.

Well, try and report. In my case I have never seen a spurious interrupt
but the OpenPIC is inside the host bridge, which means that the accesses
do not necessarily have to wait for the PCI bus to be free. But in the
enable case it should not matter.

There is some confusion right now in the openpic code, the places where
we use vectors and the places where we use interrupt source numbers should
be clarified, although we could also say that vector is always source+16
to leave room for a cascaded 8259 pair just in case. Adding a global
variable for this as it is right now seems overkill, not to say bloat.

> I beleive the sync here can also be completely removed too. A single
> eieio is plenty enough because of the read. Isn't it ?

It should but you should wait for the read to finish when you mask the
irq source, which is not obvious with longer pipelines and memory queues
like the 7400. eieio does not guarantee this, isync neither, but I think
that you can force isync to actually wait for the read by inserting some
instruction which uses the read value.

Actually what I have now in my tree is an additioonal function called
openpic_flush(register) which is a poor name admittedly and
openpic_disable_irq does the following:

void openpic_disable_irq(u_int irq)
{
	check_arg_irq(irq);
	openpic_setfield(&ISU[irq - open_pic_irq_offset].Vector_Priority,
			 OPENPIC_MASK);
	/* make sure mask gets to controller before we return to user */
	openpic_flush(&ISU[irq - open_pic_irq_offset].Vector_Priority);
}

and openpic_flush  is:

static void inline openpic_flush(volatile u_int *addr)
{
	unsigned junk;
	asm __volatile__ ("lwz%U1%X1 %0,%1; twllti %0,0; isync" :
			  "=r" (junk) : "m" (*addr));
}

Some background on why I was experimenting with this from the programming
environment manual:

4.1.5.1 Context Synchronizing Instructions

The System Call (sc), Return from Interrupt (rfi), Return from Interrupt
Double Word (rfid), and Instruction Synchronize (isync) instructions
perform context synchronization by allowing previously issued instructions
to complete before performing a context switch. Execution of one of these
instructions ensures the following:

1. No higher priority exception exists (sc) and instruction dispatching is
halted.

2. All previous instructions have completed to a point where they can no
longer cause an exception. [...]
^^^^^^^^^^^^^^^^^^^^^^^^^

That's the point: actually a read followed by an isync is insufficient
since it does not guarantee that the access is performed on the bus (and
could still cause a machine check for example): the only thing it
guarantees is that the translation is valid (context synchronization just
in case you change a mapping or the MSR DR bit just after).

Then the conditional trap uses the result of the load (and actually never
traps since I check for unsigned less than zero ;-)), but it has to wait
for the memory access to be performed before the instructions past the
isync can be (re-)fetched and initiated because it has to determine
whether the connditional trap will actually cause an exception or not.

I consider higly unlikely the chip designers add a short circuit for this
special (apparently useless) conditional trap case since any compiler
should remove such a check in the first place :-). But if they would a
slightly more complex trick would force the check to be performed anyhow.

There is still something wrong in the boot logs:
Memory: 30420k available (196k kernel code, 168k data, 44k init)
                          ^^^
and [root@vdevel linux-test]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  31338496 26034176  5304320  5382144        0 19341312
Swap:        0        0        0
MemTotal:     30604 kB
MemFree:       5180 kB
MemShared:     5256 kB
Buffers:          0 kB
Cached:       18888 kB
HighTotal: 100533296 kB
HighFree:  101974016 kB
LowTotal:  4194464604 kB
LowFree:   4192998460 kB
SwapTotal:        0 kB
SwapFree:         0 kB

but it does not seem to harm (I checked twice and no, I don't have 4 Tb of
RAM).

I've just recompiled the whole 2.3.43 on an NFSRooted machine running with
this interrupt handling and it works fine right now. See how long it
lasts, oh and I can't load any module (perhaps I have to upgrade my
modutils).

	Regards,
	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

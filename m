Message-Id: <4.2.2.20000303150650.00a6a100@mail.kerbango.com>
Date: Fri, 03 Mar 2000 15:22:53 -0800
To: Dan Malek <dan@netx4.com>
From: Steve Calfee <calfee@kerbango.com>
Subject: Re: commproc.c
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <38BE953F.5CA6C079@netx4.com>
References: <4.2.2.20000302111129.00a638d0@mail.kerbango.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:22 AM 3/2/00 -0500, Dan Malek wrote:
>Steve Calfee wrote:
>
> > I have been working on doing a 823 USB driver.
>
>
>I find it interesting there is a sudden interest in the 8xx USB
>interface.......
>
>I recently hired someone to do this work for a customer.  We have
>slave working fine, and host mostly works (some hubs give us fits).
>The goal is an isochronous connection for some device to stream
>data over a variety of communication links (it's an 850).

Yeah, slave is easy, host is hard. Does 850 have host usb built in or are
you using an external host chipset? I am using the 823 with its built in
support.

 > m8xx_cpm_dpalloc(uint size)

> > This is a primitive routine to allocate CPM memory. It allocates size bytes
> > of CPM memory. Even a good citizen that lives by the CPM imposed
> > constraints of alignment
>
>
>I had some pretty bad hacks for ATM interfaces due to its alignment
>restrictions, and have since added a second parameter to define alignment.
>I have played with masks and byte counts, one will win.  This will
>be in an upcoming patch.
>
>
> > .... We also need a m8xx_cpm_free() function to give back CPM
> > memory when we are done.
>
>
>For lack of a better thought, I have resurrected the old *NIX resource
>map allocator.  Seems to work.
>

Great, that will be useful.


> > .... I agree that it is a rare use,
>
>It's not only rare, but I don't see any use for it.
>
>
> > .... but if I want to
> > backtrace the interrupted stack from my interrupt routine for profiling...
>
>
>You have to explain this one to me.  I don't understand how passing
>the register set pointer has any effect on this operation.
>
>Show me you need it and we can add it as a parameter.  There aren't
>that many places to change the code.  I just didn't need it, and due
>to your rant about interrupt overhead why add something not needed?
>

Sorry, didn't mean to rant, only suggest how to get 90% of the use of
rtLinux with 10% of the effort.

The profiling use was for someone who wanted to sample where his app was
running say every 500 microseconds or every ms or... So you need the
registers to extract the PC where the application was interrupted. Then
over a "long" period of time you can tell where the program is spending its
time. For my use, I hacked in a store of the regs to an external variable
in the commproc.c interrupt routine. Then my timer interrupt routine would
dump the pc where the interrupts were reenabled. Most of the addresses were
in the STI() or restoreregs routines, but it did point to a possible
culprit in the NFS system where ints were off a long time. Ultimately I
gave up, I didn't want to change code I didn't fully understand....

Passing the regs parameter on to CPM interrupt routines shouldn't add much,
if any, overhead, the parameter is already in a register when the
cpm_interrupt routine is called, so just passing it on to vectored
interrupt routines is all that is required.

Regards, Steve

Steve Calfee	--	embedded systems consultant
calfee@home.com
Kerbango phone: (408) 517-3355
home office ph: (510) 657-6039


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

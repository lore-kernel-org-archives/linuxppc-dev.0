From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul White <pwhite@bivio.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC7455
Date: Wed, 6 Mar 2002 20:46:35 +0100
Message-Id: <20020306194635.11178@smtp.wanadoo.fr>
In-Reply-To: 
 <Pine.LNX.4.21.0203052248340.25466-100000@stimpy.networkrobots.com>
References: 
 <Pine.LNX.4.21.0203052248340.25466-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hello!
>
>I've read through the archives of the linuxppc-dev and linuxppc-embedded
>mailing lists, and didn't see very much information regarding Linux on
>the Motorolai MPC 7455.
>
>I've checked the latest base kernel from kernel.org, 2.4.18, and there
>is no 7455 support. I've already done the code to bring Linux up on the
>7455, adding it to arch/ppc/kernel/cputable.c, as well as writing a new
>setup_cpu_7455, and a new setup_7455_regs function which sets up the
>HID0, HID1, and MSSCR0 registers. I am wondering if anyone is interested
>in these changes.

Please, send them to me. I have some 7455 support in my rsync tree
that I am about to push to bk. However, some of the registers, like
HID1 or MSSCR0, I consider have to be setup by the firmware or by
machine specific code.

>In one of the e-mails in the archives, it was suggested to have Linux
>configure the 7455 just the same as the 7450, however this will not
>work properly.  HID0 has changed quite a bit, as well as HID1, thus
>requiring a new setup routine.  It looks as though the 7451 and 7455
>are very similar, and the same init code and restrictions apply, however
>between the 7450 and 7451, things have changed quite a bit.
>
>If there is no support out there as of yet, I can create a patch file
>and send it off, if anyone is interested.
>
>One thing we ran into regarding the MPC7455, however, is that
>it does not guarentee Stores before Loads, meaning if you have
>code that has:
>
>Load Instruction
>Load Instruction
> - This is OK, they will happen in order as long as its Guarded
>
>Store Instruction
>Store Instruction
> - This is OK, they will happen in order as long as its Guarded
>
>Load Instruction
>Store Instruction
> - This is OK, they will happen in order as long as its Guarded
>
>Store Instruction
>Load Instruction
> - This is not guarenteed in order, even if its Guarded

Ah ? I missed that in the doc. It's pretty bad though so far, all
drivers are supposed to eieio on any IO access anyway.

>We had to add an eieio to all of our drivers, such as our PCI
>driver, which requires a write to one register before reading another.
>The eieio must go between the store and the load.

eieio is done within common IO macros like readl/writel, in/out_le/beXX
etc...

>Just a heads up, if no one has tried the 7455 yet!  Let me know
>if anyone is interested in the 7455 changes I've done.

My current tree boots and appear to work on Apple dual G4 1Ghz which is
7455 based.

I'm still interested in your patches as I may have missed something.

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 7 Mar 2002 10:24:40 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul White <pwhite@bivio.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC7455
In-Reply-To: <20020306194635.11178@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0203070958590.19754-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Mar 2002, Benjamin Herrenschmidt wrote:

>
> >
> >Hello!
> >
> >I've read through the archives of the linuxppc-dev and linuxppc-embedded
> >mailing lists, and didn't see very much information regarding Linux on
> >the Motorolai MPC 7455.
> >
> >I've checked the latest base kernel from kernel.org, 2.4.18, and there
> >is no 7455 support. I've already done the code to bring Linux up on the
> >7455, adding it to arch/ppc/kernel/cputable.c, as well as writing a new
> >setup_cpu_7455, and a new setup_7455_regs function which sets up the
> >HID0, HID1, and MSSCR0 registers. I am wondering if anyone is interested
> >in these changes.
>
> Please, send them to me. I have some 7455 support in my rsync tree
> that I am about to push to bk. However, some of the registers, like
> HID1 or MSSCR0, I consider have to be setup by the firmware or by
> machine specific code.
>
> >In one of the e-mails in the archives, it was suggested to have Linux
> >configure the 7455 just the same as the 7450, however this will not
> >work properly.  HID0 has changed quite a bit, as well as HID1, thus
> >requiring a new setup routine.  It looks as though the 7451 and 7455
> >are very similar, and the same init code and restrictions apply, however
> >between the 7450 and 7451, things have changed quite a bit.
> >
> >If there is no support out there as of yet, I can create a patch file
> >and send it off, if anyone is interested.
> >
> >One thing we ran into regarding the MPC7455, however, is that
> >it does not guarentee Stores before Loads, meaning if you have
> >code that has:
> >
> >Load Instruction
> >Load Instruction
> > - This is OK, they will happen in order as long as its Guarded
> >
> >Store Instruction
> >Store Instruction
> > - This is OK, they will happen in order as long as its Guarded
> >
> >Load Instruction
> >Store Instruction
> > - This is OK, they will happen in order as long as its Guarded

I have never seen any processor making a store bypass a load. thta's
obvious for performance reasons.

> >
> >Store Instruction
> >Load Instruction
> > - This is not guarenteed in order, even if its Guarded
>
> Ah ? I missed that in the doc. It's pretty bad though so far, all
> drivers are supposed to eieio on any IO access anyway.

It was always the case, starting with 603 at least. In this case it is
only guaranteed to be in order if the store and load addresses are the
same. The 601 did not have the guarded bit so it's different...

Guarded means only that it won't reordered to a point where the access
becomes speculative, i.e., an intruction before that access could
generate an internal exception (machine checks are another story).

I saw this kind of behaviour in a VME driver on a 603e. That's because I
defined the vme_{read,write}{8,16,32} not to do an eieio and defined
explicit ordering barriers: read after write is vme_raw_barrier, but there
is no need for vme_war_barrier (world peace is on its way :-)).

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

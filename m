Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Paul White <pwhite@bivio.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455
Date: Wed, 6 Mar 2002 17:18:59 -0500
References: <Pine.LNX.4.21.0203052248340.25466-100000@stimpy.networkrobots.com>
In-Reply-To: <Pine.LNX.4.21.0203052248340.25466-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Message-Id: <20020306222402.NQN7616.tomts7-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I've checked the latest base kernel from kernel.org, 2.4.18, and there
> is no 7455 support. I've already done the code to bring Linux up on the
> 7455, adding it to arch/ppc/kernel/cputable.c, as well as writing a new
> setup_cpu_7455, and a new setup_7455_regs function which sets up the
> HID0, HID1, and MSSCR0 registers. I am wondering if anyone is interested
> in these changes.


Yes, I am.

> In one of the e-mails in the archives, it was suggested to have Linux
> configure the 7455 just the same as the 7450, however this will not
> work properly.  HID0 has changed quite a bit, as well as HID1, thus
> requiring a new setup routine.  It looks as though the 7451 and 7455
> are very similar, and the same init code and restrictions apply, however
> between the 7450 and 7451, things have changed quite a bit.


Hmm, that's funny. My Dual 1 Gig G4 machine (7455) runs quite well (so
far) with using the 7450 setup for the HID registers after adding the
entries for detecting the 7455.  The bits that changed in HID0 are not
played with in the 7450 setup so it should be okay (it seems to be
working) shouldn't it?

> If there is no support out there as of yet, I can create a patch file
> and send it off, if anyone is interested.


Yes I would very much like to see it.


> One thing we ran into regarding the MPC7455, however, is that
> it does not guarentee Stores before Loads, meaning if you have
> code that has:
>
> Load Instruction
> Load Instruction
>  - This is OK, they will happen in order as long as its Guarded
>
> Store Instruction
> Store Instruction
>  - This is OK, they will happen in order as long as its Guarded
>
> Load Instruction
> Store Instruction
>  - This is OK, they will happen in order as long as its Guarded
>
> Store Instruction
> Load Instruction
>  - This is not guarenteed in order, even if its Guarded
>
> We had to add an eieio to all of our drivers, such as our PCI
> driver, which requires a write to one register before reading another.
> The eieio must go between the store and the load.
>
> Just a heads up, if no one has tried the 7455 yet!  Let me know
> if anyone is interested in the 7455 changes I've done.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

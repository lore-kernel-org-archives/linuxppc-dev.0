Message-Id: <v04003a00b3e9f623e46f@[216.81.27.143]>
In-Reply-To: <19990825122335.016707@mail.mipsys.com>
References: <v04003a00b3e8b6cc63fe@[216.81.20.86]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 25 Aug 1999 14:59:54 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: Performa 5200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:23 AM -0500 8/25/99, Benjamin Herrenschmidt wrote:
>On Tue, Aug 24, 1999, Tony Mantler <eek@escape.ca> wrote:
>
>>(2.1.12? I assume that's 2.3.12?)
>
>Sorry for the typo, it's actually 2.2.12, I don't know if all this was
>already included in the 2.3.x tree.

Ah, ok. I'm on a 28.8 here, so I'm trying to avoid downloading too many
kernels.


[...]
>all the x100 machines have address maps that depends on the population of
>the RAM slots. Also, some of them have a DRAM-based frame buffer working
>at a fixed physical address which can be either 0 or 1Mb.
>BootX will load the kernel in the first contiguous region in memory it
>can find, but that means that we have to copy the exception vectors to 0,
>adjust them so they call correctly the kernel routines in the real base
>of the kernel (which will not be 0 on some machines), and we'll have
>virt_to_phys and co be non-constant. I read an interesting suggestion
>some time ago of reserving a register during kernel compile with gcc and
>using this register to store the real base of the kernel. Modules will
>not be compatible, but that's not a real issue for now.
>I don't know how the APUS code works, but I heard it is similar.

Yeek. Sounds like a messed up version of RBV (IIsi). On that particular
machine (iirc), the start of real useable ram, where the kernel is located,
is remapped down to 0x0, and the framebuffer is mapped way up into (I
think) slot $9 regular space to mimic the configuration of the slightly
more sane macs.


>Also, we'll have to handle cache incoherency of DMA, and so on, but if
>you manage to get the basic work done, I'll be able to help writing
>driver (if I manage to get one of those machines, which is not sure).

I know the '040 maintains consistiency during the operation of alternate
bus masters by snooping and spiking the bus according to what's in the
cache. I haven't read up on how the PPC does it, but I would have expected
it to be made code-level compatible with what the 040 does, atleast in
these early PMacs.


>>I'm starting to think that I should carve out a new machine class in the
>>config options (#ifdef CONFIG_WUSSY_68K_PMAC?) ;)
>
>Or simply CONFIG_NUBUS_PMAC... BootX will tell you if you are running on
>one of those and will tell you if it's a PDM based (x100), performa or
>powerbook (5300/1400). It will also give you the gestalt machineID and
>the phys. memory map table. If you need more infos, tell me, but I
>beleive most of the other infos will have to be hard coded.

Or something like that.

Penguin collects a pile of LM globals and passes them in the bi struct, but
most of those can be implied from the gestalt machine ID. Considering the
number of NuBus PMacs, I don't think it would be terribly difficult to
guess anything that's not passed in explicitly.

But, I shan't pay any note of it 'till *after* I get a kernel to boot. :)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-ID: <39458490.234545FC@embeddededge.com>
Date: Mon, 12 Jun 2000 20:47:12 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Lucinda Schafer <lucsch@adaptivemicro.com>
CC: Dan Malek <dan@netx4.com>, Wolfgang Denk <wd@denx.de>,
        "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Kernel Panic
References: <A109131318C4D1119AC20060088DECE330F37A@amwmail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lucinda Schafer wrote:
>
> Thanks for answering so promptly.

Enjoy it when you can, it doesn't always happen that way :-).

> We are using the mpc8xx-2.2.13 Kernel ......

You may want to try taking the entire CDK from the MontaVista FTP
server.  It is pretty nice to have a complete set of tools, kernel,
applications, filesystem that has seen QA and doesn't need patches
taken from the Internet.

> ..... Some boards do seem more likely than others to
> panic.

Some QA people would interpret this as hardware DVT failure.  Manufacturing
variations trigger borderline design decisions.

> ........ I have a special application program
> that will run automatically at bootup and shut the processor power down for
> a minute, powerup, and then have the reboot sequence starts over again.


A minute isn't very long.  If you suspect temperature related problems
put these things in an environmental chamber using temperature cycles
that actually affect operation.

> This seems to be a boot related problem,....
> ..... If it works once, it will
> not panic on this particular bootup ever.

So, are these identical systems?  Same processor silicon, same memory
devices, same lot of boards, same boot rom?  Are you properly initializing
the processor cache/mmu/debug registers from power up?

> Wolfgang's suggestion makes a lot of sense to me:
> "Usually this means that you are running on an old  mask  revision  of
> the  CPU,  which  still  has  the  (in)famous  "Cache Corruption When
> Writing to Special Registers" bug."

I believe that only affected some 860(T) processors.  I don't remember
that listed for any other processor model or silicon.


> ....software emulation exception with PR=0 if there is a bus error
> (why should there be a bus error?? this isn't answered),

There are lots of SPRs listed for PowerPC cores that the MPC8xx family
doesn't support (or need).  If you have some generic software that
would access these, you have to emulate the function in software.  There
isn't any Linux software that would access SPRs that don't exist.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

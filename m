Date: Tue, 26 Jun 2001 15:13:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
Message-ID: <20010626151346.F31231@opus.bloom.county>
References: <20010626121003.D31231@opus.bloom.county> <20010626205147.26310@smtp.wanadoo.fr> <20010626162913.3dc483d8.toe@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010626162913.3dc483d8.toe@unlserve.unl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 26, 2001 at 04:29:13PM -0500, Takashi Oe wrote:

> BootX support on your rsync tree and linuxppc_2_4_devel tree is
> broken.  I guess no one with BootX bothered to try
> linuxppc_2_4_devel..

Does this work as well?
        /* if we didn't get any bootinfo telling us what we are... */
        if ( _machine == 0 )
        {
                /* prep boot loader tells us if we're prep or not */
                if ( *(unsigned long *)(KERNELBASE) == (0xdeadc0de) )
                        _machine = _MACH_prep;
                else {
                        /* This must be called before intuit_machine_type */
                        if (boot_infos)
                                relocate_nodes();
                        /* If we aren't PReP, we can find out if we're Pmac
                         * or CHRP with this. */
                        intuit_machine_type();
                }
        }

?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

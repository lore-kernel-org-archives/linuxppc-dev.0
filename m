In-Reply-To: <Pine.LNX.4.10.10002291744130.4907-100000@opal.biophys.uni-duesseldorf.de>
Date: Tue, 29 Feb 2000 19:24:30 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
Message-Id: <20000229192430.018647@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 29, 2000, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>Fails to compile (drivers/char/n_tty.c uses asm/spinlock.h, should use
>linux/spinlock.h perhaps). After forcing it, it fails to boot on Lombard.
>The way it fails booting is a bit entertaining: using BootX 1.1.3, it will
>show a little more than half a page of messages (arch_exit or similar in
>the last), then starts drawing funny color fringes on the screen until I
>reset. Using BootX 1.2b3, it locks up after the first six or so lines of
>text (before getting to the early console output). 2.3.29 worked fine. Any
>ideas?

I think I know what's going on:

 - make sure setting the display BAT in arch/ppc/mm/init.c (MMU_Init) is
commented out, this is a hack and need some alignement tricks to work in
all cases. It should already be in #if 0/#endif

 - in arch/ppc/kernel/pmac_setup.c, comment out the content of the
function pmac_progress. (Or change pmac_init() so that it sets
ppc_md.progress to NULL, and set it to pmac_progress only pmac_setup_arch()).

The problem is that pmac_progress will try to print to the framebuffer at
a time where it's not mapped (MMU_Init).

I've hacked a fix which should be in the current bk tree.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 14 Dec 2001 13:02:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org, Dan Malek <dan@embeddededge.com>,
	paulus@samba.org
Subject: Re: 7450 bugs & fixes
Message-ID: <20011214200237.GL16904@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.21.0112030102320.582-100000@ltgp.iram.es> <20011214191920.4144@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011214191920.4144@smtp.adsl.oleane.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 14, 2001 at 08:19:20PM +0100, Benjamin Herrenschmidt wrote:

> >>  - errata 29: do we ever switch MSR:IR off via an mtmsr ? If yes, we
> >>    need to add a sync, but I don't think we do.
> >
> >No, because kernel is not mapped 1:1 to physical memory, doing this would
> >cause an implicit jump, which is prohibited by the architecture. Note that
> >it also solves erratum 37 (different symptom and bug, same cure).
>
> Yup. I just wanted to ask anyway ;) Maybe some early bootloaders do that.

Actually, I _think_ there's a possibility.  In
arch/ppc/boot/common/util.S we do:
        .globl  disable_6xx_mmu
disable_6xx_mmu:
        /* Establish default MSR value, exception prefix 0xFFF.
         * If necessary, this function must fix up the LR if we
         * return to a different address space once the MMU is
         * disabled.
         */
        li      r8,MSR_IP|MSR_FP
        mtmsr   r8

So we should probably throw a 'sync' at the end of that, yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

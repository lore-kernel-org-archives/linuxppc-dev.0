Date: Mon, 12 May 2003 10:41:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with parse_bootinfo on a Board with 2Mb of SRAM
Message-ID: <20030512174136.GA6571@ip68-0-152-218.tc.ph.cox.net>
References: <D96E2AFA0DF3D211B139009027454948034CBD21@helios.gnv.tcc.thomson-csf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D96E2AFA0DF3D211B139009027454948034CBD21@helios.gnv.tcc.thomson-csf.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 06, 2003 at 07:40:51PM +0200, Christophe.LINDHEIMER@fr.thalesgroup.com wrote:

> I am trying to start Linux with a custom board.
> This board has only 2Mb of SRAM.
>
> Linux crashes in the function parse_bootinfo.
>
> In my Systemp.map I have got __bss_start == 0xc0091000
>
> In parse_bootinfo I have :
>
> rec = ( struct bi_record *)_Align((ulong)__bss_start+(1<<20)-1, 1<<20))
>
> So rec equals 0xc0200000
>
> and then
>
> if (rec->tag != BI_FIRST )
>
> but this line crashes because it tries to access 0xc0200000 whereas my sram
> is between 0xc0000000 and 0xc01fffff.

There's a few issues here.  First, in 2.4 we do the 'bad' thing of
making up a magic location where these bi_recs are, on the fly.  If you
don't mind making an incompatible change (i.e., you would need to change
arch/ppc/boot/* as well as arch/ppc/kernel/setup.c, and
arch/ppc/kernel/head.S), you can do what will be done for 2.5, which is
to allow the location of the bi_recs to be picked by whatever booted the
kernel, and passed along in a register.  So for your 2mb board, you
could pick say 0xc01880000 as where to put them.  Or wherever you want,
that will be not part of the BSS.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

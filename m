From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15607.36947.107412.219533@gargle.gargle.HOWL>
Date: Fri, 31 May 2002 10:01:39 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
In-Reply-To: <20020531145120.GI32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
	<20020531145120.GI32412@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini writes:
>
> On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:
>
> > Hello All,
> > I try to connect all my 64 Meg memoty on
> > Sandpoint-X3B,
> > but received a crash( with 32M all OK).
> > Source:
> > SP-X3B + Altimus MPC7410
> > HHL 2.0
> > Any ideas??
>
> DINK32 12.2 does not correctly initalize the memory controller on-board.
> DINK32 12.3 claims to do this correctly, but in some testing locally it
> still did not get everything correct.

Could you be more specific as to what is missing?

> There's a chance that PPCBoot does get this right, however.  But I'm no
> PPCBoot expert.

I don't know about the 74xx support in PPCBoot, but PPCBoot sets up
the 107 in a MCP8245 on a Sandpoint X3 well-enough to boot linux.
PPCboot does not, however, configure more than one 'bank' on the
SO-DIMM socket, and does not (currently) read the SPDs, if only for
the lack of proper I2C support (at least for the 824x).

YMMV.

My question is how have_of got set:

arch/ppc/mm/init.c:
        if (!have_of)
                FREESEC(openfirmware);

Otherwise...

On the whole "'reset/reboot' the system" thread, I'm interested in
similar solutions for the 824x, since I'm having highly similar
problems on reboot. :-)

Interestingly, the 'gorom' solution works fine for me, as long as my
root filesystem is not jffs2, then only if / is mounted 'rw'.

romfs, cramfs, nfs, or jffs2 (read-only) all reboot just fine.

--
"Perl is basically TECO-99."  ---Barry Shein


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

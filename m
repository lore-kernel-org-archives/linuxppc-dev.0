Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id EAFDDDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 20:18:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1177394147.6353.30.camel@Zeus.EmbLux>
Subject: Re: MPC885 hang in a lwarx/stwcx insn crossing a page boundary
Date: Tue, 24 Apr 2007 12:06:46 +0200
Message-ID: <1177409206.4388.57.camel@gentoo-jocke.transmode.se>
References: <1177394147.6353.30.camel@Zeus.EmbLux>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <hs@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 07:55 +0200, Heiko Schocher wrote:
> Hello,
>=20
> I have a MPC885 and a running 2.6.16 kernel on it. I use the CPU15
> Errata Patch from
> (http://ozlabs.org/pipermail/linuxppc-dev/2007-April/033789.html)
>=20
> Now if a lwarx/stwcx insn crossing a page boundary, the CPU hangs in
> an endless loop, because the reservation allocated from the lwarx gets
> cleared in the case of a tlb miss. And the CPU15 workaround =
invalidates
> the tlbs around the page we're faulting in, so we cause a nasty =
infinite
> loop. I started a service request at Freescale, and they are searching
> why a tlbie clears the reservation or under which circumstances this
> appears.
>=20
> Without the CPU15 Errata patch it runs fine, but i can reproduce the
> CPU15 Bug, so I need the or some CPU15 Errata patch ...
>=20
> I also have a running 2.4.24-pre2 Kernel on this board, with the same
> CPU15 Errata patch, and there the hang doesnt occur!! Some ideas where
> the differences between 2.4.24-pre2 and 2.6.16 are?
>=20
> I also didnt get this hang in userspace with the 2.6.16er Kernel.
>=20
> So I see at the moment the following possibilities:
>=20
> a) patching the gcc, so that the CPU15 Errata is no more necessary
>    My favorit.
>=20
> b) upgrade the CPU15 Bug like in the MPC885 Errata Sheet from =
Freescale
>    (I think this is to much code for in an Exceptionhandler ...)
>=20
> c) I made before every lwarcx a ".align" so that the insn is on one
>    page. This is actually running without seeing problems on the =
board.
>    But it is a "errata" for the "errata" ...
>=20
> d) ...
>=20
> Some suggestions, ideas? Especially, why the hang doesnt occur with a
> 2.4.24-pre2 kernel?

A guess:
The TLB Miss handler changed for the case when "Level 1 entry" is null.
2.6 will force a TLB Error to happen, but 2.4 will(at least used to)
bail out via DataAccess.

 Jocke

>=20
> thanks
> Heiko

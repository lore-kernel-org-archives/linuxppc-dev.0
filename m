Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id D5841679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 00:41:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel access of bad area, sig: 11 ( mpc852t)
Date: Wed, 19 Apr 2006 09:33:19 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85964B@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kenneth Poole" <kpoole@mrv.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When I was tracking down a timing problem on our SDRAM I found that
doing a native compile of glibc over NFS seems to be a very good memory
test.


> -----Original Message-----
> From: linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.or
> g] On Behalf Of Kenneth Poole
> Sent: Wednesday, April 19, 2006 07:59
> To: linuxppc-embedded@ozlabs.org
> Subject: kernel access of bad area, sig: 11 ( mpc852t)
>=20
>=20
> >>> Hi,
>=20
> >>> Im having problem porting linux kernel 2.4.21 to our=20
> mpc852T custom
>=20
> >>> board.The kernel
>=20
> >>> panics randomly with sig 11.
>=20
> >>> The board boots up fine and we also get to the=20
> prompt.When we open 3-4
>=20
> >>> telnet sessions
>=20
> >>> and try to run some command the kernel panics.This is completely
>=20
> >>> random.Sometimes it
>=20
> >>> even panics before opening the telnet session.
>=20
> >>>
>=20
>=20
> >>> <oops dump snipped>
>=20
> >>>
>=20
> >>You almost certainly have SDRAM problems.  If you have=20
> thoroughly checked
>=20
> >>out the
>=20
> >>complete address range statically, remember that burst=20
> accesses will not
>=20
> >>occur until the
>=20
> >>cache is turned on, so your problem may be with bursting. =20
> But you can also
>=20
> >>have severe
>=20
> >>problems like a missing address line and linux still run=20
> for a few seconds.
>=20
> >>
>=20
> >>Mark Chambers
>=20
> >We've checked the SDRAM. The timings (UPM) look fine. The problem
>=20
> >however is that linux does not hang until after a few processes are
>=20
> >started.
>=20
> >If we boot to linux and leave it as it is, everything is fine and the
>=20
> >board remains working. However each time a few processes (4-5 telnet
>=20
> >sessions for eg.) are started the system either panics or hangs (goes
>=20
> >dead).
>=20
> >Thanks in advance,
>=20
> >Akshay
>=20
> We have been experiencing this same issue with random boards=20
> in production. The exact same version of software will run=20
> for months on other instances of the exact same board design,=20
> but a few percent get 'random' trap 300s. When they do occur,=20
> it's only after Linux has booted and address translation and=20
> caching are turned on. Examining the oops-es and memory shows=20
> that some location in SDRAM has a bogus value, but I don't=20
> have the tools to trace back how it got that way.
>=20
> I have ported a rigorous moving-inversions memory test into=20
> our firmware, and have run it extensively across the entire=20
> SDRAM address space (the test code executes from flash). I=20
> have let this test run continuously for hours and hours, but=20
> never found a memory problem. Unfortunately, I do not have=20
> test software that enables the MMU address translation or=20
> caching, so as Mark said, I can't test memory using bursting.=20
> Our hardware engineers have reviewed the designs very=20
> carefully and are quite confident that there is plenty of=20
> margin in the memory timing. Signal quality has also been=20
> carefully checked.
>=20
> Our manufacturing people have replaced the CPU on some of=20
> these boards, and the problem went away.
>=20
> If anyone else on the mailing list has experienced this=20
> issue, or has developed a virtual address memory test, please=20
> let us know.
>=20
> Ken Poole
>=20
> =20
>=20
> =20
>=20
>=20

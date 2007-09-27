Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
	<46F9E67C.4070209@au1.ibm.com>
	<8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-33N9W05w46Pewp3/y/zS"
Date: Thu, 27 Sep 2007 12:48:30 +1000
Message-Id: <1190861310.6502.10.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Carlos Eduardo Seo <eduseo@br.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-33N9W05w46Pewp3/y/zS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-09-26 at 00:37 -0500, Kumar Gala wrote:
> On Sep 25, 2007, at 11:56 PM, Mark Nelson wrote:
>=20
> > Kumar Gala wrote:
> >>
> >> On Sep 25, 2007, at 8:22 PM, Mark Nelson wrote:
> >>
> >>> Kumar Gala wrote:
> >>>>
> >>>> On Sep 24, 2007, at 11:03 PM, Mark Nelson wrote:
> >>>>
> >>>>> Update dump_task_altivec() (that has so far never been put to use)
> >>>>> so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
> >>>>> and VRSAVE) in the same format as the ptrace get_vrregs() and add
> >>>>> the appropriate glue typedefs and #defines to
> >>>>> include/asm-powerpc/elf.h for it to work.
> >>>>
> >>>> Is there some way to tell if the core dump has altivec registers =20
> >>>> state
> >>>> in it?
> >>>>
> >>>> I'm wondering how we distinguish a core dump w/altivec state vs =20
> >>>> one with
> >>>> SPE state.
> >>>>
> >>>> - k
> >>>>
> >>>>
> >>>
> >>> If the core dump has the Altivec registers saved in there it will =20
> >>> have a
> >>> note called LINUX as shown below:
> >>>
> >>> $ readelf -n core
> >>>
> >>> Notes at offset 0x000002b4 with length 0x000005c8:
> >>>   Owner         Data size       Description
> >>>   CORE          0x0000010c      NT_PRSTATUS (prstatus structure)
> >>>   CORE          0x00000080      NT_PRPSINFO (prpsinfo structure)
> >>>   CORE          0x000000b0      NT_AUXV (auxiliary vector)
> >>>   CORE          0x00000108      NT_FPREGSET (floating point =20
> >>> registers)
> >>>   LINUX         0x00000220      NT_PRXFPREG (user_xfpregs structure)
> >>>
> >>> This mirrors what occurs with the SSE registers on i386 core =20
> >>> dumps in
> >>> order to keep things as similar as possible.
> >>>
> >>> I can't find any place where dump_spe() is called at the moment, =20
> >>> but I
> >>> suppose if it were to be hooked up in the future it could cause
> >>> confusion.
> >>> The Altivec register state in the core file is much larger than what
> >>> would be dumped by the current dump_spe(), but I'm not sure if that
> >>> matters...
> >>>
> >>> There's a patch for GDB that currently reads the contents of =20
> >>> these vector
> >>> registers from the core file, but it's being held until this =20
> >>> patch has
> >>> been commented on and/or approved of, so if it comes to it the =20
> >>> note name
> >>> could be changed to ALTIVEC (or something similar).
> >>
> >> I think we should NOT overload NT_PRXFPREG and add proper note types
> >> NT_ALTIVEC & NT_SPE for those register sets.
> >>
> >> Who on the GDB side would we need to coordinate such a change with?
> >>
> >> - k
> >>
> >
> > You're probably right :)
> >
> > What cores have SPE at the moment? Also, perhaps more importantly, =20
> > are there any plans to have Altivec and SPE in the same core?
>=20
> The e500 cores's from Freescale.
>=20
> No, they are pretty much mutually exclusive.
>=20
> > I've been working with Carlos Eduardo Seo (Cc'ed on this mail) on =20
> > the GDB side of this.
>=20
>  From comments it looks like the expectation is that the combination =20
> of note type and name which is expected to be unique.
>=20
> I'm wondering if we should handle this via =20
> elf_coredump_extra_notes_size() & elf_coredump_extra_notes_write().  =20
> Does GDB care about the order it sees the various sections in?

I don't think those callbacks will work in this case, they're only
called for the primary thread that's doing the coredump, not for each
thread. Perhaps there's a way to adapt it though.

I think the easiest solution for now is just to make the note type a
#define and create a new value for Altivec.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-33N9W05w46Pewp3/y/zS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+xn+dSjSd0sB4dIRAhDDAJ9quiMkgwwGByNkE97N8cU+wjgQewCdHtA+
HA8BsWX9z80k/tP0qmRJ3a4=
=3Bon
-----END PGP SIGNATURE-----

--=-33N9W05w46Pewp3/y/zS--

Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1D8E59FD-E8B1-446C-ABEE-D41F5496B518@kernel.crashing.org>
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
	<46F9B454.8010004@au1.ibm.com>
	<1B211071-5D55-4DBC-A109-7A66EC17A810@kernel.crashing.org>
	<46F9E67C.4070209@au1.ibm.com>
	<8FC0C4ED-3268-467C-A3EF-0336082062E1@kernel.crashing.org>
	<1190861310.6502.10.camel@concordia>
	<1D8E59FD-E8B1-446C-ABEE-D41F5496B518@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4WQKfHBZlLTDCbFXccJQ"
Date: Fri, 28 Sep 2007 09:54:34 +1000
Message-Id: <1190937274.18773.4.camel@concordia>
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


--=-4WQKfHBZlLTDCbFXccJQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-27 at 05:10 -0500, Kumar Gala wrote:
> >>> You're probably right :)
> >>>
> >>> What cores have SPE at the moment? Also, perhaps more importantly,
> >>> are there any plans to have Altivec and SPE in the same core?
> >>
> >> The e500 cores's from Freescale.
> >>
> >> No, they are pretty much mutually exclusive.
> >>
> >>> I've been working with Carlos Eduardo Seo (Cc'ed on this mail) on
> >>> the GDB side of this.
> >>
> >>  From comments it looks like the expectation is that the combination
> >> of note type and name which is expected to be unique.
> >>
> >> I'm wondering if we should handle this via
> >> elf_coredump_extra_notes_size() & elf_coredump_extra_notes_write().
> >> Does GDB care about the order it sees the various sections in?
> >
> > I don't think those callbacks will work in this case, they're only
> > called for the primary thread that's doing the coredump, not for each
> > thread. Perhaps there's a way to adapt it though.
> >
> > I think the easiest solution for now is just to make the note type a
> > #define and create a new value for Altivec.
>=20
> Oh, well.  It shouldn't be too difficult to abstract vector handler =20
> similar to how we do GPRs today to the core dump code.

I'm not sure I follow, you mean elf_core_copy_regs() ?

If so, that's basically what we've done, the problem is that as with
elf_core_copy_regs(), although the content is abstracted and overridden
by arch code, the note type is not. But making the vector note type
configurable seems easy enough.

eg:

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4482a06..7c8a145 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1624,7 +1624,7 @@ static int elf_core_dump(long signr, struct pt_regs *=
regs,
 #ifdef ELF_CORE_COPY_XFPREGS
        if (elf_core_copy_task_xfpregs(current, xfpu))
                fill_note(notes + numnote++,
-                         "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
+                         "LINUX", ELF_CORE_XFPREGS_TYPE, sizeof(*xfpu), xf=
pu);
 #endif=20
  =20
        fs =3D get_fs();


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-4WQKfHBZlLTDCbFXccJQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/EK6dSjSd0sB4dIRAqQ+AJ9T3Zs3IuP1HSl1OvrK9qdgVf4VEACfWXHP
rH0dZ83ceJizCkX2U4R0CrY=
=t2TY
-----END PGP SIGNATURE-----

--=-4WQKfHBZlLTDCbFXccJQ--

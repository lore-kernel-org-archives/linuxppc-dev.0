Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B31972C0339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 12:08:02 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kq13so8382583pab.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:07:59 -0700 (PDT)
Date: Fri, 12 Jul 2013 10:07:49 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
Message-ID: <20130712020749.GA32154@pek-khao-d1.corp.ad.wrs.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-3-git-send-email-haokexin@gmail.com>
 <1373546721.19894.90.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <1373546721.19894.90.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 10:45:21PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-11 at 20:21 +0800, Kevin Hao wrote:
> > Some cores (such as Freescale BookE) don't implement all floating
> > point instructions in ISA. But some gcc versions do use these
> > instructions. So we would have to enable the math emulation in this
> > case. Add this to emulated instructions tracking statistics so that
> > the user has a way to know that its toolcahin emit these unimplemented
> > floating point instructions.
>=20
> That patch is gross, it makes the function even more nasty than it
> already is. Besides, CONFIG_PPC_FPU doesn't mean you have a HW FPU,
> you need to check the CPU feature bits.
>=20
> Also the caller already does PPC_WARN_EMULATED, so this patch makes
> you call it twice or am I missing something ?

There are two invocations of do_mathemu() in the traps.c. The one in the
function program_check_exception() doesn't call the PPC_WARN_EMULATED.
This is also the one I try to fix. Of course my patch will definitely corru=
pt
the one in function SoftwareEmulation(). I will respin a new patch to
fix this. Sorry for my mistake.

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/math-emu/math.c | 50 +++++++++++++++++++++++++++---------=
--------
> >  1 file changed, 31 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
> > index 18ce6a7..9a98b6c 100644
> > --- a/arch/powerpc/math-emu/math.c
> > +++ b/arch/powerpc/math-emu/math.c
> > @@ -10,6 +10,7 @@
> > =20
> >  #include <asm/sfp-machine.h>
> >  #include <math-emu/double.h>
> > +#include <asm/emulated_ops.h>
> > =20
> >  #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
> > =20
> > @@ -222,10 +223,17 @@ do_mathemu(struct pt_regs *regs)
> >  	int idx =3D 0;
> >  	int (*func)(void *, void *, void *, void *);
> >  	int type =3D 0;
> > -	int eflag, trap;
> > +	int eflag, trap, ret =3D -ENOSYS;
> > +	int has_hw_fpu =3D 0;
> > =20
> > -	if (get_user(insn, (u32 *)pc))
> > -		return -EFAULT;
> > +#ifdef CONFIG_PPC_FPU
> > +	has_hw_fpu =3D 1;
> > +#endif
> > +
> > +	if (get_user(insn, (u32 *)pc)) {
> > +		ret =3D -EFAULT;
> > +		goto out;
> > +	}
> > =20
> >  	switch (insn >> 26) {
> >  	case LFS:	func =3D lfs;	type =3D D;	break;
> > @@ -249,7 +257,7 @@ do_mathemu(struct pt_regs *regs)
> >  		case STFDUX:	func =3D stfd;	type =3D XEU;	break;
> >  		case STFIWX:	func =3D stfiwx;	type =3D XE;	break;
> >  		default:
> > -			goto illegal;
> > +			goto out;
> >  		}
> >  		break;
> > =20
> > @@ -267,7 +275,7 @@ do_mathemu(struct pt_regs *regs)
> >  		case FNMSUBS:	func =3D fnmsubs;	type =3D ABC;	break;
> >  		case FNMADDS:	func =3D fnmadds;	type =3D ABC;	break;
> >  		default:
> > -			goto illegal;
> > +			goto out;
> >  		}
> >  		break;
> > =20
> > @@ -287,7 +295,7 @@ do_mathemu(struct pt_regs *regs)
> >  			case FNMSUB:	func =3D fnmsub;	type =3D ABC;	break;
> >  			case FNMADD:	func =3D fnmadd;	type =3D ABC;	break;
> >  			default:
> > -				goto illegal;
> > +				goto out;
> >  			}
> >  			break;
> >  		}
> > @@ -309,12 +317,12 @@ do_mathemu(struct pt_regs *regs)
> >  		case MFFS:	func =3D mffs;	type =3D X;	break;
> >  		case MTFSF:	func =3D mtfsf;	type =3D XFLB;	break;
> >  		default:
> > -			goto illegal;
> > +			goto out;
> >  		}
> >  		break;
> > =20
> >  	default:
> > -		goto illegal;
> > +		goto out;
> >  	}
> > =20
> >  	switch (type) {
> > @@ -347,7 +355,7 @@ do_mathemu(struct pt_regs *regs)
> >  	case DU:
> >  		idx =3D (insn >> 16) & 0x1f;
> >  		if (!idx)
> > -			goto illegal;
> > +			goto out;
> > =20
> >  		sdisp =3D (insn & 0xffff);
> >  		op0 =3D (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
> > @@ -375,7 +383,7 @@ do_mathemu(struct pt_regs *regs)
> >  			if (((insn >> 1) & 0x3ff) =3D=3D STFIWX)
> >  				op1 =3D (void *)(regs->gpr[(insn >> 11) & 0x1f]);
> >  			else
> > -				goto illegal;
> > +				goto out;
> >  		} else {
> >  			op1 =3D (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
> >  		}
> > @@ -417,7 +425,7 @@ do_mathemu(struct pt_regs *regs)
> >  		break;
> > =20
> >  	default:
> > -		goto illegal;
> > +		goto out;
> >  	}
> > =20
> >  	/*
> > @@ -425,9 +433,8 @@ do_mathemu(struct pt_regs *regs)
> >  	 * if flushed into the thread_struct before attempting
> >  	 * emulation
> >  	 */
> > -#ifdef CONFIG_PPC_FPU
> > -	flush_fp_to_thread(current);
> > -#endif
> > +	if (has_hw_fpu)
> > +		flush_fp_to_thread(current);
> > =20
> >  	eflag =3D func(op0, op1, op2, op3);
> > =20
> > @@ -437,8 +444,10 @@ do_mathemu(struct pt_regs *regs)
> >  	}
> > =20
> >  	trap =3D record_exception(regs, eflag);
> > -	if (trap)
> > -		return 1;
> > +	if (trap) {
> > +		ret =3D 1;
> > +		goto out;
> > +	}
> > =20
> >  	switch (type) {
> >  	case DU:
> > @@ -451,8 +460,11 @@ do_mathemu(struct pt_regs *regs)
> >  	}
> > =20
> >  	regs->nip +=3D 4;
> > -	return 0;
> > +	ret =3D 0;
> > +
> > +out:
> > +	if (has_hw_fpu && ret >=3D 0)
> > +		PPC_WARN_EMULATED(math, regs);
> > =20
> > -illegal:
> > -	return -ENOSYS;
> > +	return ret;
> >  }
>=20
>=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR32T1AAoJEJNY7TDerrFxmfcH/2FnQh/dGgJCnC+98xNMgC2R
jPG+UFlH8iCbGOt2pvO6Y8Rg6B/1t/blhaUx5NQkeAqgnRbzNmvcykACggPD9BUN
3evrYN2qzycZTZFTy3kRZoaFUyvrnfesb+APOcde9tvDziY1fzbCo6rjoMgy1sm6
3yl6LW2rGp6k1hENV7a8L5ivk6RYsqB8wDpJrjhd7rafZNOJMl/Rlsnpj6hWqDGC
ua5MtHS3P5sWt6oKVgPYyOYT3yXNcpuUAUCGPceaQNVfh0GC+Oa8TwJa7DM9N9fO
XHy/hJ9CoV6uGdpJBe8Ge92+KhxDaqiZNz1u6FfgWG1KSmJNa7evUAQ6NIoE+uY=
=G/bW
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

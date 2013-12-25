Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 35C3B2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 16:58:37 +1100 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so7009941pbb.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 21:58:34 -0800 (PST)
Date: Wed, 25 Dec 2013 13:58:25 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/3] powerpc: use the jump label for cpu_has_feature
Message-ID: <20131225055825.GC23962@pek-khao-d1.corp.ad.wrs.com>
References: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
 <1378100726-32545-3-git-send-email-haokexin@gmail.com>
 <1385520341.9218.89.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
In-Reply-To: <1385520341.9218.89.camel@pasglop>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 01:45:41PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2013-09-02 at 13:45 +0800, Kevin Hao wrote:
> > The cpu features are fixed once the probe of cpu features are done.
> > And the function cpu_has_feature() does be used in some hot path.
> > The checking of the cpu features for each time of invoking of
> > cpu_has_feature() seems suboptimal. This tries to reduce this
> > overhead of this check by using jump label. But we can only use
> > the jump label for this check only after the execution of
> > jump_label_init(), so we introduce another jump label to
> > still do the feature check by default before all the cpu
> > feature jump labels are initialized.
>=20
> So I was looking at these and ...

Sorry for the delayed response.

>=20
> > +static inline int cpu_has_feature(unsigned long feature)
> > +{
> > +	if (CPU_FTRS_ALWAYS & feature)
> > +		return 1;
> > +
> > +	if (!(CPU_FTRS_POSSIBLE | feature))
> > +		return 0;
> > +
> > +	if (static_key_false(&cpu_feat_keys_enabled)) {
> > +		int i =3D __builtin_ctzl(feature);
> > +
> > +		return static_key_false(&cpu_feat_keys[i]);
> > +	} else
> > +		return !!(cur_cpu_spec->cpu_features & feature);
> > +}
>=20
> This is gross :-)
>=20
> Have you checked the generated code ? I'm worried that we end up hitting
> at least 2 branches every time,

No, we would get 2 unconditional branches at worst. The following is the
disassemble of part code in switch_mm() when jump label is enabled.

   68         /* We must stop all altivec streams before changing the HW
   69          * context
   70          */
   71 #ifdef CONFIG_ALTIVEC
   72         if (cpu_has_feature(CPU_FTR_ALTIVEC))
   73                 asm volatile ("dssall");
   74 #endif /* CONFIG_ALTIVEC */
 =20
  c0000000005c42f4:       60 00 00 00     nop
  c0000000005c42f8:       3d 02 00 01     addis   r8,r2,1
  c0000000005c42fc:       39 28 f6 b8     addi    r9,r8,-2376
  c0000000005c4300:       e9 29 00 00     ld      r9,0(r9)
  c0000000005c4304:       e9 29 00 10     ld      r9,16(r9)
  c0000000005c4308:       79 2a ef e3     rldicl. r10,r9,61,63
  c0000000005c430c:       41 82 00 08     beq     c0000000005c4314 <.__sche=
dule+0x27c>
  c0000000005c4310:       7e 00 06 6c     dssall
  c0000000005c4314:       7f 43 d3 78     mr      r3,r26
  c0000000005c4318:       7f a4 eb 78     mr      r4,r29
  c0000000005c431c:       4b a5 ff 71     bl      c00000000002428c <.switch=
_mmu_context>
  c0000000005c4320:       60 00 00 00     nop
  ....
  c0000000005c4400:       60 00 00 00     nop
  c0000000005c4404:       7f 43 d3 78     mr      r3,r26
  c0000000005c4408:       7f a4 eb 78     mr      r4,r29
  c0000000005c440c:       4b a5 fe 81     bl      c00000000002428c <.switch=
_mmu_context>
  c0000000005c4410:       60 00 00 00     nop


On a p5020 board which doesn't support altivec, the code would change
to the following after jump label init.
  c0000000005c42f4: b c0000000005c4400

The final instruction sequence should be just a branch.

On a t4240 board which does have altivec support, the code would change to:

  c0000000005c42f4: b c0000000005c4400
  ...
  c0000000005c4400: b c0000000005c4310

The final instruction sequence should be two unconditional branches.


The following is the disassemble code when jump label is disabled.
  c0000000005c26fc:       60 00 00 00     nop
  c0000000005c2700:       3d 02 00 01     addis   r8,r2,1
  c0000000005c2704:       39 28 24 b8     addi    r9,r8,9400
  c0000000005c2708:       e9 29 00 00     ld      r9,0(r9)
  c0000000005c270c:       e9 29 00 10     ld      r9,16(r9)
  c0000000005c2710:       79 2a ef e3     rldicl. r10,r9,61,63
  c0000000005c2714:       40 82 00 d4     bne     c0000000005c27e8 <.__sche=
dule+0x360>
  c0000000005c2718:       7f 43 d3 78     mr      r3,r26
  c0000000005c271c:       7f a4 eb 78     mr      r4,r29
  c0000000005c2720:       4b a6 0a 75     bl      c000000000023194 <.switch=
_mmu_context>
  c0000000005c2724:       60 00 00 00     nop
  ....
  c0000000005c27e8:       7e 00 06 6c     dssall
  c0000000005c27ec:       4b ff ff 2c     b       c0000000005c2718 <.__sche=
dule+0x290>
  c0000000005c27f0:       e9 3e 00 00     ld      r9,0(r30)
  c0000000005c27f4:       71 2a 00 81     andi.   r10,r9,129
  c0000000005c27f8:       40 82 00 94     bne     c0000000005c288c <.__sche=
dule+0x404>


The final instruction sequence is following:
  addis   r8,r2,1
  addi    r9,r8,9400
  ld      r9,0(r9)
  ld      r9,16(r9)
  rldicl. r10,r9,61,63
  bne     c0000000005c27e8


> which might be enough to defeat the
> purposes even if they are unconditional in term of performance and
> code size...

It does result in an increase in the code size due to the enable of jump la=
bel.

before:
  .text		.data	=20
  005c4ff4	0005ede8

after:
  .text		.data
  005c6c04	0005fe68=09

Thanks,
Kevin
>=20
> Cheers,
> Ben.
>=20
> > +#else
> >  static inline int cpu_has_feature(unsigned long feature)
> >  {
> >  	return (CPU_FTRS_ALWAYS & feature) ||
> > @@ -10,5 +36,6 @@ static inline int cpu_has_feature(unsigned long featu=
re)
> >  		& cur_cpu_spec->cpu_features
> >  		& feature);
> >  }
> > +#endif
> > =20
> >  #endif /* __ASM_POWERPC_CPUFEATURE_H */
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputa=
ble.c
> > index 597d954..50bd216 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -21,6 +21,7 @@
> >  #include <asm/prom.h>		/* for PTRRELOC on ARCH=3Dppc */
> >  #include <asm/mmu.h>
> >  #include <asm/setup.h>
> > +#include <asm/cpufeatures.h>
> > =20
> >  struct cpu_spec* cur_cpu_spec =3D NULL;
> >  EXPORT_SYMBOL(cur_cpu_spec);
> > @@ -2258,3 +2259,25 @@ struct cpu_spec * __init identify_cpu(unsigned l=
ong offset, unsigned int pvr)
> > =20
> >  	return NULL;
> >  }
> > +
> > +#ifdef CONFIG_JUMP_LABEL
> > +struct static_key cpu_feat_keys[MAX_CPU_FEATURES];
> > +struct static_key cpu_feat_keys_enabled;
> > +
> > +static __init int cpu_eat_keys_init(void)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < MAX_CPU_FEATURES; i++) {
> > +		unsigned long f =3D 1 << i;
> > +
> > +		if (cur_cpu_spec->cpu_features & f)
> > +			static_key_slow_inc(&cpu_feat_keys[i]);
> > +	}
> > +
> > +	static_key_slow_inc(&cpu_feat_keys_enabled);
> > +
> > +	return 0;
> > +}
> > +early_initcall(cpu_feat_keys_init);
> > +#endif
>=20
>=20

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSunQBAAoJEJNY7TDerrFxB+cIAJW+iKHp4+JLfW/xDWW70IYg
nObm3pFKgwHc9BvVqFjDZeZEmb1Ne0S0nvZkSO1yeJzuGFBDFF+FujJiOQO/bD1z
GT965stR1AyH1T3TCCT6LNuA12VE+zUCnqWHUltyrxydrQixBVd51JiLTmKVYKO8
Wmd7bNA21Ow0pch7pHA130iqJ02vsSJ1o61VzLrBXGbJ9kj+54P2zcYUwtjdjTyQ
TfhumYUbPGMp4eQnTckyN3HPftjKWtCACE5q6Krte9FswGfBradCjBsQii7UMQIA
MFhKLDchIb45bWSclUE+PoBbwqmKslwKDzqfoneOwpHD8OLxsLVpNY1j/Avh3Es=
=yT+1
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

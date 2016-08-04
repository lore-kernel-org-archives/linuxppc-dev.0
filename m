Return-Path: <dja@axtens.net>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4gFk318mzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 16:36:41 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ez1so16021857pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 23:36:41 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 06/30] powerpc/ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
In-Reply-To: <1469674679-8580-7-git-send-email-wei.guo.simon@gmail.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
 <1469674679-8580-7-git-send-email-wei.guo.simon@gmail.com>
Date: Thu, 04 Aug 2016 16:36:22 +1000
Message-ID: <877fbxqbvd.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

This is causing cppcheck warnings (having just landed in next):

[arch/powerpc/kernel/ptrace.c:2062]: (error) Uninitialized variable: ckpt_r=
egs
[arch/powerpc/kernel/ptrace.c:2130]: (error) Uninitialized variable: ckpt_r=
egs

This is from...
> -static int gpr32_get(struct task_struct *target,
> +static int gpr32_get_common(struct task_struct *target,
>  		     const struct user_regset *regset,
>  		     unsigned int pos, unsigned int count,
> -		     void *kbuf, void __user *ubuf)
> +			    void *kbuf, void __user *ubuf, bool tm_active)
>  {
>  	const unsigned long *regs =3D &target->thread.regs->gpr[0];
> +	const unsigned long *ckpt_regs;
>  	compat_ulong_t *k =3D kbuf;
>  	compat_ulong_t __user *u =3D ubuf;
>  	compat_ulong_t reg;
>  	int i;
>=20=20
> -	if (target->thread.regs =3D=3D NULL)
> -		return -EIO;
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	ckpt_regs =3D &target->thread.ckpt_regs.gpr[0];
> +#endif
> +	if (tm_active) {
> +		regs =3D ckpt_regs;
... this bit here. If the ifdef doesn't trigger, cppcheck can't find an
initialisation for ckpt_regs, so it complains.

Techinically it's a false positive as (I assume!) tm_active cannot ever
be true in the absense of CONFIG_PPC_TRANSACTIONAL_MEM.

Is there a nice simple fix we could deploy to squash this warning, or
will we just live with it?

> -static int gpr32_set(struct task_struct *target,
> +static int gpr32_set_common(struct task_struct *target,
>  		     const struct user_regset *regset,
>  		     unsigned int pos, unsigned int count,
> -		     const void *kbuf, const void __user *ubuf)
> +		     const void *kbuf, const void __user *ubuf, bool tm_active)
>  {
>  	unsigned long *regs =3D &target->thread.regs->gpr[0];
> +	unsigned long *ckpt_regs;
>  	const compat_ulong_t *k =3D kbuf;
>  	const compat_ulong_t __user *u =3D ubuf;
>  	compat_ulong_t reg;
>=20=20
> -	if (target->thread.regs =3D=3D NULL)
> -		return -EIO;
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	ckpt_regs =3D &target->thread.ckpt_regs.gpr[0];
> +#endif
>=20=20
> -	CHECK_FULL_REGS(target->thread.regs);
> +	if (tm_active) {
> +		regs =3D ckpt_regs;
FWIW it happens again here.

Regards,
Daniel Axtens

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXouJnAAoJEPC3R3P2I92Fq0UP/AsHk7wBVLxi1eSPWsIl53Ly
Z7nHJNeZf0InxxgWKJ41w8WxAzZlGRB3gsbWSbnnPzzdSwLYzOC4K5VT2lmyZDU4
Yr+JnmVdoBgUOSzUJdBuo650WEHZ7C4A1lN+1ZZWEHLzIM22cJebSesQP/teXx92
xTdSeYmqjeDuu7rssbmdIxPUeJ1YK79ZS06CqegaLVZdhHGxupBt8X0GEDl9wWu6
NEjxp+eNB4a+yIi49Y+Jjk8FcUQztb0UQVdb4p6UIsBuxAo4CUDcyi3cC3koi50/
FSMTOooMQOZNfeEhsTZZkb7Xhs1lPPzyBrbI2cjV6EUh7mNjOuv52MhO8oDQWQQ3
tQWxecRypt6kH70GKh2dsBKXEcy2ja4+B+FRLql0LHaqieR2G7TYUnwXL/+QK7jw
WX/a8So1tbJZ2TFmbXIHDXsII2F20Tuczt+d+vCHdugi3bDJ/eybVOSFagOsQnOr
1aWeLXyFbX7n6dxdGX6PiCLD7z9AfvXtl4T+nCBVZsQqBbYPqBxucU/s7GLPneQj
1MaSnMastcgYoGf/Xgl06AJLwEDMPCKlFIvboVJjLD0aN3wfgBQOGkqBII9suQXP
KNG7AY72rfcK6QynTvb3K0CAyGgtIhfg0gPrc3rjxTMBq+PtHArQqO6Q5yEg5puU
wRHCoCs7s7+rDv/fcIlI
=7r+e
-----END PGP SIGNATURE-----
--=-=-=--

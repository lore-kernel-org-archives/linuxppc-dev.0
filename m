Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJrfC2NvwzDrcL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 12:21:38 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so229210pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:21:38 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Simon Guo <wei.guo.simon@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
In-Reply-To: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
Date: Wed, 24 Aug 2016 12:21:23 +1000
Message-ID: <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
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

Hi Simon,

> The ckpt_regs usage in gpr32_set_common/gpr32_get_common()
> will lead to cppcheck error.
>
> [arch/powerpc/kernel/ptrace.c:2062]: (error) Uninitialized variable: ckpt=
_regs
> [arch/powerpc/kernel/ptrace.c:2130]: (error) Uninitialized variable: ckpt=
_regs
>
> A straightforward fix to clean it.

I'm always happy to see cppcheck warnings fixed :)

>  static int gpr32_get_common(struct task_struct *target,
>  		     const struct user_regset *regset,
>  		     unsigned int pos, unsigned int count,
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  			    void *kbuf, void __user *ubuf, bool tm_active)
> +#else
> +			    void *kbuf, void __user *ubuf)
> +#endif

I wonder if it might be possible to avoid some of the ifdefs and general
churn by making the tm_active argument __maybe_unused rather than
ifdefing around it?

In particular, it would mean the two hunks in the function definitions
and these these two hunks at the call site would be unnecessary:
> @@ -2218,7 +2225,11 @@ static int gpr32_get(struct task_struct *target,
>  		     unsigned int pos, unsigned int count,
>  		     void *kbuf, void __user *ubuf)
>  {
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 0);
> +#else
> +	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf);
> +#endif
>  }
>=20=20
>  static int gpr32_set(struct task_struct *target,
> @@ -2226,7 +2237,11 @@ static int gpr32_set(struct task_struct *target,
>  		     unsigned int pos, unsigned int count,
>  		     const void *kbuf, const void __user *ubuf)
>  {
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 0);
> +#else
> +	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf);
> +#endif
>  }

Apart from that, thanks for fixing this up!

Regards,
Daniel

>=20=20
>  /*
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXvQSjAAoJEPC3R3P2I92Fyt8P/jJkFndc4TCTX/nsyWpmXn6Q
sECcTtT5BMkRmLvkS85NLu1CbW8FmTEgkj6u/+82jsVou7cAVo+4yYoc8SPwO8kM
F2OkFTWkq5Ku4ekTgGw/j85aCYfRlS7vRvB3s/QQH1anxfqHwt3HwHVThYkXd0FQ
pPhNmEKTmZ8zC/xxpfCAtlbB2vTrhXAC0/ixHgHmEzCeQeTXiLzlHKU+QdQ+veUt
r7r2Yd8YjbH/3IAsD0c62OKkSErqEMBpK+f5kh/L1XDSInY6A4icgyTJEF0VsBZS
Sv5m6w9cUHV8i+bmzU/43z1K7wMc5CZdjcT499gZTYoGjBq+w8oG1u1Un6lXia2G
tNDypZx+zH7t/4NUko1aK/GoUPSTF9THnk5EozY2kYl9iRjDV7atsCkU4b+hEpNB
0RvojGJxV48X3Mx7DKl8xeS3p6xnyasI8cnkA7etgZ4MtixN96c9+QDysN8FSyUv
NH8hjTtQCQvSIMlSkxYab9/qCSO0Cu425P7kQNGGImUNQS3mFjhaMJ/o53xr9fXw
BUGnFJBdhDNzzgxkkd2tyitmTzGtSxg2F2gdVEE/V03PHibm/g48YKuknUs1m1n0
jvNR2/s6bRlqKXXISdLC7v+Se5ucR7aTonttW7wK9XnXWJQlIocbqyTM2iS5rzUp
j+LAJT2abRKb3EPHhECj
=J5zu
-----END PGP SIGNATURE-----
--=-=-=--

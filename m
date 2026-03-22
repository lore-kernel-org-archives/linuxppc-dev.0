Return-Path: <linuxppc-dev+bounces-18562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F86BD58CB0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 23:04:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffBgr5NG9z2ySW;
	Mon, 23 Mar 2026 10:04:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774220648;
	cv=none; b=ItftricRPrE9dvb2ncqVWFyo627DbUXMMhmW5KkB3Imt/VoMCo5mHYcLXV4DAUMnzWNN1xnT1fvN2iBltm16jdFhUdnhXS9Hon+ZCfzBYWQfi0Jynf2g0e2NcScqijwAQ5S5jAGzztkU+uz4rBpWBOr8PiFSI2alqK3RJS3Tgif+iSK1eanTGKIbRicn8U/9Jmlv82pEONwk63/C6E3nFpqZBOw9+GsBCknBaDKqUbMCMfBcIx0gqN+m8Pu5acAnGwTY1fLbYo89BJ2FaPCfcv7CXQtaGxuAcZeJk+GcHpCPN4b0e1pMuGYSOs6RcwEGZ7uZXe5N0sAH84mbOwUnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774220648; c=relaxed/relaxed;
	bh=IxTgcbEXO2wXXCBB2vdpgsQMsD208IXbtScDLkWi/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ildp3cii1miKlANZ+jazXq0xusH7+skUQHlQcuUUEo5Ouw7CAP8zejk5M3/USwz7ih0ZrxlbjBE84Epl/JAseLdFGrLnRGvbd4SmtH5aQeIdEri0aC5na1W8vg5nsb2TN1Ka/2rKizEEgsV+BQIIyHQDVN6lsvRC9Z57Ziw1O+jhf6qk8zFOvv8JhzzKP8y+dlLk2oYU+wK691ND07xn48gJ2B1PwW7VliBvamBWAY+oaoeTcZ1pgil5/34z1TtdDNpNOmDpiBiwnt+JgVuHy2a6QjMgDpvKKmgfE8joB0Mar2K2Oz450jf+hc1MLvKLf0yzHjxuIOYCeVuJAvI/0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jq+53DnV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jq+53DnV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffBgq5YBdz2xQ1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 10:04:07 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso29079145e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774220644; x=1774825444; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxTgcbEXO2wXXCBB2vdpgsQMsD208IXbtScDLkWi/y0=;
        b=jq+53DnVqi5ogb4QIE/Bhuf5aWdSB8TqEVf23l6IipwmDy2GtzEF0P9vZG/7K9OX9S
         Ox9nwej5m4LUYfKW4KlL2aAEfrqyQcJDb5DpMk8m7Tb594OI5fgyeCxubO/7S/3Bon0R
         F+EIhyNkWZqtt2yQVQswwgomSbvLLxpueHV+i0eLRD9vAXvHQMJnlAB9XsdAou3WAhWy
         879GHBsgIOG3rmaeU47zNWQGrgGtrvuqvLoyHWjZ1VWK2aV1YTvEacC9KAIjXW+nA2n1
         rKNTpMF4esGUvLePeTRVLSEb+jPi+V+JI//3Kk9fKerCdCbRzX0mPCCXdoKI9VSnTrfT
         GcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774220644; x=1774825444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxTgcbEXO2wXXCBB2vdpgsQMsD208IXbtScDLkWi/y0=;
        b=PLtzOonWbYX6PnK0J1BzFIooKHLCZObINg31ApXyJ897+9AR9Dc0ulx2tmxSeebHUc
         P3Bk9tKpPGo72LM2IL5Xzl6aw7NcJpY/MCT9bdJllIrqTyROHl/nMLepKLWrImhJgqFa
         uwvy/dw8Z9ZjfzHpZxeGlE3uLkB+Olu/qBnkxB9X+FlMso5DlI7i/4oNxgRp6qwl1xBN
         Z7bQHcjshN10fPatrDEO5rSCO7SMn/iY0SK+tUVB5AkxOzvFqr5tZfXeZt52ZNKkPrwZ
         qFuw+tCVhlzhpjKevKcoAo89pSlfanbtFnjCyhu7VRVubPYX+NikIWZPNSEbB71QH0vU
         EWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4uoR0Oxxm5JUf0+fds5zyyG/cLKh2jjlnvGS2hKofrx0wvAW5lrcoAhkSgNxMVrYHz2XxU3WzASBgUPA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXDD6YH1UsNr8CqXsIJryH27vs56kaWYABu056wT9/j49/zdLI
	QM/CdVVfOZ7j/Ehmb9IaSFwsZguS8Fu4hEMSZhiKZQLBrCo1lMhejeWV
X-Gm-Gg: ATEYQzzeZLaMbMOYLdvnlyoBmdhjDcMYL/4ltOwpV1NKFKNUib0wbNBRG06J6y5dbtc
	7sTr2T9TBiI511pHhkPogQQaaPoC4VWk7uroXNdCtJMKQZMH8QJ7i+u2DzMaYJcFBprFw9zyQDY
	fqSawthsI6KlAM8cXw+esje6Fdnse6M2wXKXeSu26jXNO7JJWcWI6JRk/8GFnTzbG5/TTOjx8fK
	4i8DEU4rlbSTSn3VOGx+cCuYEI4FD4VvXDnYVcQwuFT5jzmuMnegg4evp2grGiSzb57i3QGXx+O
	Ov/Om7RM6dfTCAQX7psmxxlgjuUipeomlFcwPpGmmmczkKLV0PhEEboLYgHmRONoDzEp1rBeF01
	6OrFUH5yc0m42wATV76OOJ5DRocmtYCfGwWQv/75c9URBEGdej3rNiESKKI2x0N469DoP464Zcl
	MQHO60Dw7aixu51IW29SHZLbGlOMq/p/uBWM7scWCLQnDy5Jsh9zp3CzVZHlrAcv/P
X-Received: by 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-486febb5989mr142158815e9.4.1774220643908;
        Sun, 22 Mar 2026 16:04:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48703e26408sm225424885e9.11.2026.03.22.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 16:04:03 -0700 (PDT)
Date: Sun, 22 Mar 2026 23:04:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Simplify access_ok()
Message-ID: <20260322230402.519f5445@pumpkin>
In-Reply-To: <833d9535-d241-4738-b5f6-28f9ec48329a@kernel.org>
References: <56dd1a892279fade2292b7eef7a52112901ae2fd.1773770778.git.chleroy@kernel.org>
	<20260322110336.66cd54af@pumpkin>
	<833d9535-d241-4738-b5f6-28f9ec48329a@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Mar 2026 20:02:56 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 22/03/2026 =C3=A0 12:03, David Laight a =C3=A9crit=C2=A0:
> > On Tue, 17 Mar 2026 19:07:04 +0100
> > "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> >  =20
> >> With the implementation of masked user access, we always have a memory
> >> gap between user memory space and kernel memory space, so use it to
> >> simplify access_ok() by relying on access fault in case of an access
> >> in the gap.
> >>
> >> Most of the time the size is known at build time.
> >>
> >> On powerpc64, the kernel space starts at 0x8000000000000000 which is
> >> always more than two times TASK_USER_MAX so when the size is known at
> >> build time and lower than TASK_USER_MAX, only the address needs to be
> >> verified. If not, a binary or of address and size must be lower than
> >> TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
> >> there is no bit set outside of TASK_USER_MAX - 1 mask.
> >>
> >> On powerpc32, there is a garanteed gap of 128KB so when the size is
> >> known at build time and not greater than 128KB, just check that the
> >> address is below TASK_SIZE. Otherwise use the original formula. =20
> >=20
> > Given that the whole thing relies on the kernel code 'obeying the rules'
> > is it enough to require that the accesses will be 'moderately sequentia=
l'?
> > Provided there are no jumps greater than 128k the length can be ignored.
> >=20
> > I think Linus thought about doing that for x86-64. =20
>=20
> You mean ignoring length completely ?

That is the thought.
The 'masked_user_access' code does that and it could be always done
provided all the call sites are checked.
The length was needed historically because the 386 allowed kernel
writes to read only pages - so COW had to be tested in software.

>=20
> Yes we can probably do that on 64 bits. I don't know about x86_64 but=20
> powerpc64 has TASK_USER < 0x0010000000000000 and kernel space is above=20
> 0x8000000000000000, so oring size with address and comparing it to=20
> 0x0010000000000000 doesn't add much cost compared to just comparing the=20
> address.
>=20
> >=20
> > I can't imagine that happening unless there is code that probes the end=
 of
> > the user buffer before starting a transfer - and that is pretty pointle=
ss. =20
>  > > There are places that skip a few bytes (or just access in the wrong =
 =20
> order)
> > but it is likely to be alignment padding, and code should be doing the
> > access_ok() check for each fragment - not on the entire buffer. =20
>=20
> I don't follow you. Why not for the entire buffer ? We try to minimise=20
> amount of stac/clac (or equivalent) and access_ok() is associated with=20
> stac. When we use access_begin/access_end we tend to try and regroup=20
> everything in a single bloc.

I mean that the access_ok/stac/clac are done together at the place where
the copy is done, rather than doing the access_ok() on the system call
interface and the actual copies much later.
There are a few ioctl (probably netlink and some of the sctp sockopt)
which process multiple 'items' in one user buffer - they'll do the
access_ok/stac/clac multiple times.

The only problem would be code that processes a buffer that contains
lots of items like:
	struct item {
		unsigned int size;
		char cmd[size];
	};
and advances to the next item believing the 'size' field (checked against
the outer buffer size) but without a separate access_ok() for the later
commands.
=09

>=20
> >  =20
> >>
> >> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> >> ---
> >>   arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include=
/asm/uaccess.h
> >> index 570b3d91e2e4..ec210ae62be7 100644
> >> --- a/arch/powerpc/include/asm/uaccess.h
> >> +++ b/arch/powerpc/include/asm/uaccess.h
> >> @@ -15,8 +15,34 @@
> >>   #define TASK_SIZE_MAX		TASK_SIZE_USER64
> >>   #endif
> >>  =20
> >> +#define __access_ok __access_ok
> >> +
> >>   #include <asm-generic/access_ok.h>
> >>  =20
> >> +/*
> >> + * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if bot=
h ptr and size
> >> + * are TASK_SIZE_MAX we are still inside the memory gap. So make it s=
imple.
> >> + */
> >> +static __always_inline int __access_ok(const void __user *ptr, unsign=
ed long size)
> >> +{
> >> +	unsigned long addr =3D (unsigned long)ptr;
> >> +
> >> +	if (IS_ENABLED(CONFIG_PPC64)) {
> >> +		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
> >> +		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
> >> +
> >> +		if (__builtin_constant_p(size))
> >> +			return size <=3D TASK_SIZE_MAX && !(addr & ~(TASK_SIZE_MAX - 1));
> >> +		else
> >> +			return !((size | addr) & ~(TASK_SIZE_MAX - 1)); =20
> >=20
> > The compiler may know an upper bound for 'size' even when it isn't a co=
nstant.
> > It might be 32bit or from 'size =3D is_compat_foo ? 16 : 24', so:
> > 		if (statically_true(size < TASK_SIZE_MAX)
> > 			return !(addr & ~(TASK_SIZE_MAX - 1);
> > 		return !((size | addr) & ~(TASK_SIZE_MAX - 1)); =20
>=20
> I think you are missing the case where size is constant and > TASK_SIZE_M=
AX.

It is no different to a variable size that happens to be > TASK_SIZE_MAX.
But I suspect the compiler will optimise it to 'return 0'.

> Or maybe that case should be catched with a BUILD_BUG ?

Probably not worth slowing down the compile.

	David

>=20
> Christophe
>=20
> >  =20
> >> +	} else {
> >> +		if (__builtin_constant_p(size) && size < SZ_128K) =20
> >=20
> > Again the compiler may know an upper bound even if the value isn't cons=
tant:
> > 		if (statically_true(size < SZ_128K)
> >=20
> > 	David
> >  =20
> >> +			return addr < TASK_SIZE;
> >> +		else
> >> +			return size <=3D TASK_SIZE && addr <=3D TASK_SIZE - size);
> >> +	}
> >> +}
> >> +
> >>   /*
> >>    * These are the main single-value transfer routines.  They automati=
cally
> >>    * use the right size if we just have the right pointer type. =20
> >  =20
>=20



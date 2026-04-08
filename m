Return-Path: <linuxppc-dev+bounces-19511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764DFFD5F96
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 14:15:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frQ7w07j0z2yDk;
	Thu, 09 Apr 2026 00:15:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775657723;
	cv=none; b=MuZ+u0N7JbRJYhZ+JnBOoFVUmfNgOiMgLWxZGB+7VCaVlecvidGOmHpVz4sv3Wgp/POnjTE2cxA7T/E28vzxk1/IvvFMgKKlV7i53WPA/dYvJkEeuZx3BCd6gq2CLNlO1q11n4aTPqPc0lg4MGQZOWSKPnkwlaQUWNh+85YEUXJuQDG3xEFD4lf9Z3pXxlfSyuE7TLG+J7EsBcsW08GqEtWDbS2SbOmEAdZJhHVXPlxepRhsnKX5nM0brnaRFZ9jV7QMLA2s8o4WMF6hhPPNxmuO23aED8PJCA/dv2R5EDk1lv8bPUtzKPq2BDAzCmnZj+3CyZgOQGDnOOscrHqLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775657723; c=relaxed/relaxed;
	bh=hw86Z2oMjukv7dRJsZwSun/q5K/w6jTV8cXNd+xxQko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePSpOmQjgME/1t6vaZiQpVhQzwFKmMXoi3QhBmEB7G5187pa324TqMw74PC+9yiIguhNpdwx3oojzovTVLgmMlOFTQ5Z/ARJ/mndUtXUxJe5Ae/ERjEYZ03+legivljXiyA3+B9bn3DvoXdoe2wnlzwBkPDU+6fR5V+u+babK/mzh21jwM/pGDeDf9cdHgABYz7sCmIsuJQIkS9dtuc9th2cFGsHJdPOxlsYZe2K1qo5dxRzpVFM14tSnzblx79hvjMQvEwpmnzADo7ysoT9fIrWr1ozo7hPev/hYUZZDI/Ypi/xl22Pnp1oG8KoKkMkoR4kuAKTKiBTdF36xcQwDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kICzfa+x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kICzfa+x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frQ7s68N8z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 00:15:20 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82cf83bf375so2621005b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775657718; x=1776262518; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hw86Z2oMjukv7dRJsZwSun/q5K/w6jTV8cXNd+xxQko=;
        b=kICzfa+xtbZUSHDgc0kQcCTW5LrmU6iUkYvCpHYgnMblV9M+nMBs/3k+gkaWXWT6MK
         wTTwC5ndB2YYLLbh//pGjkHTTHUXZwP3qA51xPMbfv8jOjO5oyKAOqQ+Fo+3PQXl6mP3
         M4WzITjr6wNSzrY4VSVeq1ZfSy5jIliKTIiBYC33nYEZeh3XayI/Yt2yPPjunjRqElwa
         3aY5jFtUry5zTRgvkMv3hrG1tUk8M1C5nVhVu0qmYvWDD9l7GCGpSccyr5e8DmmwR90z
         AH5DlIoD+SyrghlOwR6i4E4W2p0zOwyoNXgYC6AwqyjJGqLMs5H16uH8bjkY/q2yUKV2
         qHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775657718; x=1776262518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw86Z2oMjukv7dRJsZwSun/q5K/w6jTV8cXNd+xxQko=;
        b=EfFMBDG21z2drAEhqzTxMEkRpIehFPYBK5aY8l4Q65cwTR0FUkhm3Q4blZDCs3oVpI
         MgWxKWu8hxHNUkiJU6Ce2ptAw+suqSbPlJ0CXFIlPkZmxgNX1Lf7FTsf2IXisn2YcnAn
         57QHGoyHtUXTG/PEqSW8r0WUZO56hJyTdSuoJ7ZajG7f80wLWbECuTQ0JqBgPk0nTlqy
         lgLVpZ87W5/a8huGpkx0cHJM1wI5QeFnG5xV9XRYtp3Ryc1TyyzKvAnMfi34lQ/kE2KD
         o9bhMNhQxsZ1lUfPt/Kp2YAjvsFjVY0QqTyyqdxPn30Y1u6jqpLB+uGZFlZLt8y/RpHj
         KXJw==
X-Forwarded-Encrypted: i=1; AJvYcCWmPWozPEJCeicLzy+0/lP2c6pOStNmjU610v6qQHwwfY7xooA9XsbC8LjVKAxZU/02R1BU/lEAKlaZK0c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdH7mswwgm4T7EVfXUyMwUbzUAMEfUXZWS+A+JWzkgtHuud+vC
	te/jwxCIfQ3QNb2+WQCdKOaXMRdIp/AprInI/rDsEapT6gseLFeUkq+Z
X-Gm-Gg: AeBDieu4W/ApMJOPr/2WIy2XxUALYTPp3Q8klrcjDo4XYyfxbCIJ7xHannGiXEbIiMZ
	AVPFGxIt7Ntuxn4w4fJoQMr1Ufy2Ivn1sHPCygMCucH1baGPNrxmUkaSkmy8wnHltrK+GchV4mI
	3VoMuvvrX4PGzt9IkyNHcSdvQsHYa1c1DlRoxTWq44W5297FXQyHOrJAm6NpuuJFm+gJywJt0tl
	RVWkGt+85Ic8UvIfH9hruiHwtGGEbUMnrKN9FsBTch3H2COpsTW/Li6QSTVfmYrKubi3E2uvihH
	utEYltskzWsSnt7MdujlQ4zUhafCA8go3Glfwu2H0h87lGOSYfDN1GGeplCKFcj5KbYY7REvgw8
	GX0t40/iPbON8YApP+NRItm5diVVZQJOX9duQ5TnW/oY5rsIy3J86+pUpy1gF5U9O1rj8sQm3+3
	evUxcmaIExT/vJRcaxbkbruGVsyG7csUoXSWJr/YnUu/7e8uZCv4XbgbmukKBN/cJoHZ7Izg==
X-Received: by 2002:a05:6a00:14cc:b0:82c:e4b4:b056 with SMTP id d2e1a72fcca58-82d0db9115cmr20885070b3a.43.1775657717973;
        Wed, 08 Apr 2026 07:15:17 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm22057700b3a.38.2026.04.08.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:15:17 -0700 (PDT)
Date: Wed, 8 Apr 2026 19:45:07 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V10 0/4] Rust support for powerpc [RESEND]
Message-ID: <adZhrsF_p5EKtfJd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
 <adYlLLfRgSyxus3n@luna>
 <adZBWoVVoJefiTcM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <adZV_VISz8DNraug@luna>
 <DHNTT7LIVLDL.5FC5I1FES8IO@garyguo.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DHNTT7LIVLDL.5FC5I1FES8IO@garyguo.net>

On Wed, Apr 08, 2026 at 03:00:23PM +0100, Gary Guo wrote:
> On Wed Apr 8, 2026 at 2:19 PM BST, Link Mauve wrote:
> > On Wed, Apr 08, 2026 at 05:23:39PM +0530, Mukesh Kumar Chaurasiya wrote:
> >> On Wed, Apr 08, 2026 at 11:51:40AM +0200, Link Mauve wrote:
> >> > Hi,
> >> >=20
> >> > (This email is a resent, my IP address got flagged by spamhaus again
> >> > because I=E2=80=99m on a residential range, hopefully this incident =
is
> >> > resolved=E2=80=A6)
> >> >=20
> >> > On Tue, Apr 07, 2026 at 01:31:45AM +0530, Mukesh Kumar Chaurasiya (I=
BM) wrote:
> >> > > Enable experimental rust support for ppc64le and ppc32be. The patc=
h for
> >> > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] ha=
s been
> >> > > merged over it. ppc32 needs some toolchain fixes mentioned in the =
patch
> >> > > `rust: Add PowerPC support` and the discussion for that is done he=
re[1].
> >> > >=20
> >> > > This has been tested on
> >> > > - powernv9 hardware
> >> > > - pseries P11 hardware
> >> > > - pseries(9, 10) qemu
> >> > > - powernv(9, 10) qemu
> >> > > - rustdoc on x86 and powerpc64le
> >> > > - rusttest on x86 and powerpc64le
> >> >=20
> >> > I just tested your series for the Wii, so targeting powerpc (32, be),
> >> > and got this error:
> >> > ```
> >> > error[E0463]: can't find crate for `pin_init_internal`
> >> >    --> ../rust/pin-init/src/lib.rs:365:11
> >> >     |
> >> > 365 | pub use ::pin_init_internal::pin_data;
> >> >     |           ^^^^^^^^^^^^^^^^^ can't find crate
> >> >=20
> >> > error: aborting due to 1 previous error
> >> >=20
> >> > For more information about this error, try `rustc --explain E0463`.
> >> > ```
> >> >=20
> >> > I didn=E2=80=99t get this error in a previous version of your series=
, would you
> >> > want me to bisect them?
> >> >=20
> >> > Thanks for your continuous work on it anyway!
> >> >=20
> >>=20
> >> Hey Link,
> >>=20
> >> Thanks for testing this.
> >>=20
> >> Can you give me the command generated via make with V=3D1
> >> e.g. `make LLVM=3D1 V=3D1`
> >
> > Here it is:
> > ```
> > % make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1=
 V=3D1 -j1
> > make  -C /home/linkmauve/dev/linux/wii \
> > -f /home/linkmauve/dev/linux/Makefile
> > make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
> > make --no-print-directory -C /home/linkmauve/dev/linux/wii \
> > -f /home/linkmauve/dev/linux/Makefile
> > ln -fsn .. source
> > # GEN     Makefile
> >   { echo "# Automatically generated by /home/linkmauve/dev/linux/Makefi=
le: don't edit"; echo "export KBUILD_OUTPUT =3D /home/linkmauve/dev/linux/w=
ii"; echo "include /home/linkmauve/dev/linux/Makefile"; } > Makefile
> > test -e .gitignore || \
> > { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> > make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/syscalls all
> > make -f ../scripts/Makefile.build obj=3Dscripts/basic
> > make -f ../scripts/Makefile.build obj=3Dscripts/dtc
> > make -f ../scripts/Makefile.build obj=3Dscripts
> > make -f ../scripts/Makefile.build obj=3Dscripts/gcc-plugins \
> > need-builtin=3D \
> > need-modorder=3D \
> >
> > set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kerne=
l.release" EXIT; { ../scripts/setlocalversion ..; } > include/config/.tmp_k=
ernel.release; if [ ! -r include/config/kernel.release ] || ! cmp -s includ=
e/config/kernel.release include/config/.tmp_kernel.release; then : '  UPD  =
   include/config/kernel.release'; mv -f include/config/.tmp_kernel.release=
 include/config/kernel.release; fi
> > make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/gene=
rated/uapi/asm \
> > generic=3Dinclude/uapi/asm-generic
> > make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/gene=
rated/asm \
> > generic=3Dinclude/asm-generic
> > set -e; mkdir -p include/generated/uapi/linux/; trap "rm -f include/gen=
erated/uapi/linux/.tmp_version.h" EXIT; { 	if [ 0 -gt 255 ]; then echo \#de=
fine LINUX_VERSION_CODE 459007; else echo \#define LINUX_VERSION_CODE 45875=
2; fi; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c)=
 > 255 ? 255 : (c)))'; echo \#define LINUX_VERSION_MAJOR 7; echo \#define L=
INUX_VERSION_PATCHLEVEL 0; echo \#define LINUX_VERSION_SUBLEVEL 0; } > incl=
ude/generated/uapi/linux/.tmp_version.h; if [ ! -r include/generated/uapi/l=
inux/version.h ] || ! cmp -s include/generated/uapi/linux/version.h include=
/generated/uapi/linux/.tmp_version.h; then : '  UPD     include/generated/u=
api/linux/version.h'; mv -f include/generated/uapi/linux/.tmp_version.h inc=
lude/generated/uapi/linux/version.h; fi
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_utsrelease.h" EXIT; { 	if [ `echo -n "7.0.0-rc7-wii+" | wc -c ` -gt 64 ]; =
then echo '"7.0.0-rc7-wii+" exceeds 64 characters' >&2; exit 1; fi; echo \#=
define UTS_RELEASE \"7.0.0-rc7-wii+\"; } > include/generated/.tmp_utsreleas=
e.h; if [ ! -r include/generated/utsrelease.h ] || ! cmp -s include/generat=
ed/utsrelease.h include/generated/.tmp_utsrelease.h; then : '  UPD     incl=
ude/generated/utsrelease.h'; mv -f include/generated/.tmp_utsrelease.h incl=
ude/generated/utsrelease.h; fi
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_compile.h" EXIT; { ../scripts/mkcompile_h "ppc" "powerpc-linux-musl-gcc (G=
CC) 14.2.1 20250405" "powerpc-linux-musl-ld"; } > include/generated/.tmp_co=
mpile.h; if [ ! -r include/generated/compile.h ] || ! cmp -s include/genera=
ted/compile.h include/generated/.tmp_compile.h; then : '  UPD     include/g=
enerated/compile.h'; mv -f include/generated/.tmp_compile.h include/generat=
ed/compile.h; fi
> > ../scripts/remove-stale-files
> > make -f ../scripts/Makefile.build obj=3Dscripts/mod
> > set -e; mkdir -p scripts/mod/; trap "rm -f scripts/mod/.tmp_devicetable=
-offsets.h" EXIT; { 	 echo "#ifndef __DEVICETABLE_OFFSETS_H__"; echo "#defi=
ne __DEVICETABLE_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " =
*"; echo " * This file was generated by Kbuild"; echo " */"; echo ""; sed -=
ne 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/*=
 \1 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:-=
>::; p;}' < scripts/mod/devicetable-offsets.s; echo ""; echo "#endif"; } > =
scripts/mod/.tmp_devicetable-offsets.h; if [ ! -r scripts/mod/devicetable-o=
ffsets.h ] || ! cmp -s scripts/mod/devicetable-offsets.h scripts/mod/.tmp_d=
evicetable-offsets.h; then : '  UPD     scripts/mod/devicetable-offsets.h';=
 mv -f scripts/mod/.tmp_devicetable-offsets.h scripts/mod/devicetable-offse=
ts.h; fi
> > make -f ../scripts/Makefile.build obj=3D. prepare
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_timeconst.h" EXIT; { echo 1000 | bc -q ../kernel/time/timeconst.bc; } > in=
clude/generated/.tmp_timeconst.h; if [ ! -r include/generated/timeconst.h ]=
 || ! cmp -s include/generated/timeconst.h include/generated/.tmp_timeconst=
=2Eh; then : '  UPD     include/generated/timeconst.h'; mv -f include/gener=
ated/.tmp_timeconst.h include/generated/timeconst.h; fi
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_bounds.h" EXIT; { 	 echo "#ifndef __LINUX_BOUNDS_H__"; echo "#define __LIN=
UX_BOUNDS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * Th=
is file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:spac=
e:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\=
([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < ker=
nel/bounds.s; echo ""; echo "#endif"; } > include/generated/.tmp_bounds.h; =
if [ ! -r include/generated/bounds.h ] || ! cmp -s include/generated/bounds=
=2Eh include/generated/.tmp_bounds.h; then : '  UPD     include/generated/b=
ounds.h'; mv -f include/generated/.tmp_bounds.h include/generated/bounds.h;=
 fi
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_asm-offsets.h" EXIT; { 	 echo "#ifndef __ASM_OFFSETS_H__"; echo "#define _=
_ASM_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " *=
 This file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:s=
pace:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^=
->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < =
arch/powerpc/kernel/asm-offsets.s; echo ""; echo "#endif"; } > include/gene=
rated/.tmp_asm-offsets.h; if [ ! -r include/generated/asm-offsets.h ] || ! =
cmp -s include/generated/asm-offsets.h include/generated/.tmp_asm-offsets.h=
; then : '  UPD     include/generated/asm-offsets.h'; mv -f include/generat=
ed/.tmp_asm-offsets.h include/generated/asm-offsets.h; fi
> > set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp=
_rq-offsets.h" EXIT; { 	 echo "#ifndef __RQ_OFFSETS_H__"; echo "#define __R=
Q_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * Th=
is file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:spac=
e:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\=
([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < ker=
nel/sched/rq-offsets.s; echo ""; echo "#endif"; } > include/generated/.tmp_=
rq-offsets.h; if [ ! -r include/generated/rq-offsets.h ] || ! cmp -s includ=
e/generated/rq-offsets.h include/generated/.tmp_rq-offsets.h; then : '  UPD=
     include/generated/rq-offsets.h'; mv -f include/generated/.tmp_rq-offse=
ts.h include/generated/rq-offsets.h; fi
> > # CALL    ../scripts/checksyscalls.sh
> >   sh ../scripts/checksyscalls.sh powerpc-linux-musl-gcc -Wp,-MMD,./.mis=
sing-syscalls.d -nostdinc -I../arch/powerpc/include -I./arch/powerpc/includ=
e/generated -I../include -I./include -I../arch/powerpc/include/uapi -I./arc=
h/powerpc/include/generated/uapi -I../include/uapi -I./include/generated/ua=
pi -include ../include/linux/compiler-version.h -include ../include/linux/k=
config.h -include ../include/linux/compiler_types.h -D__KERNEL__ -mbig-endi=
an -m32 -I ../arch/powerpc -fmacro-prefix-map=3D../=3D -Wundef -DKBUILD_EXT=
RA_WARN1 -std=3Dgnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -f=
no-strict-aliasing -msoft-float -ffixed-r2 -mmultiple -mno-readonly-in-sdat=
a -mcpu=3Dpowerpc -mno-prefixed -mno-pcrel -mno-altivec -mno-vsx -mno-mma -=
fno-asynchronous-unwind-tables -mno-string -mbig-endian -fno-delete-null-po=
inter-checks -Os -fno-allow-store-data-races -fno-stack-protector -fomit-fr=
ame-pointer -ftrivial-auto-var-init=3Dzero -fno-stack-clash-protection -fmi=
n-function-alignment=3D4 -fstrict-flex-arrays=3D3 -fms-extensions -fno-stri=
ct-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -We=
xtra -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int=
 -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security -Wn=
o-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-decl=
arations -Wmissing-prototypes -Wframe-larger-than=3D1280 -Wno-main -Wno-typ=
e-limits -Wno-dangling-pointer -Wvla-larger-than=3D1 -Wno-pointer-sign -Wca=
st-function-type -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-l=
arger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompa=
tible-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wunused -W=
missing-format-attribute -Wmissing-include-dirs -Wunused-const-variable -Wn=
o-missing-field-initializers -Wno-shift-negative-value -Wno-maybe-uninitial=
ized -Wno-sign-compare -Wno-unused-parameter -DGCC_PLUGINS -I../. -I.    -D=
KBUILD_MODFILE=3D'"./missing-syscalls"' -DKBUILD_BASENAME=3D'"missing_sysca=
lls"' -DKBUILD_MODNAME=3D'"missing_syscalls"' -D__KBUILD_MODNAME=3Dmissing_=
syscalls
> > make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/vdso includ=
e/generated/vdso32-offsets.h
> > mkdir -p ./tools
> > make O=3D/home/linkmauve/dev/linux/wii subdir=3Dtools -C ../tools/ objt=
ool
> > mkdir -p /home/linkmauve/dev/linux/wii/tools/objtool && make O=3D/home/=
linkmauve/dev/linux/wii subdir=3Dtools/objtool --no-print-directory -C objt=
ool
> > make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /hom=
e/linkmauve/dev/linux/wii/tools/objtool/fixdep
> > if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep ]; then			=
			\
> > 	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. o=
bj=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O=
2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
> > 	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep.o;						\
> > fi
> > make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. ob=
j=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2=
 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
> > make -C /home/linkmauve/dev/linux/tools/lib/subcmd/ O=3D/home/linkmauve=
/dev/linux/wii/tools/objtool/libsubcmd \
> > 	DESTDIR=3D/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd prefix=
=3D subdir=3D \
> > 	CC=3D"gcc" LD=3D"ld" AR=3D"ar" EXTRA_CFLAGS=3D"-std=3Dgnu11 -fomit-fra=
me-pointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-decl=
arations -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-u=
nused-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauve=
/dev/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/in=
clude/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/l=
inkmauve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools/=
objtool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool/=
libsubcmd/include   " \
> > 	/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsubcmd.a inst=
all_headers
> > make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /hom=
e/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep
> > if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep =
]; then						\
> > 	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. o=
bj=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O=
2 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
> > 	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep.o;	=
					\
> > fi
> > make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. ob=
j=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2=
 -fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
> > make[5]: 'install_headers' is up to date.
> > sh ./sync-check.sh
> > make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. ob=
j=3Dobjtool CC=3D"gcc" LD=3D"ld" AR=3D"ar" CFLAGS=3D"-std=3Dgnu11 -fomit-fr=
ame-pointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-dec=
larations -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-=
unused-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauv=
e/dev/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/i=
nclude/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/=
linkmauve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools=
/objtool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool=
/libsubcmd/include   " \
> > 	LDFLAGS=3D"/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsu=
bcmd.a -lelf  "
> > make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D./ar=
ch/powerpc obj=3Dobjtool
> > sh ../scripts/rust_is_available.sh
> > make -f ../scripts/Makefile.build obj=3Drust
> > # RUSTC L rust/pin_init.o
> >   OBJTREE=3D/home/linkmauve/dev/linux/wii rustc --edition=3D2021 -Zbina=
ry_dep_depinfo=3Dy -Astable_features -Aunused_features -Dnon_ascii_idents -=
Dunsafe_op_in_unsafe_fn -Wmissing_docs -Wrust_2018_idioms -Wunreachable_pub=
 -Wclippy::all -Wclippy::as_ptr_cast_mut -Wclippy::as_underscore -Wclippy::=
cast_lossless -Wclippy::ignored_unit_patterns -Wclippy::mut_mut -Wclippy::n=
eedless_bitwise_bool -Aclippy::needless_lifetimes -Wclippy::no_mangle_with_=
rust_abi -Wclippy::ptr_as_ptr -Wclippy::ptr_cast_constness -Wclippy::ref_as=
_ptr -Wclippy::undocumented_unsafe_blocks -Wclippy::unnecessary_safety_comm=
ent -Wclippy::unnecessary_safety_doc -Wrustdoc::missing_crate_level_docs -W=
rustdoc::unescaped_backticks -Cpanic=3Dabort -Cembed-bitcode=3Dn -Clto=3Dn =
-Cforce-unwind-tables=3Dn -Ccodegen-units=3D1 -Csymbol-mangling-version=3Dv=
0 -Crelocation-model=3Dstatic -Zfunction-sections=3Dn -Wclippy::float_arith=
metic --target=3Dpowerpc-unknown-linux-gnu -Copt-level=3Ds -Cdebug-assertio=
ns=3Dn -Coverflow-checks=3Dy @./include/generated/rustc_cfg --extern pin_in=
it_internal --extern macros --cfg=3D'kernel' --emit=3Ddep-info=3Drust/.pin_=
init.o.d --emit=3Dobj=3Drust/pin_init.o --emit=3Dmetadata=3Drust/libpin_ini=
t.rmeta --crate-type rlib -L./rust --crate-name pin_init ../rust/pin-init/s=
rc/lib.rs --sysroot=3D/dev/null -Zunstable-options   ; ./tools/objtool/objt=
ool --static-call   rust/pin_init.o
>
Thanks Link.

> Looks like the command line here is missing -L./rust/host.
>=20
Yeah, got the fix for it. Stupid mistake.
Will send out a new revision.
Thanks though.

Regards,
Mukesh
> Mukesh, perhaps when you test locally you didn't clean out the already-bu=
ilt
> files inside rust directory?
>=20
> Best,
> Gary
>
> > error[E0463]: can't find crate for `pin_init_internal`
> >    --> ../rust/pin-init/src/lib.rs:365:11
> >     |
> > 365 | pub use ::pin_init_internal::pin_data;
> >     |           ^^^^^^^^^^^^^^^^^ can't find crate
> >
> > error: aborting due to 1 previous error
> >
> > For more information about this error, try `rustc --explain E0463`.
> > make[3]: *** [../rust/Makefile:681: rust/pin_init.o] Error 1
> > make[2]: *** [/home/linkmauve/dev/linux/Makefile:1343: prepare] Error 2
> > make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error=
 2
> > make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
> > make: *** [Makefile:248: __sub-make] Error 2
> > make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1 V=
=3D1 -j1  1.15s user 0.56s system 100% cpu 1.695 total
> > ```
> >
> >>=20
> >> Regards,
> >> Mukesh
> >>=20
> >> > >=20
> >> > > We are actively working with our LLVM team to get the target for p=
pc,
> >> > > ppc64 and ppc64le in the rust compiler.
> >> > >=20
> >> > >=20
> >> > > [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@li=
nkmauve.fr
> >> > > [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@g=
mail.com
> >> > >=20
> >> > > Changelog:
> >> > > V9 -> V10:
> >> > > - rust/Makefile updated with review comments from Miguel
> >> > > - Patch 1/4 updated with commit message and subject
> >> > > V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras=
@gmail.com/
> >> > >=20
> >> > > V8 -> V9:
> >> > > - rust/Makefile updated with a directory instead of abspath
> >> > > V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras=
@gmail.com/
> >> > >=20
> >> > > V7 -> V8:
> >> > > - rust/Makefile updated to separate host libraries from target
> >> > > V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras=
@gmail.com/
> >> > >=20
> >> > > Changelog:
> >> > > V6 -> V7:
> >> > > - Documentation removed as powerpc is still under development
> >> > > - Added a fix for race condition in rust/Makefile
> >> > > V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras=
@gmail.com
> >> > >=20
> >> > > V5 -> V6:
> >> > > - Added a missing Tested by from Venkat which got missed since V3
> >> > > - Support is marked as Maintained instead of experimental
> >> > > V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras=
@gmail.com
> >> > >=20
> >> > > V4 -> V5:
> >> > > - Removed a nested ifdef from PPC64 for Little endian toolchain
> >> > > V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras=
@gmail.com
> >> > >=20
> >> > > V3 -> V4:
> >> > > - Co-developed-by header added in patch 1
> >> > > V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras=
@gmail.com
> >> > >=20
> >> > > V2 -> V3:
> >> > > - Splited HAVE_RUST in 2 lines
> >> > > - BINDGEN_TARGET_powerpc initialized before assigning the same to
> >> > >   BINDGEN_TARGET
> >> > > V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@=
gmail.com
> >> > >=20
> >> > > V1 -> V2:
> >> > > - jump label fix for rust has been moved to a separate patch
> >> > > - PPC32 support has been taken
> >> > > - rust support has been marked experimental
> >> > > - target.json dependency has been removed
> >> > > - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> >> > >=20
> >> > > Link Mauve (1):
> >> > >   rust: Add PowerPC support
> >> > >=20
> >> > > Mukesh Kumar Chaurasiya (IBM) (3):
> >> > >   rust: Fix "multiple candidates for rmeta dependency core" error
> >> > >   powerpc/jump_label: adjust inline asm to be consistent
> >> > >   powerpc: Enable Rust for ppc64le
> >> > >=20
> >> > >  arch/powerpc/Kconfig                  |  2 +
> >> > >  arch/powerpc/Makefile                 |  7 +++
> >> > >  arch/powerpc/include/asm/jump_label.h | 23 ++++++----
> >> > >  rust/Makefile                         | 66 ++++++++++++++++------=
-----
> >> > >  4 files changed, 61 insertions(+), 37 deletions(-)
> >> > >=20
> >> > > --=20
> >> > > 2.53.0
> >> > >=20
> >> > >=20
> >> >=20
> >> > --=20
> >> > Link Mauve
> >> >=20
>=20


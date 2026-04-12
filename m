Return-Path: <linuxppc-dev+bounces-19659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15EDE937EA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2026 15:47:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftvzv5PZxz2yqP;
	Mon, 13 Apr 2026 01:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776008827;
	cv=none; b=CrYeeZyY0EU5TyBx24htBNvxbwwQ7I7S9WEuqCCtOYcKfVl1gEevv3wE8vR8SdisKu2PvGy6sm12DPBQacS3lHAUwCFuk2ZfMAjdYMHAkrVJ6qsp1HwX3pI/BgKNGSv/PD+kMfGBX8qifzcDrzcoN14Ajn77YSdf7sKHvnxKhjWdZbX4mMqVzTXUJpma+fu3FlzYj8xI0D+18h40CplL9guvkeenCCVJzrsnMSFfZDront7IS73zOcUdaEpaq68rK8YXNpNhZV5P+E+v6+S96rBP8+A7EKLX5DmPBsM35GuISwH5sq9qpS0Er3CFk0B1sgxI09wDy1gRtYi65O6o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776008827; c=relaxed/relaxed;
	bh=35Kb1G8diUXdcUeRO6z0zPQrKqyhuQE+qiXkqgMSh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F3CTbNmc7Ie3bXWYG2toTDKACGVzqhjv12m+pFyNDN4bKcbejLWGNHQhCYnjRriCPPw/Bxa75PSa5RjnAYFE+DYsQX0C3QJuyTuKQmRG7wrkiqkEntckFB6QWXrWLe9vGcyyKsn44lxyEX8ycNWWwfzu17/nZJaNNFul0Pa1FcbSoiMUFC1LzY1LzWpp52C72UhdgjBKUG0U/FpWeeBuf5of6LxzpqhzxCyoza+VYSbMWgzEN/22uQ6ARpuKzCCf4GZPmZhlv4mbyHXSl+tPEu1C3mKM45Xwle2tMHMputoNTbUCOFiUHnLQEp3XG9/4MIxHBkCi3QaLbVAiM/uYQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XXZn39WK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XXZn39WK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftvzs3b6vz2yqF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 01:47:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E93EB6014B;
	Sun, 12 Apr 2026 15:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADBFC19424;
	Sun, 12 Apr 2026 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776008816;
	bh=23dLLAcM76ajvHwVd9STiwBmiFsqBllnva76VnjCY0A=;
	h=Date:From:To:Cc:Subject:From;
	b=XXZn39WKLIgN3EAJkU5ENkWYZAuWvtD3iPiOn2ozgnaDOWxI5dBZ5BQmoFtFm2rE5
	 8SvYKVh+BiE2QtmOhZabXGgkkUUugDwoDYf8yxsZrEtcOf4wjIPBRyWiXDvNOmXVzB
	 tikHKggIoVLzkavDBwUeYVxmpCG98H5XVARlwPdNnSzNK1w5LM+Lxeg8tY3hNZAXBD
	 1UNYY56I3A9zV/+XMHzeoH8MDZhUK2JGiBLj7MVEywl6gQv2Fj6VG9OEJUWTyjAQji
	 OOXucRVnk+iJt7Nhg9VqjWOE/zvhkal2k4/PrKupY+JrxnbNbTlXSyxpO3xfjV1V4C
	 hOH6k+cYbW0tg==
Date: Sun, 12 Apr 2026 17:46:47 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Coffin <alex@cyberialabs.net>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	David Howells <dhowells@redhat.com>,
	Dodji Seketeli <dodji@seketeli.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	John Moon <john@jmoon.dev>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Yonghong Song <yonghong.song@linux.dev>, kernel-team@fb.com,
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev, loongarch@lists.linux.dev
Subject: [GIT PULL] Kbuild and Kconfig changes for v7.1
Message-ID: <adu-ZyIv47FnsVLI@levanger>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Coffin <alex@cyberialabs.net>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	David Howells <dhowells@redhat.com>,
	Dodji Seketeli <dodji@seketeli.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	John Moon <john@jmoon.dev>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Yonghong Song <yonghong.song@linux.dev>, kernel-team@fb.com,
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev, loongarch@lists.linux.dev
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WEAPSl/ZOh7quu+7"
Content-Disposition: inline


--WEAPSl/ZOh7quu+7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull these changes to Kbuild and Kconfig for v7.1.  Please let me
know if anything is incorrect and not matching your standards.

All changes have been in -next, most for several cycles without reported
problems.

Thanks and kind regards,
Nicolas

---

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git t=
ags/kbuild-7.1-1

for you to fetch changes up to 404927758daac5ec4594071e033c1fa6ee9ca9b6:

  kbuild: expand inlining hints with -fdiagnostics-show-inlining-chain (202=
6-04-07 21:48:44 +0200)

----------------------------------------------------------------
Kbuild/Kconfig updates for 7.1

Kbuild changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  * tools/build: Reject unexpected values for LLVM=3D

  * kbuild: uapi: remove usage of toolchain headers

  * kbuild: Switch from '-fms-extensions' to '-fms-anonymous-structs'
    when available (currently: clang >=3D 23.0.0)

  * kbuild: Reduce the number of compiler-generated suffixes for clang
    thin-lto build

  * kbuild: reduce output spam ("GEN Makefile") when building out of tree

  * check-uapi: improve portability for testing headers

  * uapi: also test UAPI headers against C++ compilers

  * kbuild: vdso_install: drop build ID architecture allow-list

  * checksyscalls: only run when necessary

  * Documentation: kbuild: Update the debug information notes in
    reproducible-builds.rst

  * kconfig: forbid multiple entries with the same symbol in a choice

  * kbuild: expand inlining hints with -fdiagnostics-show-inlining-chain


Kconfig changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  * kconfig: Error out on duplicated kconfig inclusion


Cc: Alexander Coffin <alex@cyberialabs.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bill Wendling <morbo@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dodji Seketeli <dodji@seketeli.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Helge Deller <deller@gmx.de>
Cc: John Moon <john@jmoon.dev>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Song Liu <song@kernel.org>
Cc: Thomas Wei=DFschuh <linux@weissschuh.net>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: kernel-team@fb.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev
Cc: loongarch@lists.linux.dev

----------------------------------------------------------------
Arnd Bergmann (3):
      check-uapi: link into shared objects
      check-uapi: honor ${CROSS_COMPILE} setting
      check-uapi: use dummy libc includes

Justin Stitt (1):
      kbuild: expand inlining hints with -fdiagnostics-show-inlining-chain

Masahiro Yamada (1):
      kconfig: forbid multiple entries with the same symbol in a choice

Nathan Chancellor (3):
      kbuild: Consolidate C dialect options
      kbuild: Use '-fms-anonymous-structs' if it is available
      Documentation: kbuild: Update the debug information notes in reproduc=
ible-builds.rst

Nicolas Schier (1):
      kconfig: Error out on duplicated kconfig inclusion

Thomas Wei=DFschuh (25):
      Documentation/llvm: drop note about LLVM=3D0
      tools/build: Reject unexpected values for LLVM=3D
      hexagon: uapi: Fix structure alignment attribute
      kbuild: uapi: test linux/bpf_perf_event.h on powerpc
      kbuild: uapi: deduplicate linux/bpf_perf_event.h exclusions
      kbuild: uapi: completely exclude linux/bpf_perf_event.h on nios2
      kbuild: uapi: only use dummy-include for headers which use libc
      kbuild: uapi: provide stub includes for some libc headers
      kbuild: uapi: use custom stub headers instead of libc ones
      kbuild: uapi: simplify libc dependency logic
      kbuild: uapi: remove now unneeded guard headers
      kbuild: reduce output spam when building out of tree
      kbuild: uapi: move some compiler arguments out of the command definit=
ion
      kbuild: uapi: move all include path flags together
      kbuild: uapi: handle UML in architecture-specific exclusion lists
      kbuild: uapi: provide a C++ compatible dummy definition of NULL
      kbuild: uapi: also test UAPI headers against C++ compilers
      kbuild: vdso_install: split out the readelf invocation
      kbuild: vdso_install: hide readelf warnings
      kbuild: vdso_install: gracefully handle images without build ID
      kbuild: vdso_install: drop build ID architecture allow-list
      checksyscalls: move path to reference table to a variable
      checksyscalls: fail on all intermediate errors
      checksyscalls: only run when necessary
      checksyscalls: move instance functionality into generic code

Yonghong Song (1):
      kbuild: Reduce the number of compiler-generated suffixes for clang th=
in-lto build

 Documentation/kbuild/llvm.rst                      |  4 --
 Documentation/kbuild/reproducible-builds.rst       |  7 ++-
 Kbuild                                             | 14 +++--
 Makefile                                           | 35 +++++++++---
 arch/arm64/kernel/vdso32/Makefile                  |  3 +-
 arch/hexagon/include/uapi/asm/sigcontext.h         |  2 +-
 arch/loongarch/vdso/Makefile                       |  2 +-
 arch/mips/Makefile                                 |  6 +-
 arch/parisc/boot/compressed/Makefile               |  2 +-
 arch/powerpc/boot/Makefile                         |  3 +-
 arch/s390/Makefile                                 |  3 +-
 arch/s390/purgatory/Makefile                       |  3 +-
 arch/x86/Makefile                                  |  6 +-
 arch/x86/boot/compressed/Makefile                  |  6 +-
 drivers/firmware/efi/libstub/Makefile              |  3 +-
 init/Kconfig                                       |  5 ++
 scripts/Makefile.vdsoinst                          |  7 ++-
 scripts/Makefile.warn                              |  5 --
 scripts/check-uapi.sh                              | 19 ++++---
 scripts/checksyscalls.sh                           | 11 +++-
 scripts/kconfig/lexer.l                            |  4 +-
 scripts/kconfig/lkc.h                              |  3 +-
 scripts/kconfig/parser.y                           | 15 ++---
 scripts/kconfig/tests/err_repeated_inc/Kconfig     |  3 +
 .../kconfig/tests/err_repeated_inc/Kconfig.inc1    |  4 ++
 .../kconfig/tests/err_repeated_inc/Kconfig.inc2    |  3 +
 .../kconfig/tests/err_repeated_inc/Kconfig.inc3    |  1 +
 scripts/kconfig/tests/err_repeated_inc/__init__.py | 10 ++++
 .../kconfig/tests/err_repeated_inc/expected_stderr |  2 +
 scripts/kconfig/util.c                             | 31 ++++++++++-
 tools/scripts/Makefile.include                     |  2 +
 usr/dummy-include/endian.h                         |  0
 usr/dummy-include/limits.h                         |  8 +++
 usr/dummy-include/netinet/if_ether.h               |  0
 usr/dummy-include/netinet/in.h                     |  0
 usr/dummy-include/stdbool.h                        |  7 ---
 usr/dummy-include/stddef.h                         | 13 +++++
 usr/dummy-include/stdint.h                         | 17 ++++++
 usr/dummy-include/stdlib.h                         |  7 ---
 usr/dummy-include/string.h                         | 12 ++++
 usr/dummy-include/sys/ioctl.h                      |  0
 usr/dummy-include/sys/socket.h                     | 12 ++++
 usr/dummy-include/sys/time.h                       |  3 +
 usr/dummy-include/sys/types.h                      |  0
 usr/dummy-include/time.h                           |  0
 usr/dummy-include/unistd.h                         |  0
 usr/include/Makefile                               | 65 ++++++++++++++----=
----
 47 files changed, 251 insertions(+), 117 deletions(-)
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/Kconfig
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/Kconfig.inc1
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/Kconfig.inc2
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/Kconfig.inc3
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/__init__.py
 create mode 100644 scripts/kconfig/tests/err_repeated_inc/expected_stderr
 create mode 100644 usr/dummy-include/endian.h
 create mode 100644 usr/dummy-include/limits.h
 create mode 100644 usr/dummy-include/netinet/if_ether.h
 create mode 100644 usr/dummy-include/netinet/in.h
 delete mode 100644 usr/dummy-include/stdbool.h
 create mode 100644 usr/dummy-include/stddef.h
 create mode 100644 usr/dummy-include/stdint.h
 delete mode 100644 usr/dummy-include/stdlib.h
 create mode 100644 usr/dummy-include/string.h
 create mode 100644 usr/dummy-include/sys/ioctl.h
 create mode 100644 usr/dummy-include/sys/socket.h
 create mode 100644 usr/dummy-include/sys/time.h
 create mode 100644 usr/dummy-include/sys/types.h
 create mode 100644 usr/dummy-include/time.h
 create mode 100644 usr/dummy-include/unistd.h

--=20
Nicolas

--WEAPSl/ZOh7quu+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmnbvloACgkQB1IKcBYm
EmnVJBAAlJvaCwNlI1ymaWQKEC+s4udzUKo5DuA14pw/3NgGhLasok1WZaWB0LUb
2D4NtXMeQLTFybnTE07rbHZwQ/fBpvyWNL0D9aL+bjHfYhkbJHIJIgnrTOJLn3IW
wJuPJgJDMvgmWKyXGRLjPEevSmKF10Aej8f0QIsXuv8IG8M0ZfpIohRV35Dot9w6
kRQC6lX0lYTfaBzp7IBMtY634rtzC9rHK+U1gkkvswuE2H26rm5TxeE1lL6Xecmf
pd16FUspWGCMMB6YFRz3hi4ZRIMhY3MgY6LvvcHNF0RDrdoEoqWFyKLd/l5X5CNq
HKbIrMJ4l5E4KCSw3rtaW/RzmcZjDtU1RLdXLomAhZU7sszIhyYOuptBVAncdKVC
Vo+lxm1kLlBRG4eQjCnA51HQZN7VbO54XSvWVmRioEUevu6wSA8UvSq7Kcufzg57
I9nn9kpwFqJZvQsNGIdDqEgIT5l3muX1Y89E723OqKZ9CoPl2meGrLQU69e4gGFc
R/nTDktzEFINZHVk72AwAWyjvE/IGx6mmogf1+4Zz7MK2Q5aeXejy6T5aZ0QMwtH
/290TxOxWlOqi3b57Quo0xJVltkA9WxCi++4hh0Te/x2Yjaqbaovui7fBjqeKvCh
Oh9AhNVYbTOjIMS2CyL6xQBlr+Vp2MQ163tqds1uSP3IqrS2T+8=
=WfCJ
-----END PGP SIGNATURE-----

--WEAPSl/ZOh7quu+7--


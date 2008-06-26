Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3164ADDF00
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 08:09:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Date: Fri, 27 Jun 2008 00:09:11 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261838.33787.arnd@arndb.de> <4863D87F.5060103@zytor.com>
In-Reply-To: <4863D87F.5060103@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806270009.12378.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Adrian Bunk <bunk@kernel.org>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com,
	Michal Simek <monstr@monstr.eu>, monstr@seznam.cz,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, H. Peter Anvin wrote:
> 
> The sanest way to do that would probably be something along the lines of:
> 
> -> Change include/asm-xxx to arch/xxx/include/asm

Sam Ravnborg is already working on this part.

> -> Create arch/generic
> -> Make sure arch/xxx/include/asm and arch/generic/include/asm are both 
> in the include path, in that order.
> 
> That would also get rid of the symlink.

It requires two more steps:

- change all remaining users of #include <asm-generic/*.h> to include
that file with the new name, e.g. #include <generic/asm/foo.h> if we
have it in the right path.
- change the way 'make headers_install' works so that the files get
installed to the right location in $PREFIX/include/asm/ instead of
$PREFIX/include/asm-generic/ for each header that does not exist
in arch/foo/include/asm.

These changes are probably somewhat controversial, and the first
one is much more invasive than the patches that Sam has, so I'd
not want to do them at the same time.

> On the other hand, the redirection isn't all that bad.

Agreed. I just have the hope that someone comes up with the magical
solution for this problem that makes it a lot nicer than the suggestions
so far or the current way of doing it ;-)

	Arnd <><

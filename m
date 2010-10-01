Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id C5C57B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:13:21 +1000 (EST)
Received: by iwn4 with SMTP id 4so3599724iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 00:13:19 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1285916771-18033-3-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-3-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 09:13:19 +0200
Message-ID: <AANLkTi=VmSXN6XeD__nkQLJAYXzxOh6WEtW6-jjJcC4Q@mail.gmail.com>
Subject: Re: [PATCH 02/18] powerpc: Add CROSSBE_COMPILE to build big endian
	boot wrapper
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 09:05, Ian Munsie <imunsie@au1.ibm.com> wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> Since the boot wrapper must be built by a big endian 32bit toolchain
> regardless of what the rest of the kernel is using introduce a new
> parameter to specify that toolchain - CROSSBE_COMPILE.
>
> We already have CROSS32_COMPILE which is already used for the boot
> wrapper, but it is also used to build the 32bit vdso which should be
> build in the same endianness as the rest of the kernel, so it is
> necessary to be able to specify the toolchain to build the boot wrapper
> separately from that used to build the vdso and again separately from
> that used to build the main kernel.
>
> CROSSBE_COMPILE should be pointed to a toolchain capable of targeting
> 32bit big endian powerpc, either specifically targetted at 32bit or
> bi-arch 64 and 32bit. If CROSSBE_COMPILE is not specified it will fall
> back to CROSS32_COMPILE to maintain compatibility with big endian
> targets.

Shouldn't the help text added by [PATCH 01/18]:

+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -329,3 +329,19 @@ config CHECK_CACHE_COHERENCY
       bool

 endmenu
+
+config ARCH_SUPPORTS_LITTLE_ENDIAN
+       bool
+
+config CPU_LITTLE_ENDIAN
+       bool "Build little endian kernel"
+       depends on ARCH_SUPPORTS_LITTLE_ENDIAN && EXPERIMENTAL
+       default n
+       help
+         This option selects whether a big endian or little endian kernel =
will
+         be built.
+
+         Note that if building a little endian kernel, CROSS_COMPILE must
+         point to a toolchain capable of targetting little endian powerpc,
+         while the toolchain specified by CROSS32_COMPILE must be capable =
of
+         targetting *BIG* endian PowerPC.

be updated here as well?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

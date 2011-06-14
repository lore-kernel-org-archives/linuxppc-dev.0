Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6413B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 06:32:15 +1000 (EST)
Received: by bwz10 with SMTP id 10so4751910bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 13:32:10 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Date: Tue, 14 Jun 2011 22:32:08 +0200
Message-ID: <BANLkTikuVsFS-UbS+Dap2Zy-f1+qLc1TLw@mail.gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
	Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2011 at 21:08, Ralf Baechle <ralf@linux-mips.org> wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
>
> =C2=A0 =C2=A0 =C2=A0 depends on (!SPARC64 || PCI) && !SPARC32 && !M32R &&=
 !FRV && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!M68K || ISA) && !MN103=
00 && !AVR32 && !BLACKFIN
>
> This isn't just ugly - it also almost certainly describes the dependencie=
s
> too coarse grainedly. =C2=A0This is an attempt at cleaing the mess up.

> --- a/arch/m68k/Kconfig.mmu
> +++ b/arch/m68k/Kconfig.mmu
> @@ -399,6 +399,7 @@ config ISA
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on Q40 || AMIGA_PCMCIA
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y
> + =C2=A0 =C2=A0 =C2=A0 select PARPORT_PC

Why do you select PARPORT_PC here instead of HAVE_PC_PARPORT?

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

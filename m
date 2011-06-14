Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10097B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 06:57:10 +1000 (EST)
Message-ID: <4DF7C3CA.9050902@zytor.com>
Date: Tue, 14 Jun 2011 13:25:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Chen Liqin <liqin.chen@sunplusct.com>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
	Mikael Starvik <starvik@axis.com>,
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

On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
> 
>        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> 
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.
> 
> I tried to faithfully aproximate the old behaviour but the existing
> behaviour seems inacurate if not wrong for some architectures or platforms.
> To improve on this I rely on comments from other arch and platforms
> maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> parallel port on the mainboard should probably should now do a
> select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> need it.
> 

Why on earth restrict it like that?  It's just a device driver, like
more or less any other device driver...

	-hpa

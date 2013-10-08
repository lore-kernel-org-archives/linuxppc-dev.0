Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x236.google.com (mail-ee0-x236.google.com
 [IPv6:2a00:1450:4013:c00::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47BFD2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 16:46:19 +1100 (EST)
Received: by mail-ee0-f54.google.com with SMTP id e53so3752161eek.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 22:46:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 8 Oct 2013 07:46:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v2 14/14] Kconfig cleanup (PARPORT_PC dependencies)
Message-ID: <20131008054610.GE14353@gmail.com>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
 <1381209030-351-15-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381209030-351-15-git-send-email-msalter@redhat.com>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Mark Salter <msalter@redhat.com> wrote:

> Remove messy dependencies from PARPORT_PC by having it depend on one
> Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> which need it, select ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> New architectures are unlikely to need PARPORT_PC, so this avoids
> having an ever growing list of architectures to exclude. Those
> architectures which do select ARCH_MAY_HAVE_PC_PARPORT in this
> patch are the ones which have an asm/parport.h (or use the generic
> version).
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: linux-alpha@vger.kernel.org
> CC: Vineet Gupta <vgupta@synopsys.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: linux-m68k@lists.linux-m68k.org
> CC: Michal Simek <monstr@monstr.eu>
> CC: microblaze-uclinux@itee.uq.edu.au
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-parisc@vger.kernel.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: Paul Mundt <lethal@linux-sh.org>
> CC: linux-sh@vger.kernel.org
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> ---
>  drivers/parport/Kconfig | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
> index 70694ce..a079b18 100644
> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -31,13 +31,17 @@ menuconfig PARPORT
>  
>  	  If unsure, say Y.
>  
> +config ARCH_MAY_HAVE_PC_PARPORT
> +	bool
> +	help
> +	  Select this config option from the architecture Kconfig if
> +	  the architecture may have PC parallel port hardware.
> +
>  if PARPORT
>  
>  config PARPORT_PC
>  	tristate "PC-style hardware"
> -	depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && !S390 && \
> -		(!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN && \
> -		!XTENSA && !CRIS && !H8300
> +	depends on ARCH_MAY_HAVE_PC_PARPORT
>  
>  	---help---
>  	  You should say Y here if you have a PC-style parallel port. All

Since it's not a permission to have a parallel port but a possibility,
I suspect the whole series needs a:

  s/MAY_HAVE/MIGHT_HAVE
  s/may have/might have

Otherwise:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

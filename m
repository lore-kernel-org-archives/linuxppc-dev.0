Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 108381007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 06:03:10 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 10/14] PM / MIPS: Use struct syscore_ops instead of
	sysdevs for PM
Date: Mon, 18 Apr 2011 22:03:15 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172312.35060.rjw@sisk.pl>
	<20110418101218.GA25325@linux-mips.org>
In-Reply-To: <20110418101218.GA25325@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201104182203.16171.rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, April 18, 2011, Ralf Baechle wrote:
> This patch breaks the Alchemy kernel compile; below patch on top of it fixes
> that again.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!  If you don't mind, I'd like to fold your patch into [10/14].

Rafael


> ---
>  arch/mips/alchemy/common/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-mips/arch/mips/alchemy/common/irq.c
> ===================================================================
> --- linux-mips.orig/arch/mips/alchemy/common/irq.c
> +++ linux-mips/arch/mips/alchemy/common/irq.c
> @@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
>  
>  static int __init alchemy_ic_syscore_init(void)
>  {
> -	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
> -	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
> +	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
> +	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
>  
>  	register_syscore_ops(&alchemy_ic_syscore_ops);
>  
> 
> 

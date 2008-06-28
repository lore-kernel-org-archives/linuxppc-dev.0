Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59EC5DDEFC
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 14:41:31 +1000 (EST)
Date: Sat, 28 Jun 2008 13:38:33 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 01/60] microblaze_v4: Kconfig patches
Message-ID: <20080628043833.GD25492@linux-sh.org>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214483429-32360-2-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:29:30PM +0200, monstr@seznam.cz wrote:
> +config HZ
> +	int
> +	default 100
> +
Consider using kernel/Kconfig.hz instead.

> +config DEFCONFIG_LIST
> +	string
> +	default "arch/$ARCH/defconfig"
> +
init/Kconfig already has quite a few reasonable defaults for this,
including the case you specify. You can kill this off.

> +source "init/Kconfig"
> +
> +source "arch/microblaze/platform/Kconfig.platform"
> +
> +menu "Processor type and features"
> +
> +config PREEMPT
> +	bool "Preemptible Kernel"
> +	help
> +	  This option reduces the latency of the kernel when reacting to
> +	  real-time or interactive events by allowing a low priority process to
> +	  be preempted even if it is in kernel mode executing a system call.
> +	  This allows applications to run more reliably even when the system is
> +	  under load.
> +
> +	  Say Y here if you are building a kernel for a desktop, embedded
> +	  or real-time system.  Say N if you are unsure.
> +
kernel/Kconfig.preempt

> +config LARGE_ALLOCS
> +	bool "Allow allocating large blocks (> 1MB) of memory"
> +	help
> +	  Allow the slab memory allocator to keep chains for very large
> +	  memory sizes - up to 32MB. You may need this if your system has
> +	  a lot of RAM, and you need to able to allocate very large
> +	  contiguous chunks. If unsure, say N.
> +
Legacy bits, not used anywhere anymore.

> +comment "Boot options"
> +
> +config CMDLINE
> +	string "Default kernel command string"
> +	default ""
> +	help
> +	  On some architectures there is currently no way for the boot loader
> +	  to pass arguments to the kernel. For these architectures, you should
> +	  supply some command-line options at build time by entering them
> +	  here.
> +
> +config CMDLINE_FORCE
> +	bool "Force default kernel command string"
> +	help
> +	  Set this to have arguments from the default kernel command string
> +	  override those passed by the boot loader.
> +
Consider CMDLINE_BOOL/CMDLINE for consistency with other architectures.
It doesn't make much sense to expose CMDLINE if you don't intend to use
it. Especially when people wonder why their CMDLINE changes are being
clobbered by the boot loader.

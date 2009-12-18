Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D02A51007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 01:33:17 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/6 v5] CPU probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com> <4AE8B072.1070603@austin.ibm.com>
Date: Fri, 18 Dec 2009 15:33:11 +0100
In-Reply-To: <4AE8B072.1070603@austin.ibm.com> (Nathan Fontenot's message of
	"Wed, 28 Oct 2009 15:58:26 -0500")
Message-ID: <m2oclw9wt4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@austin.ibm.com> writes:

> Index: powerpc/arch/powerpc/Kconfig
> ===================================================================
> --- powerpc.orig/arch/powerpc/Kconfig	2009-10-28 15:21:47.000000000 -0500
> +++ powerpc/arch/powerpc/Kconfig	2009-10-28 15:21:53.000000000 -0500
> @@ -320,6 +320,10 @@
>  
>  	  Say N if you are unsure.
>  
> +config ARCH_CPU_PROBE_RELEASE
> +	def_bool y
> +	depends on HOTPLUG_CPU
> +

That does not work.

drivers/built-in.o: In function `.store_online':
cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
make: *** [.tmp_vmlinux1] Error 1

cpu_hotplug_driver_lock is only defined on pseries, but HOTPLUG_CPU is
also defined on pmac.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

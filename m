Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts30-srv.bellnexxia.net (tomts30.bellnexxia.net
	[209.226.175.104]) by ozlabs.org (Postfix) with ESMTP id CC1B0DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 07:09:49 +1100 (EST)
Received: from toip6.srvr.bell.ca ([209.226.175.125])
	by tomts10-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20071228193008.HFIW1733.tomts10-srv.bellnexxia.net@toip6.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 14:30:08 -0500
Date: Fri, 28 Dec 2007 14:30:08 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Adrian Bunk <adrian.bunk@movial.fi>
Subject: Re: [2.6.24 patch] restore Cell OProfile support
Message-ID: <20071228193008.GB23157@Krystal>
References: <20071228185649.GC4738@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071228185649.GC4738@stusta.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, phil.el@wanadoo.fr,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Adrian Bunk (adrian.bunk@movial.fi) wrote:
> This patch restores the Cell OProfile support that was killed by
> commit 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9.
> 
> Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>
> 

Same here : why isn't this on by default when SPU_FS and OPROFILE are
enabled ?

> ---
> 
>  kernel/Kconfig.instrumentation |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 6d1446d35d367fdbdd2a0a29e0d156646ff40630 
> diff --git a/kernel/Kconfig.instrumentation b/kernel/Kconfig.instrumentation
> index a76635d..9d143e6 100644
> --- a/kernel/Kconfig.instrumentation
> +++ b/kernel/Kconfig.instrumentation
> @@ -53,2 +53,10 @@ config HARDWARE_PM
>  
> +config OPROFILE_CELL
> +	bool "OProfile for Cell Broadband Engine"
> +	depends on PPC && (SPU_FS = y && OPROFILE = m) || (SPU_FS = y && OPROFILE = y) 
> +	default y
> +	help
> +	  Profiling of Cell BE SPUs requires special support enabled
> +	  by this option.
> +
>  config KPROBES
> 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

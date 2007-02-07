Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8B485DDEF6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 01:28:28 +1100 (EST)
Date: Wed, 7 Feb 2007 15:28:26 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 3/3] PS3: System manager support
In-Reply-To: <45C8FFF7.7090805@am.sony.com>
Message-ID: <Pine.LNX.4.62.0702071527350.29060@pademelon.sonytel.be>
References: <45C8FFF7.7090805@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 Feb 2007, Geoff Levand wrote:
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
> @@ -42,6 +42,10 @@
>  #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
>  #endif
>  
> +#if !defined(CONFIG_SMP)
> +static void smp_send_stop(void) {}
> +#endif

Shouldn't this be added to include/linux/smp.h instead? That header file
already contains some dummy definitions for the non-SMP case.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

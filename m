Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39E94679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 03:15:32 +1000 (EST)
Date: Wed, 12 Apr 2006 19:15:20 +0200
From: Olaf Hering <olh@suse.de>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: [PATCH] 2 of 3   kdump-ppc64-soft-reset-fixes
Message-ID: <20060412171520.GA24681@suse.de>
References: <443ADCCE.1070504@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <443ADCCE.1070504@us.ibm.com>
Cc: akpm@osdl.org, fastboot@lists.osdl.org, mchintage@in.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Apr 10, David Wilder wrote:


> +++ 2617-rc1/arch/powerpc/kernel/crash.c	2006-04-05 13:24:19.000000000 -0700

> @@ -185,15 +277,14 @@ void default_machine_crash_shutdown(stru
>  	 * The kernel is broken so disable interrupts.
>  	 */
>  	local_irq_disable();
> -
> -	if (ppc_md.kexec_cpu_down)
> -		ppc_md.kexec_cpu_down(1, 0);
> -
>  	/*
>  	 * Make a note of crashing cpu. Will be used in machine_kexec
>  	 * such that another IPI will not be sent.

This change conflicts with the patch for interrupt shutdown. I guess
both patches are needed, as each one fixes a different bug?

http://ozlabs.org/pipermail/linuxppc-dev/2006-April/021855.html
[PATCH] powerpc: Disable and EOI interrupts in machine_crash_shutdown()

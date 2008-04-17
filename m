Return-Path: <neko@genesi-usa.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 05E36DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:28:51 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so33602nfd.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 05:28:49 -0700 (PDT)
Message-ID: <4807427B.3030902@genesi-usa.com>
Date: Thu, 17 Apr 2008 13:28:43 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
References: <1208105558.3026.137.camel@pmac.infradead.org>
In-Reply-To: <1208105558.3026.137.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I thought we were using efika.forth for this in Fedora.

Why don't we just roll all those fixes into prom_efika.c or something
and make it a huge, unwieldy file nice and *seperate* from prom_init.c?

:)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

David Woodhouse wrote:
> Fedora 9 works on Efika without the separate 'device-tree supplement',
> thanks to the kernel's own fixups. With one exception -- because 'CHRP'
> still appears on the 'machine:' line in /proc/cpuinfo, the installer
> misdetects the platform and misconfigures yaboot, putting it into a PReP
> boot partition instead of in the /boot filesystem where the Efika's
> firmware could find it.
> 
> The kernel's fixups for Efika already correct one instance of 'chrp', in
> the 'device_type' property. This fixes it in the 'CODEGEN,description'
> property too, since that's what's exposed to userspace in /proc/cpuinfo.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5ab4c84..723422e 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2240,6 +2240,14 @@ static void __init fixup_device_tree_efika(void)
>  	if (rv != PROM_ERROR && (strcmp(prop, "chrp") == 0))
>  		prom_setprop(node, "/", "device_type", "efika", sizeof("efika"));
>  
> +	/* CODEGEN,description is exposed in /proc/cpuinfo so
> +	   fix that too */
> +	rv = prom_getprop(node, "CODEGEN,description", prop, sizeof(prop));
> +	if (rv != PROM_ERROR && (strstr(prop, "CHRP")))
> +		prom_setprop(node, "/", "CODEGEN,description",
> +			     "Efika 5200B PowerPC System",
> +			     sizeof("Efika 5200B PowerPC System"));
> +
>  	/* Fixup bestcomm interrupts property */
>  	node = call_prom("finddevice", 1, 1, ADDR("/builtin/bestcomm"));
>  	if (PHANDLE_VALID(node)) {
> 
> 
> 

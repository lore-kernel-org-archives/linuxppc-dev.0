Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E812DDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:12:53 +1100 (EST)
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <11713184101239-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 10:12:45 +1100
Message-Id: <1171321965.20192.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static void __init fixup_device_tree_efika(void)
> +{
> +	/* Substitution table */
> +	#define prop_cstr(x) x, sizeof(x)
> +	int prop_sound_irq[3] = { 2, 2, 0 };
> +	int prop_bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
> +	                             3,4,0, 3,5,0, 3,6,0, 3,7,0,
> +	                             3,8,0, 3,9,0, 3,10,0, 3,11,0,
> +	                             3,12,0, 3,13,0, 3,14,0, 3,15,0 };
> +	struct subst_entry efika_subst_table[] = {
> +		{ "/",			"device_type",	prop_cstr("efika") },
> +		{ "/builtin",		"compatible",	prop_cstr("soc") },
> +		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
> +		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
> +		{ "/builtin/bestcomm",	"interrupts",	prop_bcomm_irq, sizeof(prop_bcomm_irq) },
> +		{ "/builtin/ethernet",	"compatible",	prop_cstr("mpc5200b-fec\0mpc5200-fec") },
> +		{ "/builtin/pic",	"compatible",	prop_cstr("mpc5200b-pic\0mpc5200-pic") },
> +		{ "/builtin/serial",	"compatible",	prop_cstr("mpc5200b-psc-uart\0mpc5200-psc-uart") },
> +		{ "/builtin/sound",	"compatible",	prop_cstr("mpc5200b-psc-ac97\0mpc5200-psc-ac97") },
> +		{ "/builtin/sound",	"interrupts",	prop_sound_irq, sizeof(prop_sound_irq) },
> +		{ "/builtin/sram",	"compatible",	prop_cstr("mpc5200b-sram\0mpc5200-sram") },
> +		{ "/builtin/sram",	"device_type",	prop_cstr("sram") },
> +		{}
> +	};
> +	#undef prop_cstr

What about making all of the above const ? Also I wonder wether it's
useful to mark the tables as static and __initdata  too...

> +
> +	rv = prom_getprop(node, "model", prop, sizeof(prop));
> +	if (rv == PROM_ERROR)
> +		return;
> +	if (strcmp(prop, "EFIKA5K2"))
> +		return;

Is there a version in their device-tree ? We might want to check in case
they ever fix it ...

Ben.

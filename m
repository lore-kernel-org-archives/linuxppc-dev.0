Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id ADDABDDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 17:27:38 +1100 (EST)
Message-ID: <47D4D686.8010101@denx.de>
Date: Mon, 10 Mar 2008 07:34:46 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [Patch] 8xx: MGSUVD support
References: <47D3B44D.8070909@denx.de>
	<20080310143217.11e2b10f.sfr@canb.auug.org.au>
In-Reply-To: <20080310143217.11e2b10f.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Stephen,

Stephen Rothwell wrote:
> On Sun, 09 Mar 2008 10:56:29 +0100 Heiko Schocher <hs@denx.de> wrote:
>> +++ b/arch/powerpc/platforms/8xx/mgsuvd.c
>>
>> +#include <asm/of_platform.h>
> 
> You should include linux/of_platform.h (not asm/)

Ok.

>> +static struct cpm_pin mgsuvd_pins[] = {
> 
> Make this __initdata, please.

Argh... forgot this.

[...]
>> +static struct of_device_id __initdata of_bus_ids[] = {
> 
> Make this __initdata, please.

Hmm.. it is __initdata, or? But I fix it to:

static  __initdata struct of_device_id of_bus_ids[]

>> +static int __init declare_of_platform_devices(void)
>> +{
>> +	if (!machine_is(mgsuvd))
>> +		return 0;
>> +
>> +	of_platform_bus_probe(NULL, of_bus_ids, NULL);
>> +
>> +	return 0;
>> +}
>> +device_initcall(declare_of_platform_devices);
> 
> This should be "machine_device_initcall(mgsuvd,
> declare_of_platform_devices);" then you don't need the machine_is() check
> above.

Ok

I will send a overworked patch.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

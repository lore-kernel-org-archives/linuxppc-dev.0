Return-Path: <albert_herranz@yahoo.es>
Received: from smtp103.mail.ukl.yahoo.com (smtp103.mail.ukl.yahoo.com
	[77.238.184.35]) by ozlabs.org (Postfix) with SMTP id C1371B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:02:27 +1100 (EST)
Message-ID: <4B0AEA51.2060907@yahoo.es>
Date: Mon, 23 Nov 2009 21:02:25 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 12/19] powerpc: gamecube: platform support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221534m6fcf14b3ted9dd181a0e264e4@mail.gmail.com>
In-Reply-To: <fa686aa40911221534m6fcf14b3ted9dd181a0e264e4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> Add platform support for the Nintendo GameCube video game console.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>> +static void gamecube_show_cpuinfo(struct seq_file *m)
>> +{
>> +       seq_printf(m, "vendor\t\t: IBM\n");
>> +       seq_printf(m, "machine\t\t: Nintendo GameCube\n");
>> +}
> 
> show_cpuinfo hooks have been dropped on most platforms now.
> 

I'll drop'em all. Thanks.

>> +static void gamecube_shutdown(void)
>> +{
>> +       /* currently not used */
>> +}
> 
> Then don't add the hook.  Just drop it.  Same for other empty
> functions in this file.  If it is safe to drop them, then please do.
> 
> Otherwise: Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 

I actually forgot to add a flipper_quiesce() call there.
That one will be used.

But I'll review the other cases. Thanks.

>> +define_machine(gamecube) {
>> +       .name                   = "gamecube",
>> +       .probe                  = gamecube_probe,
>> +       .setup_arch             = gamecube_setup_arch,
>> +       .init_early             = gamecube_init_early,
>> +       .show_cpuinfo           = gamecube_show_cpuinfo,
>> +       .restart                = gamecube_restart,
>> +       .power_off              = gamecube_power_off,
>> +       .halt                   = gamecube_halt,
>> +       .init_IRQ               = flipper_pic_probe,
>> +       .get_irq                = flipper_pic_get_irq,
>> +       .calibrate_decr         = generic_calibrate_decr,
>> +       .progress               = udbg_progress,
>> +       .machine_shutdown       = gamecube_shutdown,
>> +#ifdef CONFIG_KEXEC
>> +       .machine_kexec_prepare  = gamecube_kexec_prepare,
>> +       .machine_kexec          = default_machine_kexec,
>> +#endif
>> +};
>> +
>> diff --git a/arch/powerpc/platforms/embedded6xx/gamecube_dev.c b/arch/powerpc/platforms/embedded6xx/gamecube_dev.c
>> new file mode 100644
>> index 0000000..13e1f73
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/embedded6xx/gamecube_dev.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * arch/powerpc/platforms/embedded6xx/gamecube_dev.c
>> + *
>> + * Nintendo GameCube platform device setup.
>> + * Copyright (C) 2008-2009 The GameCube Linux Team
>> + * Copyright (C) 2008,2009 Albert Herranz
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <asm/machdep.h>
>> +
>> +static struct of_device_id gamecube_of_bus[] = {
>> +       { .compatible = "nintendo,flipper", },
>> +       { },
>> +};
>> +
>> +static int __init gamecube_device_probe(void)
>> +{
>> +       if (!machine_is(gamecube))
>> +               return 0;
>> +
>> +       of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
>> +       return 0;
>> +}
>> +device_initcall(gamecube_device_probe);

Cheers,
Albert

Message-ID: <40E54074.2010801@246tNt.com>
Date: Fri, 02 Jul 2004 13:01:08 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: mcclintock@freescale.com,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
References: <1088705955.28598.168.camel@localhost>	 <1088693987.7555.60.camel@matthew-laptop>	 <1088717127.28598.197.camel@localhost>  <40E49100.2060501@246tNt.com> <1088759103.936.24.camel@localhost>
In-Reply-To: <1088759103.936.24.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Adrian Cox wrote:

>The 5200 seems to have a different FDR implementation. I could include
>your calculation code if you can tell me where the value of ipb_freq
>should come from.
>
>
That would be nice.
The ipb_freq value is given by the boot loader or computed at run-time
if the boot loader don't give it.

#include <asm/ppcboot.h>
extern bd_t __res;
u32 ipbfreq = __res.bi_ipbfreq;

But this field will only exists when :
 - CONFIG_PPC_MPC52xx symbol is defined.
 - When the MPC52xx patch is applied to the kernel

Also, there is no DFSRR register on the 5200.

>I don't currently do a calculation on the 107, but pick a slow value for
>safety. I'd need more platform specific knowledge to do the calculation,
>as the 107/824x scale from the SDRAM clock, and the 85xx scales from the
>CCB clock.
>
>
Well yes, I guess that where the I2C modules takes it's clock from is
dependent of each platform.

>Are you sure that it changes from MAL to NORXACK after seeing a device?
>It looks to me that it returns MAL only on the bus without devices,
>probably due to lack of pull-up resistors.
>
>
Yes, indeed, looking at the schematics indicates that it's not even I2C
and it's disabled by the port multiplexing config. I've suppressed that
entry in my ocp definition.

>> - The interrupt bit. BTW, on what event should the interrupt be fired ?
>>(I did my test without any interrupts )
>>
>>
>
>To use my driver, just set IE1 and IE2. The other flags are for a
>different approach using DMA to load the TX and RX registers. That would
>give a lower CPU overhead, but would also require a separate driver.
>
>
>
Are you sure ? If I don't set the BNBE (Bus Not Busy Enable) bit, I just
get timeouts.

>In fact, the reset value of this register is correct. The easiest fix
>may be for platform code to ensure that the register has the correct
>value, in case boot firmware changed it.
>
>
Yes sure, that's the easiest way. It's just that I'd like to avoid it.
Especially when it's content is dependent on if the user has choosed to
use irq or not.
But It's sure is a pity that the register is shared between the two I2C
... Because even with a flag, the driver should be passed the address of
this register, and what bits to use.

>>Another remark : The register setup are done at every _start. Couldn't
>>they be done once for all during init ( just after the probe, call a
>>init_hardware functions ).
>>
>>
>
>Yes, the frequency settings could be done once on startup. I might try
>that.
>
>
Thanks.
Computing the FDR each time is a little overkill ;)


Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

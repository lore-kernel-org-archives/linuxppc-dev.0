Subject: Re: [PATCH][RFC]Updated MPC I2C driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: mcclintock@freescale.com,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>
In-Reply-To: <40E54074.2010801@246tNt.com>
References: <1088705955.28598.168.camel@localhost>
	 <1088693987.7555.60.camel@matthew-laptop>
	 <1088717127.28598.197.camel@localhost>  <40E49100.2060501@246tNt.com>
	 <1088759103.936.24.camel@localhost>  <40E54074.2010801@246tNt.com>
Content-Type: text/plain
Message-Id: <1088775864.933.60.camel@localhost>
Mime-Version: 1.0
Date: Fri, 02 Jul 2004 14:44:25 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It looks to me that supporting the 5200 will require a lot of small
changes.

On Fri, 2004-07-02 at 12:01, Sylvain Munaut wrote:

> #include <asm/ppcboot.h>
> extern bd_t __res;
> u32 ipbfreq = __res.bi_ipbfreq;
>
> But this field will only exists when :
>  - CONFIG_PPC_MPC52xx symbol is defined.
>  - When the MPC52xx patch is applied to the kernel

Maybe we should define two more fields in the ocp_fs_i2c_data structure:
one for base clock, and one for i2c clock. Then platform code could fill
in the clocks as necessary.

> Also, there is no DFSRR register on the 5200.

I noticed that. I don't think anybody ever used anything but the default
value on the other chips.

> >To use my driver, just set IE1 and IE2. The other flags are for a
> >different approach using DMA to load the TX and RX registers. That would
> >give a lower CPU overhead, but would also require a separate driver.

> Are you sure ? If I don't set the BNBE (Bus Not Busy Enable) bit, I just
> get timeouts.

>From the manual it looks as if setting BNBE might cause extra
interrupts, which the driver has no way to handle.  Could you try
enabling the interrupts, and see if this happens?

> Yes sure, that's the easiest way. It's just that I'd like to avoid it.
> Especially when it's content is dependent on if the user has choosed to
> use irq or not.
> But It's sure is a pity that the register is shared between the two I2C
> ... Because even with a flag, the driver should be passed the address of
> this register, and what bits to use.

How about putting a function pointer for platform interrupt enabling and
disabling into the ocp_fs_i2c_data?

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <40E57B08.3010204@246tNt.com>
Date: Fri, 02 Jul 2004 17:11:04 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: mcclintock@freescale.com,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
References: <1088705955.28598.168.camel@localhost>	 <1088693987.7555.60.camel@matthew-laptop>	 <1088717127.28598.197.camel@localhost>  <40E49100.2060501@246tNt.com>	 <1088759103.936.24.camel@localhost>  <40E54074.2010801@246tNt.com> <1088775864.933.60.camel@localhost>
In-Reply-To: <1088775864.933.60.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Adrian Cox wrote:

>On Fri, 2004-07-02 at 12:01, Sylvain Munaut wrote:
>
>
>
>>#include <asm/ppcboot.h>
>>extern bd_t __res;
>>u32 ipbfreq = __res.bi_ipbfreq;
>>
>>But this field will only exists when :
>> - CONFIG_PPC_MPC52xx symbol is defined.
>> - When the MPC52xx patch is applied to the kernel
>>
>>
>
>Maybe we should define two more fields in the ocp_fs_i2c_data structure:
>one for base clock, and one for i2c clock. Then platform code could fill
>in the clocks as necessary.
>
>
Yes, that's a good idea. It would need a flag to tell which clock
computation to take though.
Maybe instead of passing the baseclock, giving a pointer to a u32 that
contains the clock would be more appropriate. Since all board have
probably an int somewhere holding that value, you can put de definition
in the ocp_def without any further modifications.

>>Also, there is no DFSRR register on the 5200.
>>
>>
>
>I noticed that. I don't think anybody ever used anything but the default
>value on the other chips.
>
>
Yes. I've seen that the DFSRR is not as the same place. So maybe we
would need a two bits flag
like
#define FS_I2C_NO_DFSRR 0x00
#define FS_I2C_PACKED_DFSRR  0x02
#define FS_I2C_SEPARATE_DFSRR 0x04


>>Are you sure ? If I don't set the BNBE (Bus Not Busy Enable) bit, I just
>>get timeouts.
>>
>>
>
>>From the manual it looks as if setting BNBE might cause extra
>interrupts, which the driver has no way to handle.  Could you try
>enabling the interrupts, and see if this happens?
>
>
>
>>Yes sure, that's the easiest way. It's just that I'd like to avoid it.
>>Especially when it's content is dependent on if the user has choosed to
>>use irq or not.
>>But It's sure is a pity that the register is shared between the two I2C
>>... Because even with a flag, the driver should be passed the address of
>>this register, and what bits to use.
>>
>>
>
>How about putting a function pointer for platform interrupt enabling and
>disabling into the ocp_fs_i2c_data?
>
>
Well, you're right setting the BNBE is not right, it just hang because
interrupts are fired and not handled.
Now, here is the interesting part :
If I set the ocp_def to use both I2C controller, defining the I2C1
before I2C2, it works fine. Now if I just invert the entry, it does not.
Interrupts for I2C2 are never fired.
If I only put I2C1, it seems to work ( no timout). With only I2C2,
interrupts are never fired ...

I have no clue why ! The best option is just to set IRQ to OCP_IRQ_NA,
and it works fine, whatever the value of the shared interrupt registers is.

>It looks to me that supporting the 5200 will require a lot of small
>changes.
>
>
Well, for the interrupt yes that a quirk. The solution of dropping
interrupt completly for it is the best option for now.
For the DFSRR register, the solution mentionned above is clean, the 3
chips requires different implementation anyway.
For the clock thing, I think it's good to be able to set the I2C clock.


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

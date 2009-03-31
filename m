Return-Path: <wg@grandegger.com>
Message-ID: <49D27775.1050304@grandegger.com>
Date: Tue, 31 Mar 2009 22:05:09 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
References: <20090331125028.066613801@denx.de>	
	<20090331125451.600446749@denx.de>	
	<20090331133953.GB3044@pengutronix.de>	
	<49D21EF1.9050200@grandegger.com>	
	<20090331135629.GC3044@pengutronix.de>
	<fa686aa40903310844j11a85fb6w3558923e12670ba9@mail.gmail.com>
In-Reply-To: <fa686aa40903310844j11a85fb6w3558923e12670ba9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> 2009/3/31 Wolfram Sang <w.sang@pengutronix.de>:
>>>>> -
>>>>> -  mpc_i2c_setclock(i2c);
>>>>> +
>>>>> +  if (set_clock)
>>>>> +          mpc_i2c_setclock(i2c);
>>>> Can't we drop 'set_clock' with something like this here?
>>>>
>>>> +   if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
>>>> +
>>>> +           if (of_get_property(op->node, "dfsrr", NULL))
>>>> +                   i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
>>>> +
>>>> +           if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
>>>> +               of_device_is_compatible(op->node, "mpc5200-i2c"))
>>>> +                   i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
>>>> +
>>>> +           mpc_i2c_setclock(i2c);
>>>> +   }
>>> No, because the I2C registers are not yet mapped.
>> Sorry, I used misleading words :) With 'here' I meant 'at this
>> position', i.e. insert my above block where mpc_i2c_setclock was used
>> anyway.
> 
> I agree.  The extra flag makes the flow more complex.  The code block
> should be moved down.

OK, I just resent the patch standalone also including documentation. I
think it can go in immediately without waiting for the full clock
setting patch.

Wolfgang.

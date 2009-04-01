Return-Path: <wg@grandegger.com>
Message-ID: <49D3723B.5030107@grandegger.com>
Date: Wed, 01 Apr 2009 15:55:07 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
References: <20090331123727.853787299@denx.de>		<20090331124035.908249543@denx.de>		<fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>		<49D31D1D.6020004@grandegger.com>	<fa686aa40904010630l798528efh465a7543a15f50e5@mail.gmail.com>
	<49D36F1F.2050107@grandegger.com>
In-Reply-To: <49D36F1F.2050107@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Grant Likely wrote:
>> On Wed, Apr 1, 2009 at 1:51 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> Grant Likely wrote:
>>>> The table definition is more verbose this way, but I think it results
>>>> in more understandable and easier to extend code.  It also adds lets
>>>> the compiler do more type checking for you.
>>> OK but I don't like the callback function to do the settings. We need
>>> backward compatibility with old DTS files including the ugly "dfsrr"
>>> property, right? Then it seems consequent to continue using i2c->flags
>>> for that purpose and not to introduce another method. If we don't need
>>> backward compatibility, we could drop the flags completely and just use
>>> callback functions.
>> I don't understand why you don't like it.  It's an elegant solution
>> and it simplifies the code somewhat.  After grabbing the callback
>> pointer the compatibility code can simply override it.  But I won't
>> belabor the point or oppose the patch if you stick with the flags
>> pointer.
> 
> I changed my mind ;-). Have a look to PATCH v2 I sent out a few minutes ago.
> 
>>>>> --- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c 2009-03-31 13:25:08.000000000 +0200
>>>>> +++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c      2009-03-31 13:28:54.309718526 +0200
>>>>> +int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_flags)
>>>>> +{
>>>>> [...]
>>>>> +}
>>>>> +EXPORT_SYMBOL(fsl_i2c_get_fdr);
>>>> does not work on a multiplatform kernel.  Both 8xxx and 52xx support
>>>> can be selected at the same time.
>>> OK, then we need different functions including stubs.
>> I've been thinking about this more.  These tables are only ever going
>> to be used by the i2c_mpc driver and so really they are a part of the
>> i2c_mpc driver itself.  Putting them into common code doesn't make any
>> sense because it is not common code.  I will not merge a patch that
>> puts them into mpc5200 common code.
> 
> It's not common code, I agree. How about putting it into mpc52xx_i2c.c
> and use:
> 
>   $ cat Makefile
>   obj-$(CONFIG_I2C_MPC) += mpc52xx_i2c.o

That not a good idea either. I just checked the I2C interface of the
MPC512x and it can use the same table then the MPC5200B.

Wolfgang.

Return-Path: <wg@grandegger.com>
Message-ID: <49D4617C.4030702@grandegger.com>
Date: Thu, 02 Apr 2009 08:55:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
References: <20090331123727.853787299@denx.de>	
	<20090331124035.908249543@denx.de>	
	<fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>	
	<49D31D1D.6020004@grandegger.com>	
	<fa686aa40904010630l798528efh465a7543a15f50e5@mail.gmail.com>	
	<49D36F1F.2050107@grandegger.com>
	<fa686aa40904010655i73819214m795939e784889267@mail.gmail.com>
In-Reply-To: <fa686aa40904010655i73819214m795939e784889267@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Apr 1, 2009 at 7:41 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Grant Likely wrote:
>>> On Wed, Apr 1, 2009 at 1:51 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>>> Grant Likely wrote:
>>>>> The table definition is more verbose this way, but I think it results
>>>>> in more understandable and easier to extend code.  It also adds lets
>>>>> the compiler do more type checking for you.
>>>> OK but I don't like the callback function to do the settings. We need
>>>> backward compatibility with old DTS files including the ugly "dfsrr"
>>>> property, right? Then it seems consequent to continue using i2c->flags
>>>> for that purpose and not to introduce another method. If we don't need
>>>> backward compatibility, we could drop the flags completely and just use
>>>> callback functions.
>>> I don't understand why you don't like it.  It's an elegant solution
>>> and it simplifies the code somewhat.  After grabbing the callback
>>> pointer the compatibility code can simply override it.  But I won't
>>> belabor the point or oppose the patch if you stick with the flags
>>> pointer.
>> I changed my mind ;-). Have a look to PATCH v2 I sent out a few minutes ago.
> 
> I saw and I like.  :-)
> 
>>> I've been thinking about this more.  These tables are only ever going
>>> to be used by the i2c_mpc driver and so really they are a part of the
>>> i2c_mpc driver itself.  Putting them into common code doesn't make any
>>> sense because it is not common code.  I will not merge a patch that
>>> puts them into mpc5200 common code.
>> It's not common code, I agree. How about putting it into mpc52xx_i2c.c
>> and use:
>>
>>  $ cat Makefile
>>  obj-$(CONFIG_I2C_MPC) += mpc52xx_i2c.o
>>
>> Or it could be moved back to the i2c_mpc driver and we add stubs for the
>> functions to get the bus frequency, or use #ifdef's.
> 
> I'm happy with either as long as it lives in the same directory as the
> i2c_mpc driver, and as long as the i2c maintainers are okay with it.

Ben, any preference here? See also below.

> Oh, and if you use a separate file it should be statically linked into
> the i2c_mpc module using the i2c_mpc-$(CONFIG_WHATEVER) trick.  No
> EXPORT_SYMBOLS should be needed.

Yep, then we would have in "drivers/i2c/busses/Makefile"

  obj-$(CONFIG_I2C_MPC)           += i2c-mpc.o
    i2c-mpc-y = i2c-mpc.o
    i2c-mpc-$(CONFIG_FSL_SOC) += i2c-mpc-8xxx.o
    i2c-mpc-$(CONFIG_PPC_52xx) += i2c-mpc-52xx.o

And a common include file i2c-mpc.h including the stubs for the arch
dependent functions. But we may get in trouble when we need support for
the MPC512x. I currently tend to add the FDR related code to an extra
file i2c-mpc-fdr.c, plus i2c-mpc.h and use the good old #ifdef's to
select the relevant code.

Wolfgang.

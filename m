Return-Path: <wg@grandegger.com>
Message-ID: <487E57F6.7020602@grandegger.com>
Date: Wed, 16 Jul 2008 22:20:06 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
References: <487DD1BD.8040701@grandegger.com>
	<20080716142436.GD24045@secretlab.ca>
In-Reply-To: <20080716142436.GD24045@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Jul 16, 2008 at 12:47:25PM +0200, Wolfgang Grandegger wrote:
>> Currently, the I2C buses are probed for HWMON I2C devices, which might
>> not be acceptable in same cases. This patch makes device probing
>> configurable through the property "probe" of the FDT I2C device node:
>>
>>       i2c@3000 {
>>            ...
>>            compatible = "fsl-i2c";
>>            probe;
>> 	    ...
>>        };
> 
> You need to add documentation to booting-without-of.txt about what the
> 'probe' property means.  Also, 'probe' is a pretty generic term being
> used in an i2c specific context.  Can you prefix it with i2c or
> something to protect the namespace?  'i2c-probe' perhaps?

Of course, no problem. I'm also aware of booting-without-of.txt but 
first I wanted to bring up the problem-
> 
>> Assuming that systems using fsl-i2c should have proper platform data,
>> probing is disabled by default. Unfortunately, that's not the case and
>> various DTS files would require to be updated.
> 
> This comment doesn't seem to be correct.

Well, maybe it's due to my bad English. What I wanted to say is that by 
default probing should be disabled. But that requires various DTS files 
to be fixed.

> 
>> ---
>> arch/powerpc/sysdev/fsl_soc.c |    4 ++++
>> drivers/i2c/busses/i2c-mpc.c  |   17 ++++++++++++++---
>> include/linux/fsl_devices.h   |    1 +
> 
> This will need to be reworked for current top of tree.  i2c-mpc
> dependence on fsl_soc.c has been removed.

I kown. Will prepare a new patch a.s.a.p.

Wolfgang.

Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
Date: Thu, 31 Jul 2008 14:35:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 2:32 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/31/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Timur Tabi wrote:
>>
>> > Wolfgang Grandegger wrote:
>> >
>> >
>> > > But clock-frequency, aka bus-frequency, is already used by
>> fsl_get_sys_freq():
>> > >
>> > >
>> http://lxr.linux.no/linux+v2.6.26/arch/powerpc/sysdev/fsl_soc.c#L80
>> > >
>> >
>> > So?  clock-frequency is a per-node property.  I use it in the codec node
>> on the
>> > 8610 (mpc8610_hpcd.dts).  It does not mean "platform clock frequency".
>> >
>> >
>> > > U-Boot could then fixup that value like bus-frequency() and the i2c-mpc
>> driver simply calls fsl_get_i2c_freq().
>> > >
>> >
>> > This is just more complicated than it needs to be.  Why should the I2C
>> driver
>> > fetch the platform clock and the divider from the parent node, and then do
>> > additional math, when it could just get the value it needs right from the
>> node
>> > it's probing?
>> >
>>
>>  I'm a bit confused. The frequency of the I2C source clock and the real I2C
>> clock frequency are two different things. The first one is common for all
>> I2C devices, the second can be different. What properties would you like to
>> use for defining both?

How is the divider controlled?  Is it a fixed property of the SoC? a
shared register setting? or a register setting within the i2c device?
(My answer depends on the layout)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

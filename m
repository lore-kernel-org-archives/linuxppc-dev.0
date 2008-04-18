Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3496DE1AD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 14:19:53 +1000 (EST)
Message-Id: <E0A0E0FF-C2D5-432B-86A4-59AF23D3B63F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: cbouatmailru@gmail.com
In-Reply-To: <20080417224740.GA25323@zarina>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
Date: Thu, 17 Apr 2008 23:19:39 -0500
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192832.GA28286@polina.dev.rtsoft.ru>
	<20080417224740.GA25323@zarina>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 5:47 PM, Anton Vorontsov wrote:
> On Thu, Apr 17, 2008 at 11:28:32PM +0400, Anton Vorontsov wrote:
>> GTM stands for General-purpose Timers Module and able to generate
>> timer{1,2,3,4} interrupts. These timers are used by the drivers that
>> need time precise interrupts (like for USB transactions scheduling =20=

>> for
>> the Freescale USB Host controller as found in some QE and CPM chips),
>> or these timers could be used as wakeup events from the CPU deep-=20
>> sleep
>> mode.
>>
>> Things unimplemented:
>> 1. Cascaded (32 bit) timers (1-2, 3-4).
>>   This is straightforward to implement when needed, two timers should
>>   be marked as "requested" and configured as appropriate.
>> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>>   This is also straightforward to implement when needed, all timers
>>   should be marked as "requested" and configured as appropriate.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> Documentation/powerpc/booting-without-of.txt |   32 +++-
>> arch/powerpc/Kconfig                         |    5 +
>> arch/powerpc/sysdev/Makefile                 |    1 +
>> arch/powerpc/sysdev/fsl_gtm.c                |  362 ++++++++++++++++=20=

>> ++++++++++
>> include/asm-powerpc/fsl_gtm.h                |  108 ++++++++
>> 5 files changed, 507 insertions(+), 1 deletions(-)
>> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
>> create mode 100644 include/asm-powerpc/fsl_gtm.h
>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/=20
>> Documentation/powerpc/booting-without-of.txt
>> index 4cc7800..827b630 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
> [...]
>> +/**
>> + * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
>> + * @tmr:	pointer to the gtm_timer structure obtained from =20
>> gtm_get_timer
>> + * @usec:	timer interval in microseconds
>> + * @reload:	if set, the timer will reset upon expiry rather than
>> + *         	continue running free.
>> + *
>> + * This function (re)sets the GTM timer so that it counts up to =20
>> the requested
>> + * interval value, and fires the interrupt when the value is =20
>> reached. This
>> + * function will reduce the precision of the timer as needed in =20
>> order for the
>> + * requested timeout to fit in a 16-bit register.
>> + */
>> +int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec, =20
>> bool reload)
>> +{
>> +	/* quite obvious, frequency which is enough for =C2=B5Sec =
precision */
>> +	int freq =3D 1000000;
>> +	unsigned int bit;
>> +
>> +	bit =3D fls_long(usec);
>> +	if (bit > 15) {
>> +		freq >>=3D bit - 15;
>> +		usec >>=3D bit - 15;
>> +	}
>
> if (!freq)
> 	return -EINVAL;

do you want me to fix this up on commit or are you going to respin the =20=

patch set based on feedback?

- k=

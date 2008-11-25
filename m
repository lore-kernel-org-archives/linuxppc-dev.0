Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id DCBF6DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 03:26:16 +1100 (EST)
In-Reply-To: <20081123002615.GW6830@localdomain>
References: <20081122030653.GU6830@localdomain>
	<f35ce64a4d02ccbf84d3288dad3dc0f8@bga.com>
	<20081123002615.GW6830@localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c5d656532783550a8b21bb027497160a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: badness in xics_set_cpu_giq on JS20 blade
Date: Tue, 25 Nov 2008 10:31:15 -0600
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 22, 2008, at 6:26 PM, Nathan Lynch wrote:
> Milton Miller wrote:
>> On Sat Nov 22 at 14:06:53 EST in 2008, Nathan Lynch wrote:
>>> With 2.6.28-rc5 the WARN_ON in xics_set_cpu_giq is triggering on a
>>> JS20.  I changed it to a WARN to get the actual status returned:

>> b4963255ad5a426f04a0bb15c4315fa4bb40cde9 "Factor out cpu
>> joining/unjoining the GIQ" consolidated the join and remove call 
>> sites.
>> Looking closer it also added warn if rtas-indicator returned an error 
>> on
>> join in addition to leave.
>
> Thanks, that makes it clear why we didn't see the warning before.
>
>> When we get control of a cpu from OF it is already in the joined 
>> state.
>> We join on all threads because we need to do so on secondary threads 
>> and
>> because we did a remove on (previously all, but now secondary) threads
>> during kexec.
>>
>> If memory serves, there is a property in the rtas node to indicate 
>> each
>> sensor that is present.  If so, we should search for that property
>> before calling set-indicator.
>
> I checked PAPR; it looks like we should be looking for an
> rtas-indicators property, which doesn't exist on this system.  It does
> exist on Power5 and Power6 systems I've checked, and it has the
> expected entry for GIQ (9005).
>
> Something like this?  I've booted it on the problem JS20 as well as
> Power5 and 6.

Pretty close.  We need to turn the above text into a changelog and a 
few comments below.

We should also check JS21 and cell blade.

>
>  arch/powerpc/include/asm/rtas.h       |    1 +
>  arch/powerpc/kernel/rtas.c            |   22 ++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/xics.c |   11 ++++++++---
>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/rtas.h 
> b/arch/powerpc/include/asm/rtas.h
> index 8eaa7b2..4846f1f 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -168,6 +168,7 @@ extern void rtas_os_term(char *str);
>  extern int rtas_get_sensor(int sensor, int index, int *state);
>  extern int rtas_get_power_level(int powerdomain, int *level);
>  extern int rtas_set_power_level(int powerdomain, int level, int 
> *setlevel);
> +extern bool rtas_indicator_present(int indicator);
>  extern int rtas_set_indicator(int indicator, int index, int 
> new_value);
>  extern int rtas_set_indicator_fast(int indicator, int index, int 
> new_value);
>  extern void rtas_progress(char *s, unsigned short hex);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 1f8505c..6cd2434 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -566,6 +566,28 @@ int rtas_get_sensor(int sensor, int index, int 
> *state)
>  }
>  EXPORT_SYMBOL(rtas_get_sensor);
>
> +bool rtas_indicator_present(int indicator)
> +{
> +	int proplen, count, i;
> +	const struct indicator_elem {
> +		u32 token;
> +		u32 maxindex;
> +	} *indicators;
> +
> +	indicators = of_get_property(rtas.dev, "rtas-indicators", &proplen);
> +	if (!indicators)
> +		return false;
> +
> +	count = proplen / sizeof(struct indicator_elem);
> +
> +	for (i = 0; i < count; i++)
> +		if (indicators[i].token == indicator)
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(rtas_indicator_present);

I didn't look at the stuff we do to create the indicator directory in 
/proc/rtas.  Should this take an optional pointer arg to return the max 
count?  Just noticing that we are ignoring the count parameter.


> +
>  int rtas_set_indicator(int indicator, int index, int new_value)
>  {
>  	int token = rtas_token("set-indicator");
> diff --git a/arch/powerpc/platforms/pseries/xics.c 
> b/arch/powerpc/platforms/pseries/xics.c
> index e190477..7f8fa33 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -728,9 +728,14 @@ static void xics_set_cpu_priority(unsigned char 
> cppr)
>  /* Have the calling processor join or leave the specified global 
> queue */
>  static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
>  {
> -	int status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
> -		(1UL << interrupt_server_size) - 1 - gserver, join);
> -	WARN_ON(status < 0);
> +	int status;
> +
> +	if (!rtas_indicator_present(GLOBAL_INTERRUPT_QUEUE))
> +		return;

I was thinking we would cache this result, but we don't save the token 
for rtas_set_indicator_fast and we only call this twice per cpu on each 
kernel (startup and kexec) so I'm ok with it.  (Athought it points out 
we are parsing the device tree in the kdump path).

> +
> +	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
> +			(1UL << interrupt_server_size) - 1 - gserver, join);
> +	WARN(status < 0, "set-indicator returned %d\n", status);

This WARN should at least indicate which indicator we are trying to set 
(GLOBAL_INTERRUPT_QUEUE), if not the number (which is likely to always 
be 0 and not checked by current firmware).  That way we won't have to 
remember that the set-indicator in xics.c is to adjust cpu irq 
distribution when looking at the warning in the future.

>  }
>
>  void xics_setup_cpu(void)
>

thanks,
milton

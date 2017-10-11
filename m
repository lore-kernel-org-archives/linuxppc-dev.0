Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBsCK03JqzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 22:27:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: Avoid the secondary hold spinloop
 for OPAL boot
In-Reply-To: <20171011045216.5108425b@roar.ozlabs.ibm.com>
References: <20171006061005.29891-1-npiggin@gmail.com>
 <20171006061005.29891-2-npiggin@gmail.com>
 <87efqbw93h.fsf@concordia.ellerman.id.au>
 <20171010214357.2b6694fa@roar.ozlabs.ibm.com>
 <20171011015828.03f4aacc@roar.ozlabs.ibm.com>
 <20171011045216.5108425b@roar.ozlabs.ibm.com>
Date: Wed, 11 Oct 2017 22:27:23 +1100
Message-ID: <874lr5zzz8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 11 Oct 2017 01:58:28 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>
>> Ahh okay, pseries is using the start-cpu RTAS call to enter at
>> generic_secondary_smp_init() as well. So we can take it out for
>> pseries as well.
>
> This patch seems to do the trick for pseries guests too:
>
> powerpc/64s: Avoid waiting for secondary hold spinloop if it is not used
>
> OPAL and some RTAS boot does not insert secondaries at 0x60 to wait at
> the secondary hold spinloop. Instead they are started later, at
> generic_secondary_smp_init(), which is after the secondary hold
> spinloop.
>
> Avoid waiting on this spinloop when booting with OPAL firmware, or
> when the RTAS boot does not use this loop. This wait always times
> out in those cases.
>
> This saves 100ms boot time on bare metal (10s of seconds of real time
> when booting on the simulator in SMP), and 100ms on modern pseries
> guests.

My instinct was to say "huh, that's not how it works on pseries!".

But then I see this was all changed in:

  dbe78b401186 ("powerpc/pseries: Do not start secondaries in Open Firmware") (Sep 2013)


So that is where my confusion comes from. Most of the code and comments
still talk about secondaries coming in at 0x60, but that's really only
on "legacy" machines.

I guess I can merge this, but really this code needs a proper cleanup. I
dislike all this platform specific knowledge ending up in setup_64.c.

If we had an smp_ops->spinning_secondaries() that tells the spin
loop how many secondaries to wait for, it could all go in platform code
I think.

The check for use_spinloop() would just become a short-circuit check of
spinning_secondaries == 0.

The other issue is kexec. IIRC when we kexec on pseries we don't return
the CPUs to RTAS, so then they *are* spinning at 0x60. But maybe that's
changed since I last looked at it too :)

cheers

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index c9e760ec7530..0deef350004f 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -55,12 +55,18 @@
>   *
>   *  For pSeries or server processors:
>   *   1. The MMU is off & open firmware is running in real mode.
> - *   2. The kernel is entered at __start
> + *   2. The primary CPU enters at __start.
> + *   3. If the RTAS supports "query-cpu-stopped-state", then secondary
> + *      CPUs will enter as directed by "start-cpu" RTAS call, which is
> + *      generic_secondary_smp_init, with PIR in r3.
> + *   4. Else the secondary CPUs will enter at secondary_hold (0x60) as
> + *      directed by the "start-cpu" RTS call, with PIR in r3.
>   * -or- For OPAL entry:
> - *   1. The MMU is off, processor in HV mode, primary CPU enters at 0
> - *      with device-tree in gpr3. We also get OPAL base in r8 and
> - *	entry in r9 for debugging purposes
> - *   2. Secondary processors enter at 0x60 with PIR in gpr3
> + *   1. The MMU is off, processor in HV mode.
> + *   2. The primary CPU enters at 0 with device-tree in r3, OPAL base
> + *      in r8, and entry in r9 for debugging purposes.
> + *   3. Secondary CPUs enter as directed by OPAL_START_CPU call, which
> + *      is at generic_secondary_smp_init, with PIR in r3.
>   *
>   *  For Book3E processors:
>   *   1. The MMU is on running in AS0 in a state defined in ePAPR
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 3f2453858f60..afa79e8d56a6 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -363,8 +363,18 @@ void early_setup_secondary(void)
>  #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
>  static bool use_spinloop(void)
>  {
> -	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S)) {
> +		/*
> +		 * See comments in head_64.S -- not all platforms insert
> +		 * secondaries at __secondary_hold and wait at the spin
> +		 * loop.
> +		 */
> +		if (firmware_has_feature(FW_FEATURE_OPAL))
> +			return false;
> +		if (rtas_token("query-cpu-stopped-state") != RTAS_UNKNOWN_SERVICE)
> +			return false;
>  		return true;
> +	}
>  
>  	/*
>  	 * When book3e boots from kexec, the ePAPR spin table does
> -- 
> 2.13.3

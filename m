Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B31EDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:37:01 +1100 (EST)
Date: Mon, 20 Oct 2008 23:36:40 -0500 (CDT)
Message-Id: <200810210436.m9L4aepT056796@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <200810202219.m9KMJiRX000463@d01av04.pok.ibm.com>
Subject: Re: [1/1] powerpc: Update page in counter for CMM
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

X-Patchwork-Id: 5144

On Mon Oct 20, 2008 near 12:19:21 GMT, Brian King wrote:
> 
> A new field has been added to the VPA as a method for
> the client OS to communicate to firmware the number of
> page ins it is performing when running collaborative
> memory overcommit. The hypervisor will use this information
> to better determine if a partition is experiencing memory
> pressure and needs more memory allocated to it.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/include/asm/lppaca.h |    3 ++-
>  arch/powerpc/kernel/paca.c        |    1 +
>  arch/powerpc/mm/fault.c           |    8 ++++++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff -puN arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure arch/powerpc/mm/fault.c
> --- linux-2.6/arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure	2008-10-20 17:13:25.000000000 -0500
> +++ linux-2.6-bjking1/arch/powerpc/mm/fault.c	2008-10-20 17:13:25.000000000 -0500
..
> @@ -318,9 +320,11 @@ good_area:
>  			goto do_sigbus;
>  		BUG();
>  	}
> -	if (ret & VM_FAULT_MAJOR)
> +	if (ret & VM_FAULT_MAJOR) {
>  		current->maj_flt++;
> -	else
> +		if (firmware_has_feature(FW_FEATURE_CMO))
> +			atomic_inc((atomic_t *)(&(get_lppaca()->page_ins)));
> +	} else
>  		current->min_flt++;
>  	up_read(&mm->mmap_sem);
>  	return 0;

(1) why do we need atomic_inc and the hundreds or thousands of cycles to
do the atomic inc in a per-cpu area?

(2) assuming we make this a normal increment, should we keep the
feature test or just do it unconditionally (ie is the additional load
and branch worse that just doing the load and store of the counter --
the address was previously reserved, right?  (no question if
it has to be atomic).


<Ramble things one might consider>

Ben asked if we need to worry about the hypervisor clearing the
count.  If they treat it as a only-incrementing then we don't need
to worry.  And since its only an indicator, then we may not care
about a big count by them interrupting between the load and store

If we are worried about linux preemption, then we need to disable
it to avoid crossing cpu variables or  getting to this point multiple
times.  (I have not looked at the context to see if we are already
disabled).

</Ramble>


milton

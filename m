Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCsNT5jFwzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 16:38:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Clarke <pc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size
In-Reply-To: <20160809171131.GA2329@us.ibm.com>
References: <20160805061041.GA31857@us.ibm.com>
 <20160805061426.GB31857@us.ibm.com> <20160805183055.GA842@us.ibm.com>
 <aa4efc0a-1a12-5630-b8e4-752931bd9753@us.ibm.com>
 <20160809171131.GA2329@us.ibm.com>
Date: Wed, 01 Feb 2017 16:37:58 +1100
Message-ID: <87wpdatqrt.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> Paul Clarke [pc@us.ibm.com] wrote:
> ---
>
> From f9e9e8460206bc3fa7eaa741b9a2bde22870b9e0 Mon Sep 17 00:00:00 2001

I know it's been a while but I think it would still be good to get this
in a shape that we can merge it.

Comments inline ...

> From: root <sukadev@linux.vnet.ibm.com>
> Date: Thu, 4 Aug 2016 23:13:37 -0400
> Subject: [PATCH 2/2] powerpc/pseries: Dynamically grow RMA size
>
> When booting a very large system with a large initrd we run out of space
> for the flattened device tree (FDT). To fix this we must increase the
> space allocated for the RMA region.
>
> The RMA size is hard-coded in the 'ibm_architecture_vec[]' and increasing
> the size there will apply to all systems, large and small, so we want to
> increase the RMA region only when necessary.
>
> When we run out of room for the FDT, set a new OF property, 'ibm,new-rma-size'
> to the new RMA size (512MB) and issue a client-architecture-support (CAS)
> call to the firmware. This will initiate a system reboot. Upon reboot we
> notice the new property and update the RMA size accordingly.
>
> Fix suggested by Michael Ellerman.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index f612a99..d1aaeda 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -87,6 +87,9 @@
>  int of_workarounds;
>  #endif
>  
> +#define IBM_NEW_RMA_SIZE_PROP	"ibm,new-rma-size"
> +#define IBM_NEW_RMA_SIZE_STR	"512"

The property name should really start with "linux,", as it's a Linux
property, not used by firmware at all.

And does it need to contain a value? Just its existence is a flag that
we want to increase the RMA size.

So it could just be called "linux,increase-rma-size".

And we don't need a #define for the name, it's not going to change once
the code is in, and a #define just obscures the actual name.

> @@ -898,6 +910,42 @@ static void fixup_nr_cores(void)
>  		ptcores[1] = (cores >> 16) & 0xff;
>  		ptcores[2] = (cores >> 8) & 0xff;
>  		ptcores[3] = cores & 0xff;
> +		fixup_nr_cores_done = true;

That code has changed upstream, so that won't apply. But that's OK, I
don't think we need to do it anyway.

> +static void __init fixup_rma_size(void)
> +{
> +	int rc;
> +	u64 size;
> +	unsigned char *min_rmap;
> +	phandle optnode;
> +	char str[64];
> +
> +	optnode = call_prom("finddevice", 1, 1, ADDR("/options"));
> +	if (!PHANDLE_VALID(optnode))
> +		prom_panic("Cannot find /options");
> +
> +	/*
> +	 * If a prior boot specified a new RMA size, use that size in
> +	 * ibm_architecture_vec[]. See also increase_rma_size().
> +	 */
> +	size = 0ULL;
> +	memset(str, 0, sizeof(str));
> +	rc = prom_getprop(optnode, IBM_NEW_RMA_SIZE_PROP, &str, sizeof(str));
> +	if (rc <= 0)
> +		return;

So this can just become something like:

	rc = prom_getprop(optnode, "linux,increase-rma-size", NULL, 0)
	if (rc == PROM_ERROR)
        	return;
                
	val = be32_to_cpu(ibm_architecture_vec.vec2.min_rma);
	ibm_architecture_vec.vec2.min_rma = cpu_to_be32(val * 2);

> @@ -946,6 +996,49 @@ static void __init prom_send_capabilities(void)
>  	}
>  #endif /* __BIG_ENDIAN__ */
>  }
> +
> +static void __init increase_rma_size(void)
> +{
> +	int rc, len;
> +	char str[64];
> +	phandle optnode;
> +
> +	optnode = call_prom("finddevice", 1, 1, ADDR("/options"));
> +	if (!PHANDLE_VALID(optnode))
> +		prom_panic("Cannot find /options");
> +
> +	/*
> +	 * If we already increased the RMA size, return.
> +	 */
> +	memset(str, 0, sizeof(str));
> +	rc = prom_getprop(optnode, IBM_NEW_RMA_SIZE_PROP, &str, sizeof(str));
> +
> +	if (!strcmp(str, IBM_NEW_RMA_SIZE_STR)) {
> +		prom_printf("RMA size already at %.3s.\n", str);
> +		return;
> +	}
> +	/*
> +	 * Otherwise, set the ibm,new-rma-size property and initiate a CAS
> +	 * reboot so the RMA size can take effect. See also init_rma_size().
> +	 */
> +	len = strlen(IBM_NEW_RMA_SIZE_STR) + 1;
> +	memcpy(str, IBM_NEW_RMA_SIZE_STR, len);
> +
> +	prom_printf("Setting %s property to %s\n", IBM_NEW_RMA_SIZE_PROP, str);
> +	rc = prom_setprop(optnode, "/options", IBM_NEW_RMA_SIZE_PROP, str, len);

We should check rc there shouldn't we?

Again that code can be simpler if the property is just a flag.

> +	/* Force a reboot. Will work only if ibm,fw-override-cas==false */
> +	prom_send_capabilities();
> +
> +	prom_printf("No CAS initiated reboot? Try setting ibm,fw-override-cas to 'false' in Open Firmware\n");

I'm not sure if we want to be referring to ibm,fw-override-case. I don't
thing it's a documented property (not in PAPR anyway), and it's
certainly IBM PFW specific even if it is.

I know for a fact that on KVM you won't get rebooted here, so I think if
the CAS returns we should just reboot directly.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMQzD0QK5zDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:16:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 anton@ozlabs.org, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Avoid checkstop on HMI and MCE
In-Reply-To: <20171024092005.3861-1-mikey@neuling.org>
References: <20171024092005.3861-1-mikey@neuling.org>
Date: Wed, 25 Oct 2017 12:16:30 +0200
Message-ID: <871slr1qip.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On an unrecoverable HMI or MCE only generate an checkstop (via
> PLATFORM ERROR opal reboot call) when panic_on_oops is set.
>
> We currently generate an checkstop as an attempt for the FSP to grab a
> dump and then reboot us. Unfortunately this never works and no one

Never? WT#.

> I've talked to has ever seen a resulting dump, let alone got useful
> information from it.
>
> Even worse, the checkstop gets in the way of debugging real
> problems. If we hit a software bug that results in this, we get no
> opportunity to debug it live. Similarly if the bug is due to hardware
> that is not in the dump (say PCI or NVLINK GPU), we get no information
> in the dump about that hardware.
>
> So let's remove it unless someone sets panic_on_oops.

Nick just rewrote pnv_platform_error_reboot(), so please talk to him to
make sure you're not stepping on each other.

> diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
> index c9e1a4ff29..23780970d0 100644
> --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> @@ -284,6 +285,11 @@ static void hmi_event_handler(struct work_struct *work)
>  			print_hmi_event_info(hmi_evt);
>  		}
>  
> +		if (!panic_on_oops) {
> +			die("Unrecoverable HMI exception", NULL, SIGBUS);
> +			return;

I don't think we should return.

Otherwise we risk persisting corrupt data to disk and so on.

If we're getting unrecoverable HMI/MCEs that are not actually indicative
of something bad happening then we need to filter those out somewhere.

cheers

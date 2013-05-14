Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 165C72C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 18:59:36 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: "anton.vorontsov@linaro.org" <anton.vorontsov@linaro.org>
Subject: RE: [PATCH] powerpc/mpc85xx: fix non-bootcpu cannot up after
 hibernation resume
Date: Tue, 14 May 2013 08:59:13 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259F2AFC3@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1368518756-9850-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1368518756-9850-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>, "rjw@sisk.pl" <rjw@sisk.pl>,
 "paulus@samba.org" <paulus@samba.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I send to a wrong email address "Anton Vorontsov <avorontsov@ru.mvista.com>=
"

Add Anton Vorontsov <anton.vorontsov@linaro.org> to this email.

Thanks all.

> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Tuesday, May 14, 2013 4:06 PM
> To: avorontsov@ru.mvista.com
> Cc: paulus@samba.org; rjw@sisk.pl; benh@kernel.crashing.org;
> johannes@sipsolutions.net; Wood Scott-B07421; Li Yang-R58472; Zhao
> Chenhui-B35336; linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH] powerpc/mpc85xx: fix non-bootcpu cannot up after
> hibernation resume
>=20
> This problem belongs to the core synchronization issues.
> The cpu1 already updated spin_table values, but bootcore cannot get
> this value in time.
>=20
> After bootcpu hibiernation restore the pages. we are now running
> with the kernel data of the old kernel fully restored. if we reset
> the non-bootcpus that will be reset cache(tlb), the non-bootcpus
> will get new address(map virtual and physical address spaces).
> but bootcpu tlb cache still use boot kernel data, so we need to
> invalidate the bootcpu tlb cache make it to get new main memory data.
>=20
> log:
> Enabling non-boot CPUs ...
> smp_85xx_kick_cpu: timeout waiting for core 1 to reset
> smp: failed starting cpu 1 (rc -2)
> Error taking CPU1 up: -2
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/arch/powerpc/kernel/swsusp_booke.S
> b/arch/powerpc/kernel/swsusp_booke.S
> index 11a3930..9503249 100644
> --- a/arch/powerpc/kernel/swsusp_booke.S
> +++ b/arch/powerpc/kernel/swsusp_booke.S
> @@ -141,6 +141,19 @@ _GLOBAL(swsusp_arch_resume)
>  	lis	r11,swsusp_save_area@h
>  	ori	r11,r11,swsusp_save_area@l
>=20
> +	/*
> +	 * The boot core get a virtual address, when the boot process,
> +	 * the virtual address corresponds to a physical address. After
> +	 * hibernation resume memory snapshots, The corresponding
> +	 * relationship between the virtual memory and physical memory
> +	 * might change again. We need to get a new page table. So we
> +	 * need to invalidate TLB after resume pages.
> +	 *
> +	 * Invalidations TLB Using tlbilx/tlbivax/MMUCSR0.
> +	 * tlbilx used here.
> +	 */
> +	bl	_tlbil_all
> +
>  	lwz	r4,SL_SPRG0(r11)
>  	mtsprg	0,r4
>  	lwz	r4,SL_SPRG1(r11)
> --
> 1.8.0

In-Reply-To: <1077074495.1082.94.camel@gaston>
References: <1077074495.1082.94.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4BC58196-623A-11D8-A367-000393A47A5C@lanl.gov>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Greg Watson <gwatson@lanl.gov>
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Date: Wed, 18 Feb 2004 10:45:52 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Seems to work fine:

Titanium G4 667MHz (Gigabit)
Yellow Dog 3.0.1
kernel 2.4.22-2a

Greg

On Feb 17, 2004, at 8:21 PM, Benjamin Herrenschmidt wrote:

>
> Hi need people who own those machiens, especially the recent iBook2
> models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.
>
> (It won't help machines that cannot already sleep).
>
> Applies on top of current 2.6 but may apply to 2.4 as well..
>
> Thanks !
>
> Ben.
>
> ===== arch/ppc/kernel/l2cr.S 1.15 vs edited =====
> --- 1.15/arch/ppc/kernel/l2cr.S	Tue Oct 14 17:28:01 2003
> +++ edited/arch/ppc/kernel/l2cr.S	Wed Feb 18 14:14:33 2004
> @@ -130,11 +130,13 @@
>  	mtspr	HID0,r4			/* Disable DPM */
>  	sync
>
> +#if 0
>  	/* Flush & disable L1 */
>  	mr	r5,r3
>  	bl	__flush_disable_L1
>  	mr	r3,r5
> -
> +#endif
> +
>  	/* Get the current enable bit of the L2CR into r4 */
>  	mfspr	r4,L2CR
>
> @@ -236,8 +238,10 @@
>  	sync
>
>  4:
> -	bl	__inval_enable_L1
>
> +#if 0
> +	bl	__inval_enable_L1
> +#endif
>  	/* Restore HID0[DPM] to whatever it was before */
>  	sync
>  	mtspr	1008,r8
> @@ -394,11 +398,10 @@
>  END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>   	sync
>
> -	/* Load counter to 0x1000 cache lines (128k) and
> +	/* Load counter to 0x4000 cache lines (512k) and
>  	 * load cache with datas
>  	 */
> -	lis	r3,0x0002
> -//	li	r3,0x1000	/* 128kB / 32B */
> +	li	r3,0x4000	/* 512kB / 32B */
>  	mtctr	r3
>  	li	r3, 0
>  1:
> @@ -409,8 +412,7 @@
>  	sync
>
>  	/* Now flush those cache lines */
> -	lis	r3,0x0002
> -//	li	r3,0x1000	/* 128kB / 32B */
> +	li	r3,0x4000	/* 512kB / 32B */
>  	mtctr	r3
>  	li	r3, 0
>  1:
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

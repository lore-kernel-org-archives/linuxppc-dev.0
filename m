Date: Tue, 24 Feb 2004 10:54:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Message-ID: <20040224175409.GC1052@smtp.west.cox.net>
References: <1077074495.1082.94.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077074495.1082.94.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 18, 2004 at 02:21:36PM +1100, Benjamin Herrenschmidt wrote:

>
> Hi need people who own those machiens, especially the recent iBook2 models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.
[snip]
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

Are you sure that you can get away with this, passed on how the manuals
(745x) describe the sequence of flush/invalidating the L2 (and, L3) ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

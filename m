In-Reply-To: <1080721028.1416.13.camel@gaston>
References: <7eb2247ee728.7ee7287eb224@jhumail.jhu.edu> <1080720349.1435.11.camel@gaston> <1080721028.1416.13.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C8A07B00-833C-11D8-8287-000A95DC1AB2@macdiscussion.com>
Cc: ERIC NORTHUP <eric.northup@jhu.edu>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Mark Guertin <mguertin@macdiscussion.com>
Subject: Re: 4way smp on ppc32
Date: Wed, 31 Mar 2004 12:56:49 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'll try and find some time to test this stuff on my daystar quad as
well.  I know that right up to latest 2.4.x all 4 of my CPU's are still
working fine.

Gerk

On 31-Mar-04, at 3:17 AM, Benjamin Herrenschmidt wrote:

>
> Actually, there is at least one problem, can you try this patch:
>
> ===== arch/ppc/platforms/pmac_smp.c 1.30 vs edited =====
> --- 1.30/arch/ppc/platforms/pmac_smp.c	Tue Mar 23 12:46:59 2004
> +++ edited/arch/ppc/platforms/pmac_smp.c	Wed Mar 31 18:16:54 2004
> @@ -316,6 +316,8 @@
>
>  	psurge_type = psurge_quad_probe();
>  	if (psurge_type != PSURGE_DUAL) {
> +		psurge_smp_ops.take_timebase = smp_generic_take_timebase;
> +		psurge_smp_ops.give_timebase = smp_generic_give_timebase;
>  		psurge_quad_init();
>  		/* All released cards using this HW design have 4 CPUs */
>  		ncpus = 4;
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

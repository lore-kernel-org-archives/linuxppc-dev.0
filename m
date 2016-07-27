Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rztFQ0jFjzDrFS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:34:50 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so1633825pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 04:34:50 -0700 (PDT)
Date: Wed, 27 Jul 2016 21:34:40 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, npiggin@gmail.com,
 svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] Make system_reset_pSeries relocatable
Message-ID: <20160727113440.GA3720@350D>
Reply-To: bsingharora@gmail.com
References: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48aad8b6-a27f-44c5-2b0b-f276595e9c04@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2016 at 05:32:06PM +1000, Balbir Singh wrote:
> 
> From: Balbir Singh <bsingharora@gmail.com>
> 
> Currently the power management bits are broken w.r.t. relocation.
> There are direct branches from system_reset_pSeries to
> power7_wakeup_*. The correct way to do it is to do what
> the slb miss handler does, which is jump to a small stub within
> the first 64k of the relocated address and then jump to the
> actual location.
> 
> The code has been lightly tested (not the kvm bits), I would highly
> appreciate a review of the code. I suspect there might be easy
> to find bugs :)
>
Snip
 
> +	.align 7
> +_GLOBAL(power7_wakeup_common)
> +#ifdef CONFIG_RELOCATABLE
> +	mtctr	r11
> +#endif
> +	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
> +	cmpwi   cr2,r0,PNV_THREAD_NAP
> +	bgt     cr2,8f				/* Either sleep or Winkle */
> +
> +	/* Waking up from nap should not cause hypervisor state loss */
> +	bgt	cr3,.
> +
> +	/* Waking up from nap */
> +	li	r0,PNV_THREAD_RUNNING
> +	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	li	r0,KVM_HWTHREAD_IN_KERNEL
> +	stb	r0,HSTATE_HWTHREAD_STATE(r13)
> +	/* Order setting hwthread_state vs. testing hwthread_req */
> +	sync
> +	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
> +	cmpwi	r0,0
> +	beq	1f
> +	b	kvm_start_guest
> +1:
> +#endif
> +
> +	/* Return SRR1 from power7_nap() */
> +	mfspr	r3,SPRN_SRR1
> +	beq	cr3,2f
> +	b	power7_wakeup_noloss
> +2:	b	power7_wakeup_loss
> +
> +	/* Fast Sleep wakeup on PowerNV */
> +8:	GET_PACA(r13)
> +	b 	power7_wakeup_tb_loss
> +
>  /*
>   * Hash table stuff
>   */

As per 0day, this part needs to be under #ifdef CONFIG_PPC_P7_NAP

I'll repose a new version tomorrow.

Balbir Singh

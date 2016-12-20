Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjMv00DfgzDwQ9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 13:59:08 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 144so8166891pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 18:59:07 -0800 (PST)
Date: Tue, 20 Dec 2016 12:58:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 12/12] powerpc: Rename soft_enabled to
 soft_disabled_mask
Message-ID: <20161220125841.6d74265b@roar.ozlabs.ibm.com>
In-Reply-To: <1482134828-18811-13-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-13-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Dec 2016 13:37:08 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Rename the paca->soft_enabled to paca->soft_disabled_mask as
> it is no more used as a flag for interrupt state.
> 

This makes it much more readable, thanks. I have a question which
isn't part of this patch but I just notice it now:


> @@ -193,8 +193,8 @@ static inline bool arch_irqs_disabled(void)
>  #define hard_irq_disable()	do {			\
>  	u8 _was_enabled;				\
>  	__hard_irq_disable();				\
> -	_was_enabled = local_paca->soft_enabled;	\
> -	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
> +	_was_enabled = local_paca->soft_disabled_mask;	\
> +	local_paca->soft_disabled_mask = IRQ_DISABLE_MASK_LINUX;\
>  	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
>  	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
>  		trace_hardirqs_off();			\

trace_hardirqs_off() is the Linux interrupt disable, i.e., the MASK_LINUX
bit. So I think the test should be:

if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))

After your rename it should be called _was_masked instead  I guess.

Also I suppose the new soft disable mask should include all interrupt
bits, shouldn't it? It would be confusing to get the situation where
hard_irq_disable() strips the PMU bit off the mask. If you agree, then
it would be good to add IRQ_DISABLE_MASK_ALL define where the bits are
defined.

Thanks,
Nick

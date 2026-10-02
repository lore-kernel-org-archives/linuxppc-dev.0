Return-Path: <linuxppc-dev+bounces-28724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF4ECA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 08:24:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx1zq6pMWz2yPG;
	Fri, 02 Oct 2026 18:24:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790929495;
	cv=none; b=ZOPuoom1pG+Dw/KAik3HnU0b8W6NBSTlQSZi/Vi584ErIeAqVsfTEG48B5Li+YBAevpfTOPm1kdJUgX5GmsA204uG+VKpFLVLNka+xShjn/X5Vw/3+9TwYSWPp3lratdJjR5KzGHi7Pe85gzMmDOD0/yth5lFTp+kwQlpPprVl1XVgjK9CfUwkVvEqUuZXJDfEmZymde3JMe6RsX8w31NaagfWJVgsANVBMnUYVvUKgmjcXTVsC716k/agZh0zderGdQhxDccGrt2aE+JA1kERGNZdMTnDzSYdSzi9kwMkq4oB4BmnLkaNEaDSZ+nU/dcwMYiTEquxSNJvPBBn+WNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790929495; c=relaxed/relaxed;
	bh=WJ3O4ET6uMBU8h4vN6+2G16j9dMQqJ+owsNN6HPkb0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOFYXb0E2/qRy4qgZElTZ5xjo70cZotmz0MQpFZx5bLS9kjEipmNB8YSAZrPaiL4lIyDN4oJjPmUJ+TH0W+UveIIv6+GdGPMm5P+ozMDhmbKuDHD+SGBLdTZu8WKE0PUMh4dnbGwiv28s0IPwcBSniDlq0PGBDrbySeIM/p5Q45V51RVysvDcEEWsOMII1jRXidlzxD13htzhNMXkKyKjV23c/xb+f1CwvlTu/fulTzSDAG3ZhPSmRZxXPLi2LiUqHqJ9Airq5sOFVvL2yAg0jy18UR6K0DzfWfNKrfzirlISzgBAi7ny4bppA+ZTiB+v/Qit8QooLS28lbYwoAKUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=S28Pl07O; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7DZJ0YoI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oAHXTXCH; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QoX/hWQc; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=S28Pl07O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7DZJ0YoI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oAHXTXCH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QoX/hWQc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx1zp3DG2z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 18:24:54 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33C71FE48;
	Fri,  2 Oct 2026 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790929481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ3O4ET6uMBU8h4vN6+2G16j9dMQqJ+owsNN6HPkb0A=;
	b=S28Pl07OiWzIiZB5HdjU+PK7OEhTNf4qIIRRpnS2N51E1jteQOM9EQ32WUO19TeLUA6gNJ
	4v3c0f7C7G9qUeLFodXNqUjGH3Cp/CTWpHbsLJV9dormVDCWEGX1vvWVB1vunVEaToB/hG
	ytWOJJj/75PRujMMg/PDh6zhYaRhxIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790929481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ3O4ET6uMBU8h4vN6+2G16j9dMQqJ+owsNN6HPkb0A=;
	b=7DZJ0YoIflQ5qa/i8aXgOeo7/QFWb87n8xIrCb+a2UUxAzeq3JsdsV2RXN5riqoaRXN60b
	PkEDTfmPA17c0dDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oAHXTXCH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="QoX/hWQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790929477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ3O4ET6uMBU8h4vN6+2G16j9dMQqJ+owsNN6HPkb0A=;
	b=oAHXTXCHID+6RkSPu7N15NyrqPlVJJ4jEb69G6PIjvnoVFXDRfY8BEKd8fdHP96CYZOGs+
	jf0+/3vI6cUzG/PVnF2n0pBp789gkaTxGcevpSOPtD4cw/edWgyFzDHRNVtHDlHMNFmjZB
	NzXXqT9u1nn+skiq54nE6Y4b9WsocF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790929477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ3O4ET6uMBU8h4vN6+2G16j9dMQqJ+owsNN6HPkb0A=;
	b=QoX/hWQc4YWUps1eJKocO45zsAzZhw4eLq8je0LffYv1mvnmIPSFtTp4QQqgskkXK4xwry
	zxooIIxY9FfwnDAg==
Date: Fri, 2 Oct 2026 10:24:36 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	mkchauras@linux.ibm.com, ruanjinjie@huawei.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: fix NMI exit ordering: restore soft masks after
 irqentry_nmi_exit()
Message-ID: <ar9qRKA1mavDruDR@kunlun.suse.cz>
References: <20260929071600.2963954-1-mkchauras@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929071600.2963954-1-mkchauras@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,huawei.com,lists.ozlabs.org,vger.kernel.org];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: +++
X-Rspamd-Queue-Id: B33C71FE48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Sep 29, 2026 at 12:46:00PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> When running with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y and LOCKDEP=y, an
> Oops is triggered during NMI exit:
> 
>   [  202.258332] Oops: Exception in kernel mode, sig: 4 [#1]
>   NIP [000000000003e178] 0x3e178
>   LR  [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
>   TRAP: 0700  MSR: 0000000000081000 <ME>
> 
> The faulting instruction at NIP is a 'trap' (0fe00000) inside the
> rfi_flush_fallback trampoline at a userspace-looking low address, reached
> after a bad rfid caused by an incorrect SRR0 value.
> 
> Root cause
> ----------
> DEFINE_INTERRUPT_HANDLER_NMI used to call arch_interrupt_nmi_exit_prepare()
> *before* irqentry_nmi_exit(), giving this sequence:
> 
>   arch_interrupt_nmi_enter_prepare()   // saves irq_soft_mask, irq_happened
>   irqentry_nmi_enter()                 // __nmi_enter() -> nmi_count++, in_nmi()=true
>   ____func(regs)                       // NMI handler body
>   arch_interrupt_nmi_exit_prepare()    // RESTORES irq_soft_mask=0 (IRQS_ENABLED)
>                                        // RESTORES irq_happened with pending bits
>   irqentry_nmi_exit()                  // instrumentation block runs here...
>     trace_hardirqs_on_prepare()        //   ...with in_nmi()==true still
>     lockdep_hardirqs_on_prepare()      //   ...and irq_soft_mask already restored to 0
>       -> arch_local_irq_restore(0)     // mask=0 -> enable path entered
>            WARN_ON_ONCE(in_nmi())      // FIRES: __nmi_exit() hasn't run yet
>     __nmi_exit()                       // nmi_count-- (too late)
> 
> arch_interrupt_nmi_exit_prepare() restores irq_soft_mask to whatever
> the interrupted thread had (IRQS_ENABLED / 0) and restores irq_happened
> with any pending deferred-interrupt bits that were present when the NMI
> fired.  This is correct and necessary before rfid back to the interrupted
> context, but it must not happen until irqentry_nmi_exit() has fully
> completed.
> 
> With irq_soft_mask=0 and pending bits in irq_happened, the
> trace_hardirqs_on_prepare() call inside irqentry_nmi_exit()'s
> instrumentation block reaches lockdep_hardirqs_on_prepare() which
> calls __trace_hardirqs_on_caller(), which eventually calls
> arch_local_irq_restore(0) (the IRQS_ENABLED / enable path).
> 
> arch_local_irq_restore() with mask=0 hits the CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> guards at irq_64.c:217:
> 
>   WARN_ON_ONCE(in_nmi());   // TRUE: __nmi_exit() not yet called
> 
> The WARN_ON_ONCE fires a 'trap' instruction (tw 31,0,0 / 0fe00000) in
> kernel mode with MSR_PR=0, MSR_IR=0 (real-mode).  The program check
> handler (TRAP 0700) takes the sig:4 (SIGILL) path via do_program_check()
> and calls die(), producing the Oops.
> 
> The RESTART_TABLE mechanism in arch_local_irq_restore then causes the
> bad rfid that lands at the userspace-looking address visible in the NIP.
> 
> The bug is invisible with LOCKDEP=n because trace_hardirqs_on_prepare()
> is a no-op when CONFIG_TRACE_IRQFLAGS is not set (TRACE_IRQFLAGS is
> selected by PROVE_LOCKING which selects LOCKDEP).
> 
> Fix
> ---

Hello,

please avoid excessive formatting in commit messages.

When git am is used to apply this patch it strips everything after this
line

> Move arch_interrupt_nmi_exit_prepare() to after the irqentry_nmi_exit()
> block, so that:
> 
>   irqentry_nmi_exit()                 // __nmi_exit() -> nmi_count--, in_nmi()=false
>   arch_interrupt_nmi_exit_prepare()   // now safe to restore soft mask state
> 
> The instrumentation inside irqentry_nmi_exit() now executes while
> in_nmi() is still true (nmi_count not yet decremented), but
> irq_soft_mask is still IRQS_ALL_DISABLED (NMI-entry value), so
> arch_local_irq_restore() is never called with mask=0 from that path.
> After __nmi_exit() returns, arch_interrupt_nmi_exit_prepare() restores
> the pre-NMI soft mask and irq_happened, which is the correct state for
> the rfid back to the interrupted context.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/d4cccba9-ce5c-424b-864c-2248fb0d99e6@linux.ibm.com/
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---

because it's the same as this line that marks the end of the commit
message.

Thanks

Michal

>  arch/powerpc/include/asm/interrupt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 1b45a49e9bed..56f855c6f07e 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -301,7 +301,6 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  		state = irqentry_nmi_enter(regs);			\
>  	}								\
>  	ret = ____##func (regs);					\
> -	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
>  	if (mfmsr() & MSR_DR) {						\
>  		/* nmi_exit if relocations are on */			\
>  		irqentry_nmi_exit(regs, state);				\
> @@ -317,6 +316,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  	} else {							\
>  		irqentry_nmi_exit(regs, state);				\
>  	}								\
> +	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
>  									\
>  	return ret;							\
>  }									\
> -- 
> 2.55.0
> 
> 


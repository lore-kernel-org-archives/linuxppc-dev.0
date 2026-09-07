Return-Path: <linuxppc-dev+bounces-26658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B3C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:35:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdgP32FYbz2yvj;
	Mon, 07 Sep 2026 18:35:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788770103;
	cv=none; b=apPOdEB1ZoRoP1miVf1xI5GfaBeiyJ3duGbechc3TD0NpGi0DzyFb3fWow6DDgzQgpu9koQnLFX/ORltVRuhCKYeHwzSX3zXiQ7F34Kvnvsdu8huNJ+ZDTONJcPPQX5nm0c4rUxmNTisXY2NsyjFKmehyZAhtHgnaeBRdl/BersCPz3ga//iazxisS/tzIEB+5P5GjnpjSqhIXsctIupiKaokl5wQnsTpc0JIIU/jVyVRfKpZiW8I+rINe1zRr/taX4v/0JoDwvcz1PAKWc/fcPl2hxRAyym/Mu49HXT20aEadjY5Qm3sVCnhHpX6CcbgVsNJg4CYncqyy0O1b5z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788770103; c=relaxed/relaxed;
	bh=P5L7h3jJPOtuGW9dF0Z9UUqBDrEsnf0yktjqYcU6pQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3lqnUUHNXLIi/SKsvRHnjTmARhEWw1y3b6kO5l682aR7VgKzo0UHEE7YpgmhTPFX1ykGqiuLZRJmwtKlhiFXWeVoWg133ZAFteBy7V006C+GjfcgkWenpO82x9lIU7vrmAARQ0dB3Ipp475h0QxVbb1uuerxBM7e7Mp9gMqkJkoCKRDJZZMxzUv8EG2/Y5U67dAwez6I6xp2BM4uck/4ez9vdEh9jhepQk84Xy6vC7cuFlGGmgyQhDAZaQDeBABqMTONKHelPGHxV0La4fGgUOc8JRH1cmlef7/xGoJRZH0m2GGZ+qh+/DNtkqgWIl6Hci4QoObv20FPEQAUegREg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FCsYM2mm; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hue610HF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l+OXNMw8; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fLQhzhLS; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FCsYM2mm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hue610HF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l+OXNMw8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fLQhzhLS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdgP14fRXz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:35:01 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B6F721A3A;
	Mon,  7 Sep 2026 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788770093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5L7h3jJPOtuGW9dF0Z9UUqBDrEsnf0yktjqYcU6pQ8=;
	b=FCsYM2mmarB3qXfIEeIWWb5XDdQHoVbfOkfHs6ARV7sIh+cAZJIuRbeE0gJaPS8O2x698o
	tXcfxnN/ha8Tptin5gg2pmDeJixUQjSlUHJC55Xgssb9oR/j4oB1DPlbGonh0TiyQYc87c
	8DNegqYJQtvIr2qDfmSnPQJX5eiZC3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788770093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5L7h3jJPOtuGW9dF0Z9UUqBDrEsnf0yktjqYcU6pQ8=;
	b=hue610HFAm/L993Tte17gTKnARG61kdckHGRAiSGLjqo77wAzYFL6c9mhbpYuwT4zZKe2z
	wpyKnZENVFojJ+Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l+OXNMw8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fLQhzhLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788770089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5L7h3jJPOtuGW9dF0Z9UUqBDrEsnf0yktjqYcU6pQ8=;
	b=l+OXNMw8CGh103u/HVGGXE1VoQkoh4tERcY3zco0qx4jGdIcOWUJuO5N1QqjCqKh26bXyG
	zmhGWb7I713+7GrAPBurgF8uMb8pYIlUxKkjtQenNPckfjIb47O3HcLTUEHDpqcFnnX+5A
	0+Q8tkhvaDH30VTBGZXeIWDiEni3qrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788770089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5L7h3jJPOtuGW9dF0Z9UUqBDrEsnf0yktjqYcU6pQ8=;
	b=fLQhzhLSsSiDdX3rxfN+t0CgxNkfuZTnezhurr+WDldBhjFylafG3fa3+aMQjBOvnn9cDe
	stH+Eot1NqyFqnBA==
Date: Mon, 7 Sep 2026 10:34:48 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com,
	mkchauras@gmail.com, sshegde@linux.ibm.com, ruanjinjie@huawei.com,
	ritesh.list@gmail.com, riteshh@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/interrupt: Use early_radix_enabled() in NMI
 real-mode guard
Message-ID: <ap53KNdFJWaUw8GM@kunlun.suse.cz>
References: <20260907070058.26338-1-venkat88@linux.ibm.com>
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
In-Reply-To: <20260907070058.26338-1-venkat88@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 8B6F721A3A
X-Spamd-Result: default: False [13.55 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.14)[-0.718];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,huawei.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.de:dkim]
X-Spamd-Bar: +++++++++++++
X-Spam: Yes

Hello,

On Mon, Sep 07, 2026 at 12:30:58PM +0530, Venkat Rao Bagalkote wrote:
> radix_enabled() uses a jump label which is only valid after
> mmu_feature_keys_init() is called. Before that point, on a pSeries
> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
> cur_cpu_spec->mmu_features but the jump label has not yet been patched,
> so radix_enabled() incorrectly returns true.
> 
> Replace radix_enabled() with early_radix_enabled() which does a plain
> bitmask check against cur_cpu_spec->mmu_features and is correct at all
> times, including before jump label initialization.

Any Fixes: here?

Thanks

Michal

> 
> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
> declared there.
> 
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/interrupt.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 1b45a49e9bed..36a654e780f7 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -71,6 +71,7 @@
>  
>  #include <asm/kprobes.h>
>  #include <asm/runlatch.h>
> +#include <asm/mmu.h>
>  
>  #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
>  /*
> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  		state = irqentry_nmi_enter(regs);			\
>  	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>  		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>  		/* no nmi_entry for a pseries hash guest		\
>  		 * taking a real mode exception */			\
>  	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  		irqentry_nmi_exit(regs, state);				\
>  	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>  		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>  		/* no nmi_exit for a pseries hash guest			\
>  		 * taking a real mode exception */			\
>  	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
> -- 
> 2.45.2
> 
> 


Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAD606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvuSE/Xn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJQ+NzhT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jMW1r8aV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wepXcgmH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVTFq2660z2y2R;
	Thu, 19 Nov 2026 17:34:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795027664;
	cv=none; b=PKJaLU356Q7QDTs+i9hB26h8+5gmmDiRqyzccNvl41NzRBJkOhlpbO3q4nz7snQ6CF7fxy+G+TBGu4355L7DSfFdkCeIVaDpfyblcojFpltOKPUGXnixolZasrPt3VbgLPC1rI84wZg3SojGt3g3OL1MBfE6M6+axtZFLu0l+X9JgKMoHb/DYwUxzJC1SCnn4Tq/1KB91dMTaX4T4cwskRuzAPiRU4x0mbTA7U6LoMTEDPhl/j2kWKknXPB5y3UX9XnkiKeyY2FLzBfIqg1laEUsnS2K89oQm402bUDaJve0dl2qwrAi4H1yQofBEU57ZL6+qXIenKqjPZgcenWqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795027664; c=relaxed/relaxed;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDR8FbJuwDeBbLDriya8Q1oEqbP5WUTK8ak7kvHvrKcg9IvGOfhce0vfPYfZ4Vfc1mHOMeueUAk4ikBwi5Y1BHCzPvU0bRqvEw+SSiaWRCNwT0yUhIO8rtIY3VSVlv/8Idnd0WMQ/OhOVN5Nv5YaEnyTz4ErpEURY+2ozFihwEUA3Z9cUanwhq1TvNgwmybALXQQfjmP2UL3AHBgwNInUsEhhxW1Tyl2y8qHnNcR7irQv912YC+kgbpZr4uRo+HXEf6Gh+DdjNFJDczYTTSMEwTmbcQCrMO1ipprbnKCYLJIjfNhr7SXxLowb36wOQZG3F2dzmUL0S7/UcmQuZj9AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvuSE/Xn; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJQ+NzhT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jMW1r8aV; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wepXcgmH; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=farosas@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvuSE/Xn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJQ+NzhT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jMW1r8aV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wepXcgmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=farosas@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV9Zl62Rqz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:47:43 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC3B51F7C7;
	Wed, 18 Nov 2026 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795027661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=dvuSE/XnDgqLbANKpVfx8oUNYECbT0RdRs08BEllXDPKl1Z32x9pYW6MTnirgOj6fUczFC
	klEnLNmkw+P/mkHsVnKZMbLLgDWQnkxBE4qR5Df4udIiUcTUbOZxTvgXIJuLUG2tuoHPN9
	xJ76bPWQlE1FjK6YDSkhqK9Rh54NxnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795027661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=XJQ+NzhTXoI2ZUPkNxcNYLvAH7c/XliuFA0tIXQ0Xj5DdykhaGHSzo/YQUPJKU1EvJBFIa
	r5Mb9VNzRcooFBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795027660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=jMW1r8aVAkUzZcWFC0j51MBdUOXrl/vxRfgOWnt9S7degrCFopORJosN3nGPckcL+d0AXp
	bRLfn14Qxp/uLShZzuBM4qrlPpXdVSBTUze/dJqRLq5b0DoamFoKUpoKaDdWCn2fuhv+5e
	IEpGN8Y3l0UlJx1xcxANh/dCq2UapcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795027660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=wepXcgmHx+uxHrB/DhLUH1pWJk57/keea82HsgrGjJrtAt3nZpxZsGDFbbI8fg9CiTvRRv
	LB/9c8ckpT2crWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58DB8134E9;
	Wed, 18 Nov 2026 18:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ipXLOMvy/WqYTQAAD6G6ig
	(envelope-from <farosas@suse.de>); Wed, 18 Nov 2026 18:47:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem
 initialization failure
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 15:47:37 -0300
Message-ID: <87pkw2q8mu.fsf@suse.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,163.com];
	FREEMAIL_TO(0.00)[163.com,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
>
> Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Change the Fixes tag.
>  - Modify the patch title.
> ---
>  arch/powerpc/kvm/book3s_hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 22283d46e8fe..620097f292b8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
>  	r = kvmppc_uvmem_init();
>  	if (r < 0) {
>  		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
> -		return r;
> +		goto err;
>  	}
>  
>  #if defined(CONFIG_KVM_XICS)

Reviewed-by: Fabiano Rosas <farosas@suse.de>


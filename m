Return-Path: <linuxppc-dev+bounces-7733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16950C369B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Apr 2025 11:02:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZdZjR2sxbz3bmk;
	Thu, 17 Apr 2025 21:02:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744887739;
	cv=none; b=a/fylneD/Dmd6tzgwCq2ZsJ5+LV7rlSZdmCfOSn6v1cbMa05ITli3NPFjLHRSsSyWFgQOgPH9U+SnZcrbktQzxUA8mgF0QK7AYSlLMV3tZAgG0uBBoefEvNIbguYqDifQKC+yBl/JnZPMwlkdBnh3PQXItQP6R9lTaTUsCN+ntEiFjnHY7r79kPaPf4w3gjDIdGI/aq3JL03Qxa8rfIiOhNO4R7Yb8yosRZ5GqchzE+/tBhcenzhOmLFQSKWvHKQ6APHWUaXiTEtbCAPerqgkLWm5JVFTPB0emVf9fTA2LkH+e54swPtNIfDtJhNQrCai6o0K84k3KpLTaEW5HSAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744887739; c=relaxed/relaxed;
	bh=sZpnzxRSUDSCBklz6FPF9ZmFbPU52UYcDzvyh6Eiog4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DowkyB1ZvgQpp87fq2JOoDH/dTX2psCGFyLZvWcRKTqW/kstfeEs30KjPSiqmGd0Aoy29v7jgqjAAI7Ju8ebk5xhUmuCWa/Bku34Yl6M5Ry4C5CB8LYZ/uVfirr02tJFiIE8dAhJx+AXatombSNEsL1yijRzTmeYWUEDdKDsl2hIMvuj951yOI8H4MFQvUWcUCuU1WV9T8wi1d0P8KY8DIb3Z6Jg+tfcs54pjN6hZVxcKI4vyLP7yFK7l7/VvLz266ZYF5Xow1JyWd23O+CAeiDmS6n4IAti77NsaRZxCIcOPJJlDmKaSUB4xuVW1FcUQaAfxsdqX0eZ5JOS71IqrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z6omR/t7; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3JBM1DWN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CEWpdI55; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oLkB+Qln; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z6omR/t7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3JBM1DWN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CEWpdI55;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oLkB+Qln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZdZjP5WW8z2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2025 21:02:17 +1000 (AEST)
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5451F391;
	Thu, 17 Apr 2025 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744887728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZpnzxRSUDSCBklz6FPF9ZmFbPU52UYcDzvyh6Eiog4=;
	b=Z6omR/t7yrPWbMThHOZDgz53u1mkrFazP7anvZnL/gYHGOXjZGpv9/wpeh9mZQRTdszgQ3
	wbDsx0OSguttj1gE7M2JFyOQHBNpzmTyR9894KjNezOfsnDfZDcWRGKrgoRkRDo1DMrWYm
	xLMeD6nJeu0VTTxGEi8HYKrIBPE5zSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744887728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZpnzxRSUDSCBklz6FPF9ZmFbPU52UYcDzvyh6Eiog4=;
	b=3JBM1DWNzcSgFyaNKGgYey8Wtjn0c8L1fMtD51Ejl8pe/uhzXDWZYGYNe2XCCw109Am+0Q
	kZZm45Ag21n4XFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744887726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZpnzxRSUDSCBklz6FPF9ZmFbPU52UYcDzvyh6Eiog4=;
	b=CEWpdI55EFwlD/v0t9f6J8zVavV/UMm1PxVxevM/HVmvvtW3gszghtf+nDsYxZJqXGMPiQ
	15IeTWWM98mlF4BPfPyEabS3w0DZRKHVCcxdT4ZnL6Yqv+aF6y+T6VEikIPoA1zwxTAXXH
	pC7B35otRo/waCcGU85YXiH5apIMNpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744887726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZpnzxRSUDSCBklz6FPF9ZmFbPU52UYcDzvyh6Eiog4=;
	b=oLkB+QlnxL6znlv4rmg1YpFbX22sfSUHYZDFDDULOSG50aXcg2dAtbv50PYlgaoiVbkL6d
	qp4rSpauK9KzHsAQ==
Date: Thu, 17 Apr 2025 13:02:05 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Fix build with gcc 15
Message-ID: <aADfrUcNqBejcdrR@kitsune.suse.cz>
References: <20250307092055.21986-1-msuchanek@suse.de>
 <fo7xb3bqk5h57mqgfrnyfpweitkr2l5vk3tomu6zgxgqlivwpt@afm2n3c2sxke>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fo7xb3bqk5h57mqgfrnyfpweitkr2l5vk3tomu6zgxgqlivwpt@afm2n3c2sxke>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,fjasle.eu,google.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo,suse.de:email]

On Thu, Apr 17, 2025 at 11:37:09AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Fri, Mar 07, 2025 at 10:20:52AM +0100, Michal Suchanek wrote:
> > Similar to x86 the ppc boot code does not build with GCC 15.
> > 
> > Copy the fix from
> > commit ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  arch/powerpc/boot/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index 1ff6ad4f6cd2..e6b35699c049 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -33,6 +33,7 @@ else
> >  endif
> >  
> >  ifdef CONFIG_PPC64_BOOT_WRAPPER
> > +BOOTTARGETFLAGS	+= -std=gnu11
> >  BOOTTARGETFLAGS	+= -m64
> >  BOOTTARGETFLAGS	+= -mabi=elfv2
> >  ifdef CONFIG_PPC64_ELF_ABI_V2
> > -- 
> > 2.47.1
> > 
> There's another patch which fixes this problem by version comparison.
> https://lore.kernel.org/all/20250323163607.537270-2-misanjum@linux.ibm.com/
> 
> In my opinion this is a better solution as it will use the features of latest
> compiler.

No it's not a better solution. It's documented that the kernel is built
with the GNU dialect of ISO C11. When a file is not compiled with the
documented C dialect that's a bug.

If newer C dialect features are desirable then they should be enabled
consistently across the tree, not individually for a few files used in
boot code.

Thanks

Michal


Return-Path: <linuxppc-dev+bounces-25258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2ECC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 12:14:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDFwL751tz3078;
	Mon, 03 Aug 2026 22:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785759266;
	cv=none; b=jWvYyKRhTIaCdQ4ISDD1QP/9b2ZIDGQTvyTOiuH6t4ZFtzx/128pttUFMU9ZXJ5cMAnsEp1Ikus+JJvaPDSAzL+Ji4OCIA9Jp27wCeLjWk4GklcliKtDASbLTpHEaB6oboE1oCaJa7VQrnHEhW7lwJS7hpH61RgQHGfV5eRek2U0trQDhLF1SIK/4cGoSqGBeaqOTGUsamJ9uk3BFaG8h1InEWFKpaaWXHZTlnlvOuSfEToj5dlhsLBzrmqPMQJ5tzzA7Jc2BN+Y4XXaVXJ4znReAk8zi9fZtbchqlO+rzfVUQo9/jUD9vXFuwilSGqXWUEaKUsGn+BstvBZZvLNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785759266; c=relaxed/relaxed;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NelAN6IGWXVKxNkODWSFPgazW3/xdk6coci7UBKndUmP6j+NSXLqG6acbbZgRk481hCNQnnWGCIU/xxNfG1xX+G7zCJL9v1flLPLOuSvDIA/N1jVn5h6/sbMS2Iy9wJskKKHzJiBpDMJNeYmrRGoLXy1O+yV5B1WpLzSt/LGaD6oZlOzr0oggYaL8RmyKbHr8/PJUSRMunNeu9y8jQU82npebsS9qmf17jfVIhQn1YCc55dCoOn4+2lo10nY2NGSDvufge/pzHWi00aNmiQUQKvrhcBkdLBwItA91pO3kvrYEBzpqXDsGn6CHivRdi7VPWgKFDZ36GHNiwsNdOUwzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G+sItBUn; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZG8CCAi3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Ni8tPixJ; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bXABiAQ7; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G+sItBUn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZG8CCAi3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Ni8tPixJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bXABiAQ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDFwL0m16z2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 22:14:25 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80F957F055;
	Mon,  3 Aug 2026 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785759258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=G+sItBUnZfL/t7m+fkzWkSLgiRs+xLefF+6mKwvFpald7lX1+J++eS+fW4SFnJovhpugLk
	zTDLkC4UsYWg/A2sI5Gv+ZkabAlSIu+ODSWqbZ1jFq7CTABdSekwL9dMbg5MORgm5qzeKR
	/1zONYNJRYj+L7MWI9juxfBrZC2+6XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785759258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=ZG8CCAi3py4NlkvxWa/uuQOcnHRk8GKh+89q2h6xLQD0xbXTV+BAMoO0WyZdpEDJm5BGj0
	ZdDn5wCO0VpoSkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785759254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=Ni8tPixJstUs1eh1QB4aasYEoGGCpUK5EyIDy/6JFiTmtr3BJ3+CDd6tW/jxDlEErhSTLf
	fkTS8zLYSKN1Ego2vvLiXpm9V567SreDLeGSta58A9NyjnQTEGDKoRs1l6YIENiV54O/yK
	4BnCZDywLvoa2eDAMC339BPG9iOqLkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785759254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=bXABiAQ7lkJwIoFcC3bHFKrs83+yNiV2qiiSE99WYBzREbw4op1Sxe8wFYKS1B8ZWPa6U9
	lKyLNL3mX8k5vMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7FD779A1;
	Mon,  3 Aug 2026 12:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZ0gFhaGcGp1PQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Aug 2026 12:14:14 +0000
Date: Mon, 3 Aug 2026 14:14:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: remove the ipwireless driver
Message-ID: <20260803121409.GA867448@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260803091938.259944-1-qingfang.deng@linux.dev>
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
In-Reply-To: <20260803091938.259944-1-qingfang.deng@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.dev:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linuxfoundation.org,lunn.ch,linux-m68k.org,stu.xidian.edu.cn,orcam.me.uk,vger.kernel.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Aug 03, 2026 at 05:19:18PM +0800, Qingfang Deng wrote:
> The last mentions of this driver on local Linux and telco support forums
> date back to 2011. This does not prove that no users remain, but the
> likelihood is too low to justify continuing to carry the driver in the
> kernel.
> 
> The maintainer agreed that the driver should be removed and noted that it
> is simple enough to build as an external module if a user resurfaces [1].
> 
> Remove the driver along with its Kconfig, defconfig, build and MAINTAINERS
> entries.
> 
> [1] https://lore.kernel.org/linux-serial/20260218152330.GI26902@suse.cz/
> 
> Assisted-by: Codex:GPT-5.6
> Cc: stable@vger.kernel.org

This is not for stable trees.

> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Reviewed-by: David Sterba <dsterba@suse.com>
Acked-by: David Sterba <dsterba@suse.com>



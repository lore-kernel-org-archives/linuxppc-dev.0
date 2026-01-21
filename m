Return-Path: <linuxppc-dev+bounces-16099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA8D262B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwxnv6w1Rz2xqD;
	Wed, 21 Jan 2026 19:15:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768983315;
	cv=none; b=QY8anCu7bHzp3Wz3hTSlkwmn28bQeiB6wxGVVGkTSmpWkRHhCyieHBc/T7+zyuje021goW7Qg3YFf6fCYrlsZuH2O+Q4FGoh6WungbI5ubdZmQKa8MlGbwhI/Yop3qwY2XisgAKv6bnMVLSaqZYBscpbEql3DiIEQYkpgYPGg+K9WFu5vl2nc+itfa7Q0OKYzFteLMms2FlAlLUc2Ntp0sQwWREXT/K4E/TPvi/7DYHGuXHRHDsNew5UvGppYVZLLcaBL8S37hpWDbikX0TWH7w5WD4g5Inmodf+JtEot5QLRmspkox66RfRZ9RPhObIm1Tekovr1PghkOIoMpBlng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768983315; c=relaxed/relaxed;
	bh=hoGafDDFMRAR5Tk3zA428bAFutgrrNuIEEO2eAwR9Y4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNlp8efS868mbESILH0sOFfNm454UscH7AFPoMnccu69tySat5kbulEmcKvvwTio/NwfuOjl8wcxwj/V7YOmz4gTblePB4klr7BxvhyLi3hsn6G0KdINdgng5By+Um/ojs7bLeL3EVvT2hIbcBB/ro4pdYyIo85HvN9jfTA7uHEaYSsNEGKSCGsxBcJYHFTCfTOib4NdmjE+9rs1P8CAEX+pORSMT+SQicaPC/Phvdvc9wKgoEPdI5+TXN5rs0VDqYklc8+QndyMk0gMnVkm/QniWkuYGNEnnEsHdisaPx6QxBX7EYYm1HxfPL3ECzh7yuENLA+MRXQSiX8W3noqlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwxnt6ryTz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 19:15:14 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0ED5BCCA;
	Wed, 21 Jan 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF593EA63;
	Wed, 21 Jan 2026 08:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XS7yFA6LcGn7cAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Jan 2026 08:15:10 +0000
Date: Wed, 21 Jan 2026 09:15:09 +0100
Message-ID: <878qdrs7oy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,	Michael Ellerman
 <mpe@ellerman.id.au>,	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,	Alex Deucher
 <alexander.deucher@amd.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	David Airlie <airlied@gmail.com>,	Simona Vetter
 <simona@ffwll.ch>,	"Creeley, Brett" <bcreeley@amd.com>,	Andrew Lunn
 <andrew+netdev@lunn.ch>,	"David S. Miller" <davem@davemloft.net>,	Eric
 Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,	Paolo
 Abeni <pabeni@redhat.com>,	Bjorn Helgaas <bhelgaas@google.com>,	Jaroslav
 Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Han Gao
 <gaohan@iscas.ac.cn>,	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,	linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org,	sophgo@lists.linux.dev
Subject: Re: [PATCH v2 4/4] ALSA: hda/intel: Raise msi_addr_mask to dma_bits
In-Reply-To: <20260121-pci-msi-addr-mask-v2-4-f42593168989@iscas.ac.cn>
References: <20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn>
	<20260121-pci-msi-addr-mask-v2-4-f42593168989@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0B0ED5BCCA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[netdev]

On Wed, 21 Jan 2026 04:49:40 +0100,
Vivian Wang wrote:
> 
> The code was originally written using no_64bit_msi, which restricts the
> device to 32-bit MSI addresses.
> 
> Since msi_addr_mask is introduced, use DMA_BIT_MASK(dma_bits) instead of
> DMA_BIT_MASK(32) here for msi_addr_mask, describing the restriction more
> precisely and allowing these devices to work on platforms with MSI
> doorbell address above 32-bit space, as long as it is within the
> hardware's addressable space.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> ---
> v2: No changes
> 
> hda/intel maintainers: I don't know if this is the correct restriction.
> Please help with checking. Thanks.

The quirk is used only for AMD graphics chips, so this should
(hopefully) work.

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


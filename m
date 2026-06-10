Return-Path: <linuxppc-dev+bounces-22390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BEECD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 06:18:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZwZn69hDz2xl6;
	Wed, 10 Jun 2026 16:18:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781072321;
	cv=none; b=BCNCxDmXHKL1hl9vXtYW9/AZDZR9CjfXgIaOEZVjW0RyJJzFF7vgyH7s3GSKOuKcp0Usf9SG+2LXWP3m8M49VHxiNDhASjF8Tox+Owi7v4rE2FbqA/3qPnYnqgEatb/CiTXMD4qskkjBGKhMYo6bcUmJta28mrJsvcyOhwqJRYbB8BStCr0633A6XOW9Fu9Bfnd75Yy/4JcOeujXJtCRWR2WmaIskzmiTODAUY13SwNiB7NtRiy3+rfDq0qpO0y4fKEWeC+Gq5RFrKETnV1eJqQXDndjfwx/iPoigpH+QeoQF6IxtLVxNdM/ZP52jutT2nOI9G9Adp+JTPy3GXTgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781072321; c=relaxed/relaxed;
	bh=s+GP0a8ZirfMN7kbnOb/KtxqIFFOh8HL22fIzppsPn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0Ep2UIym+e+azpvC0S2YKJki97aTtiztx552FJAzRI5LpHgjIlpSEKIVN7XRRUOKLff5fOXjqL6tDLl6rH4dmNI9TY7ALWScRmwCwNRvEeARQ7qOKF7ce/Kse490Y9xWNVACuc1BfgEQ2CT1//WHLHzDHKRbZoyqHdrIErnLdLSGCZIlaQ+pn9hxSofTOv6cpWAAmybtkxwld41T8edvtQzEZfsL/41FRppaYjIrhxgk7Kl2lOiUvHm9SrJqIt6XqJ359rnhZT6ofP0/F2TLUpWbmk5DMUSZuCdBvJK/nFqqkeNFjc6EEEE6TU0Z1fq2gS/lbgk5xE/GJnljO9Utw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SVpKnNC2; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da1YS6pB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dHBQ9zEW; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=92FfC9HX; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=hare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SVpKnNC2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da1YS6pB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dHBQ9zEW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=92FfC9HX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=hare@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZwZm2ph1z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 16:18:40 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84C956A889;
	Wed, 10 Jun 2026 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781072316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+GP0a8ZirfMN7kbnOb/KtxqIFFOh8HL22fIzppsPn0=;
	b=SVpKnNC2JmXryTDslmEYyB0e99KwqF0GeUF/jDy2hQBhzx/GP2JUpv/za7n1SlXjbQky3J
	O5ib3hrYKvYihZ0nS0S7P2vfU/PR+Vh5oKJjEqg+EiQc8EenqNwEp1W49gBvuVS+Fp3rl5
	YZ5fQYAJqCmNLjRkpEccnQY9DIYy8wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781072316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+GP0a8ZirfMN7kbnOb/KtxqIFFOh8HL22fIzppsPn0=;
	b=da1YS6pBj19j0LUrriJuEsY/iV9lqH1UoI6LSRGX+8tbH3sCd1ifiCGd3fioGtsbKmiFXY
	nCBKTa5oUoKCwgDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781072315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+GP0a8ZirfMN7kbnOb/KtxqIFFOh8HL22fIzppsPn0=;
	b=dHBQ9zEWjKpErNcF7KhLeWgzYyK+DK7mkyV2cjFWOFUOVtoI8spaS6pDKDWXZ4UYg2EfEq
	Men+SNGx216/alOXfmS1CZzM/v6R5ZKpxPhkfLsrZwXNfK2MSuuwRFMgNSkWGPduZi97UT
	6V3GFBZtnMLm6qs2V1vuMiKLVZh33Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781072315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+GP0a8ZirfMN7kbnOb/KtxqIFFOh8HL22fIzppsPn0=;
	b=92FfC9HXyMLa/RGf3EI/JTv11kcUg/fkljp6rPccZ1Gmhh52m2g7JvRRyaAZXlhFS0SNDD
	2DZ5M7O9CnfvTSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D489779A7;
	Wed, 10 Jun 2026 06:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id esOfFbkBKWoafQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 06:18:33 +0000
Message-ID: <93a82831-608d-4462-a019-26b3adc7089c@suse.de>
Date: Wed, 10 Jun 2026 08:18:33 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] block: drop shared-tag fairness throttling
To: Sumit Saxena <sumit.saxena@broadcom.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Adam Radford <aradford@gmail.com>, Khalid Aziz <khalid@gonehiking.org>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
 Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>,
 "Juergen E . Fischer" <fischer@norbit.de>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Finn Thain <fthain@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
 Jamie Lenehan <lenehan@twibble.org>, Ram Vegesna <ram.vegesna@broadcom.com>,
 target-devel@vger.kernel.org, Bradley Grove <linuxdrivers@attotech.com>,
 Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>,
 Karan Tilak Kumar <kartilak@cisco.com>, Yihang Li
 <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>,
 storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>, open-iscsi@googlegroups.com,
 Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
 megaraidlinux.pdl@broadcom.com,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com,
 Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Geoff Levand <geoff@infradead.org>,
 Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini
 <nmusini@cisco.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-hyperv@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
 virtualization@lists.linux.dev, Vishal Bhakta <vishal.bhakta@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Bart Van Assche <bvanassche@acm.org>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-4-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260609121806.2121755-4-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_GT_50(0.00)[82];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,oracle.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org,acm.org];
	R_RATELIMIT(0.00)[to_ip_from(RLhytspa9b8ghbrab87o1fjg5u)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,acm.org:email,broadcom.com:email]

On 6/9/26 14:18, Sumit Saxena wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Original patch [1] by Bart Van Assche; this version is rebased onto the
> current tree.  In testing it improves IOPS by roughly 16-18% by removing
> the fair-sharing throttle on shared tag queues.
> 
> This patch removes the following code and structure members:
> - The function hctx_may_queue().
> - blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tags
>    and also all the code that modifies these two member variables.
> 
> [1]: https://lore.kernel.org/linux-block/20240529213921.3166462-1-bvanassche@acm.org/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   block/blk-core.c       |   2 -
>   block/blk-mq-debugfs.c |  22 ++++++++-
>   block/blk-mq-tag.c     |   4 --
>   block/blk-mq.c         |  17 +------
>   block/blk-mq.h         | 100 -----------------------------------------
>   include/linux/blk-mq.h |   6 ---
>   include/linux/blkdev.h |   2 -
>   7 files changed, 22 insertions(+), 131 deletions(-)
> 
What tests did you perform?
I'm pretty sure you see an improvement when having just a few drives,
but what about having a lot of them (ie tens of drives)?
The whole point of this was to increase fairness between drives, so
of course removing it will make an individual drive going faster ...

Maybe it's an idea to move the fairness algorithm into an I/O scheduler;
that way we can keep the original behaviour yet get the performance
increase if people want it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


Return-Path: <linuxppc-dev+bounces-22389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33C1CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 06:15:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZwVk0nwjz2xl6;
	Wed, 10 Jun 2026 16:15:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781072110;
	cv=none; b=OvKXS4mSBAPj2ohahi9oYEtfMp1CjGCUZNNiX6IQZsx8Ees/TdbDOKVNT5VVFGpXtqxTcDclXxuosTdKaJojmgZ6eQlU6MjiHFAvwasNZgDisTHm9jTdvxCjdE/lNTyuI31SDmIjw1pWGiK4CRzHJAQxNPVhRgswPFFtUoUWa63t3qQi6RKAn6jcospbqxhNsobRwNRSRYyjGbXCw31Nl3tpGEqg8pAMcim2d7P/BqS3OVc3Hba5dKD/5wwodiVYK1sY8e1jh0D4kyoYls2PnOTKcqYEje0g/5VGzbyeoBgmQY0StfAP61l0I62yay2h0ZNrG8lxKyjjcPNU4XUe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781072110; c=relaxed/relaxed;
	bh=5fpuLCYTLSfZqoqCj1yrU/fpNj0jEx06J2udbdGke8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4NweYcWzPO2fqVmHEBKGBwA4e/H85mbhUNBp5H7zraZLyJJZEIZ2c0hFkNHINlDnpT/p4V1Kn45tKAVXuHtHnW+Ah2QugRs1fL5VN4zjeYNY783WgsIVsKKsP4sQLPHUsTeixjAQzUYO6Qb6FSr15rR6Qx/7Bau5AzzemOyF15PLXkfxLFoxWNHTR/AQ92y8z0yDBcdgAj6uZVnjp6SdbQtasC+FkrK94sPWneYBf966Z6efHlCZZ3bCyzlqWUHYQOwNg1/dEs2olpXJHAnXagB0ofWKnOHWNE6ykbxpnSvLOzZGeYlSivc+udaLQ7TOrE+1Kr1kzmmtlWY9OvRYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OFImmvbh; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+081cf7365c78a3b9f81e+8326+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OFImmvbh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+081cf7365c78a3b9f81e+8326+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZwVZ5S6lz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 16:14:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5fpuLCYTLSfZqoqCj1yrU/fpNj0jEx06J2udbdGke8E=; b=OFImmvbhxqzG81oeZG+qkLiWj/
	O+FoTgH6IsD9H6izBN+zbpqolbxqx+9PFaalE0ngf4ZPtIVhKG3FWNncNpUvassE+pMoxg7uJ1dlN
	o/1a+N0fBlbkrkKv2jfdrPPcrlf8nC1+BFWDS5uwfZXWKBQIW9aXC8ONxzWjN5GQqHnNRYbkZWGsc
	r9zOlolOC8eIVseUzidKJhPi3wTenh7FHIi9rxabyyO+h/40Pa5f3/VNUtd20iNePgabwc3S+cnjT
	Kd3X/a3mAFndB1a4zGa1uW8ACr+9Jp1LawQAr1tSl3VC1bdB13cQxeZxqMdPuJ1TIqqIwB6io6LeU
	cbljK5hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCCZ-00000006rUM-2is2;
	Wed, 10 Jun 2026 06:14:11 +0000
Date: Tue, 9 Jun 2026 23:14:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com, Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com, Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 3/4] block: drop shared-tag fairness throttling
Message-ID: <aikAs4X-2NWTuwCc@infradead.org>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-4-sumit.saxena@broadcom.com>
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
In-Reply-To: <20260609121806.2121755-4-sumit.saxena@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just dropping the fairness was rejected before and there is no
explanation here on why any of that has changed.

On Tue, Jun 09, 2026 at 05:48:02PM +0530, Sumit Saxena wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Original patch [1] by Bart Van Assche; this version is rebased onto the
> current tree.  In testing it improves IOPS by roughly 16-18% by removing
> the fair-sharing throttle on shared tag queues.
> 
> This patch removes the following code and structure members:
> - The function hctx_may_queue().
> - blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tags
>   and also all the code that modifies these two member variables.

.. and besides that, this commit message is still entirely useless
as it doesn't explain any of the thoughts of why this change is safe
and desirable.  While the mechanics above are totally obvious from
the code change itself.



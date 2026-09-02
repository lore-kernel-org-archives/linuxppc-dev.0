Return-Path: <linuxppc-dev+bounces-26447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80792C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:38:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZlj25cHzz2xpn;
	Thu, 03 Sep 2026 00:38:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788359926;
	cv=none; b=o13JD6vzwFJpDDvFo/AQpyrhGlmD7N222MEuuI5K+A/GqvWhcl9xlmoZ6jPldwg1EIHtSGkFSBz/80tN01kW0AvNgRlRHvzYVU2AMLitmEARG6NymAMC2xSvT+UOZafS8RWV33sK5L5C3nLN5dtekXhcx++uG+gXRT0A/VP4UVJq7OAS/2MbUd2PmZOiv9lIDAjVh0jpCs/butqHZTYMvooN2rSAzZonRdHKnHEz8rX5IHRhH7VenOw86h+ynSFZ/nVZMUYsQXsHFyxza76I+yRvo3XmjeE1DRjc/X6+yymBoPW4UlaPwBk6PQSy3HPJUqqJ9U03MIaELC/+RVKWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788359926; c=relaxed/relaxed;
	bh=F2Qj5ssAwsoQVc9Ky5Bzi5ZGDu6J0aL7LPT3x6KMRtk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=OGmxSDaHC8J9pYM9cv+HAt1Vc0+FG4AYEXwK7jhV6BGWLHDYH5vNokTDM00KtbhfpjIVvaKCDNNESwKstxg/wmkGta0qBTIV6z23mpY2dx15K5/QAJ6xBr40oSeLjBVMrgPid7WAvNZWT0JhKRNJnSceRhietxDovpuPAwcSEM0KWjOiBhHqQBNAt0ANrDT5iZzWJNDjtj3DtqBQm820TiE514+I8sYWrIgOnG3/fvyz2pp/3XQjHB2Qv8u9bQyPfxOlvLTsMd2Suw+oAvPDA3rpjdVApvorBRkSoiOkdWHroUebBEpkjvRG3HdBPSvlN9hhHAnrCpMekC+CTG87Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsO7CQhF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsO7CQhF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZlj2069mz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 00:38:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 07015600C8;
	Wed,  2 Sep 2026 14:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739991F000E9;
	Wed,  2 Sep 2026 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359922;
	bh=F2Qj5ssAwsoQVc9Ky5Bzi5ZGDu6J0aL7LPT3x6KMRtk=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=nsO7CQhFmWDLHfEhLPHRdHLju4aE7MAjcJ0gbu6iymlmNrLpfO1f1i3VDZfvhE5UY
	 ReY6+Lq2L8ll0yStG8cu+Y2DEW5Eed1TqEFwXOXNAAk3KH4Wu3lUQvZ+eSKWK2K/sn
	 Htmo9pLFNAeja1O6Sv13zhwRquKx/5vd/iqNRP7nO+r5zxtWfvnTiVNr/5KxYIBihV
	 fq+J3wspALqrzBFJAn50ouUfx61s/nXl65wa+m26bi+nuWTahG0AD+qIzAYs0pe4Vz
	 EzEN4YHQPa8ZlTlReAm9DL2U1zr2JeYc5CiKkB3M6EJ2PP57W3tmE8n+XwJgJpPgGk
	 iSRg87a8fcwMA==
To: John Garry <john.g.garry@oracle.com>
Cc: James.Bottomley@HansenPartnership.com,  mkp@kernel.org,
  linux-scsi@vger.kernel.org,  bvanassche@acm.org,
  linux-s390@vger.kernel.org,  linux-ide@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  linux-usb@vger.kernel.org,  John Garry <john.garry@linux.dev>,  Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v5] scsi: core: Drop Scsi_Host.default_lock
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
In-Reply-To: <20260831095821.3486994-1-john.g.garry@oracle.com> (John Garry's
	message of "Mon, 31 Aug 2026 09:58:21 +0000")
Message-ID: <yq1ld9jg1lv.fsf@mail.kernel.org>
References: <20260831095821.3486994-1-john.g.garry@oracle.com>
Date: Wed, 02 Sep 2026 10:38:40 -0400
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
Content-Type: text/plain


John,

> Back in the 2.6.xx days, it was possible to for low-level drivers to
> set the shost lock pointer. That is why there is a default lock and a
> pointer to the shost lock.

Applied to 7.4/scsi-staging, thanks!

-- 
Martin K. Petersen


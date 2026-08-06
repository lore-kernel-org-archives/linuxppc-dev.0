Return-Path: <linuxppc-dev+bounces-25502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E1CC56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:15:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDSX3kC5z309w;
	Fri, 07 Aug 2026 03:15:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036540;
	cv=none; b=TLdO0y6a6+zBMWTa4OoibKuSoUxBkuL8ap/t65teOfzVuZ+MxWxwoWaLAv4BngL1O2l3WittwAd0oEeb26iLgU6qwuu+KLCWRFDlDDHcQwErVsMe8jqUzLYe4XbrLzMcIZOkyCnqqzA6YoJtFFmoCugvlmFJCMogIdTtHBVtQ8vjs3gDYEGnefihnVGU8Zay8zp7kvRnTkWyOpL41diz9wUoPZcab8XPv9qarbYhZpR41pGE6DHH31uvKNQT7kGnFzl+HqsUf+mFeUhk5tA69eHM7QjzM8Qr7YXrMoYQeVwNkrnX0oRe4psVq9C9TKnXyRK8uC+P1DAQoCJDveq5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036540; c=relaxed/relaxed;
	bh=oZXhusvsNiVTw2LNWdGhAncH7EziQoLQLzjFcfA1dQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGtqZF/+1rJ3kMpkX7q7BOwOgCafmp5TS7sVqVwqx2GhbWxkx6Z584UVYjMlQP0TBPugQC4V7Es4C83ciWADa31+8xx2IbH3zpBMrF1MZQSAuk3fizTLd1EY0aPjwxThAHjkXZRk+jU2TJ5GZVIXxnNKTKCMPSsPxAwFC6ORKIMU/Sp2VKC9rKGoG7waNKakKsrDeTwamR4BgLkO7c65aKGHDo4oflu4PHPolXmmI00tElCQ2jWXlX1esZR6aDuxMYN7Cgj0t5wrllxDCmOF65QcMHVH1f7+OzGN2xxGAoJx2xZICVt+oCTEmpuu/L8syJyiByQ4kYWFt6GgLL1CgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=fWfd1pY8; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=fWfd1pY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDSV35wjz309r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:15:37 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hGDSQ5ZWJz1XM6JY;
	Thu,  6 Aug 2026 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786036529; x=1788628530; bh=oZXhusvsNiVTw2LNWdGhAncH
	7EziQoLQLzjFcfA1dQk=; b=fWfd1pY8EngREmKrsn1S8hNEj7f0sqM7rlcwqbUk
	Grko2xpUnW/70erJE/bEDvBjLhZV81wgTuWUyPjvAx1h5f5roRtsMCAllwG1Ol+8
	/ZTQ142f+jOnBM88ZLCYthJLY6Yupea0wr6pZp5+GMDiGlfif6xz9YiVqdlQ6QOB
	wM+Wf9hEBJzzfolsv8WfK5/I1OIHZO7nuE4d5Q+Ut2oUZ97hDVIETpVTIq7NZH1e
	rJij7FW+iu+cRjT4Z3juRluW+YAfZ9CJVmMXM9H4yVUAvZz861nKdtW2s1vsdX8n
	XZdg3xAS6j5VwgUP6NC02L3/WPwlqI+4j6YwFFEonqWKDw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fKxYKzoNdV_x; Thu,  6 Aug 2026 17:15:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hGDSG5l6bz1XM31H;
	Thu,  6 Aug 2026 17:15:26 +0000 (UTC)
Message-ID: <9d9092bc-6bf0-4afb-9d1a-5ee16c9c501e@acm.org>
Date: Thu, 6 Aug 2026 10:15:25 -0700
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
Subject: Re: [PATCH v2] scsi: core: Drop Scsi_Host.default_lock
To: John Garry <john.g.garry@oracle.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 John Garry <john.garry@linux.dev>
References: <20260806113958.3127942-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260806113958.3127942-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 4:39 AM, John Garry wrote:
 > Getting the address of embedded host_lock structure just requires adding
 > a fixed offset value to the shost pointer. However, getting the value of
 > the host_lock pointer requires loading from a fixed offset to the shost
 > pointer. The latter should be very slightly slower, which is relevant as
 > this lock is used a lot throughout the core code and drivers.

Hmm ... SCSI drivers for which performance matters shouldn't use the 
SCSI host lock in their hot path.

 > @Bart, Can you kindly build test this? s390 and sh were causing some 
build
 > issues for me. Thanks

This patch passes my build tests, but an update for the references to
default_lock in the Documentation/ directory is missing.

Otherwise this patch looks good to me. So with or without the
Documentation/ update, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


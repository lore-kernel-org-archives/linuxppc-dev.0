Return-Path: <linuxppc-dev+bounces-22053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A464CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWTb86rzlz2y1Y;
	Fri, 05 Jun 2026 01:52:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780588324;
	cv=none; b=Degg3UwVb4B7yRBkzxG1v4Gs62hlDIAOCpwqAonBl2YePtzUMelEMBnEhKfs+7EtWXkJ9OLAyCGQQwDSiawoJrDSJ9nkQoSxFkPR8a7oeAXQVWyABfU/aVSFoZieiVvUz9TO7Tc01UV1K5SpA2/aU6w0oxuIrY36KJQawC8TUXi6jSS5Iqzj91gsO+fJnKNQXkJ6dkvvgrURapdhUkPTVJ7xNeZyYLk7j1zFAqsLM6Gl0PZaqgP8uUQJwv7GtXxUXqgAa5I3ye/G5chnWoXseNWGzBUKTW4qrHTkdaZ/77YyCAcdKKs6OlslOYsHbeZpgBM5fSMaAeKvo+yBEuti0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780588324; c=relaxed/relaxed;
	bh=2qqrFJaTeH6MHgGjCQt4vdbZsFYouddNgxg6pnlluvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYGZ4U0VI5SXZQ06q0kJAODbJOusU4ZLZRysb/yjZ+IpYALvXwbHUII+vSGkBE7RLIgKm8gZC+sfPA4NnpGxVoeM+tNhctNmOvoFJqA2Q6fvmR4oXW/D/xX7Yw5WTYZk2JUUT1kacvA9blsognb0cDXUs38A5IbwngsJrSD59uZvRQoyzSJGeogYlPzle66JYu3PtBfnzaiIMx/p7X4UeJYIOq1aejkqAAPufo1J+7wpBhTtE0W8ik9YN9LJRidjMMwGJVEMK7jL4ZVIgQlCynKEZbHxEKFLMzeRLSrNa4G/LT1HgzaQv80eipPh2K7ENk2hGgcazb0AkPPaWoKQpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mg+HoO27; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mg+HoO27;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWTb82yPyz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:52:04 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gWTb63lMlzlfvpH;
	Thu,  4 Jun 2026 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780588314; x=1783180315; bh=2qqrFJaTeH6MHgGjCQt4vdbZ
	sFYouddNgxg6pnlluvA=; b=mg+HoO27M6OaK/LqatxrCYJ2M1wpks/qWxEByk4y
	ThJCSNik4jz2YyVfO5R0Jj9jA4mLFtC5/GFXmGLsP9WMaBf2zsR6WDR0GZ6bPPqp
	sC5/DLaf4dGGpG1EIxOp+FDPR7oz/8e0F7HdDmkcASYcstx5G+/eaLAeZbey4jSt
	j0vQ+lfVdN6prAtwGEtKb2vhoTY974Cc4TZc1YkuK6Vti7klQ+Dw6EiE8yYJ4FRG
	55OPZ9a6Wod17AauM6/U9oKVqlbyK9Iqc829vlrtrBb0DZ8uZmYysborZmV0AZ4L
	zw/Jgo06hq1WyF4ZNVPn3kKCA6wslrMLmNVq83g+cEVDHg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VBSeo4SXF3py; Thu,  4 Jun 2026 15:51:54 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gWTZs4WVJzlfdvh;
	Thu,  4 Jun 2026 15:51:49 +0000 (UTC)
Message-ID: <3f5d1bc3-bc8d-4ac3-bf7f-05a0dba86490@acm.org>
Date: Thu, 4 Jun 2026 08:51:48 -0700
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
Subject: Re: [PATCH v3 2/6] scsi: core: Move scsi_device_from_queue() to
 scsi_priv.h
To: Catalin Iacob <iacobcatalin@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-2-e2f06fb4eef4@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-2-e2f06fb4eef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 6:20 AM, Catalin Iacob wrote:
> scsi_device_from_queue() is only referenced in drivers/scsi so move its
> prototype to drivers/scsi/scsi_priv.h.
The subject of this patch suggests that the implementation of the
scsi_device_from_queue() function is moved while only the declaration
is moved.

Thanks,

Bart.


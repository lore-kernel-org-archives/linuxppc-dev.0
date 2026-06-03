Return-Path: <linuxppc-dev+bounces-21985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BA7CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 16:09:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVt1K1W30z2ySJ;
	Thu, 04 Jun 2026 02:09:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780502949;
	cv=none; b=SdW2Yec4PE8/ngqK6HSG0YNlwojheJ/phSfKIrA+LT0wMeD8KVcg6f/GDyzgtKKJcFtUt/+8rKeNB78DZtvgGKaudqvnbpraekeZrRD1PhS9CEf0je0KhwEzYAZdrqggYTq+jSSGxUY1uaKGDnMda3r3KBrPtYoG2QAUDJnI5gYM7G3EioBfs1g44eHYl1nIOdAm5Y51BaEuUXXMnw50E8xX1kbxHj3cFNF2QAUkrWbe2/Moe5UqPIO1e5JLw7Ox+CszoreExb9Ijmi4I2eV1M47IH7i7iyqr8cQbcLWvzGvglm/G+19LFTVIuikayz9EYE7QGZRzaxxhtZdMWGuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780502949; c=relaxed/relaxed;
	bh=bM1kqB2I7ccNsczdRZIIAAZKhxV1GPeCnq/iZ+usHRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3XydpwS8Scr3y94w3RrbEpcMfJv8DCMWKVOdp5uQ7jk1gaP0uV5cr93gTjpHr36WTQo5o6uvcr01HDPRLDbPa1qU0RWHsVdnqXLZjAcv6m7OjKrHVgXdEC6WBHlLClmT5aujapbIU/hUsj427WR9E7wH5P/MDarNj3o+1LxcKI8wXmcr6S6EWEqdaFxY4/45w5pWggq4wWnPRqtswlFpMY8alq+vEVKpEewDK9J8XBGuLxVRMS50ZhigQ3FPtnbW5dcwu//UlggJltNBHgeSn+r+I5NyT7aRK2VNxKZQHwP889QJXdM3d3W+jPi+YnQwKJcdzdKwTBrUTHVjA1oyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=WFhRJGC1; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=WFhRJGC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 142 seconds by postgrey-1.37 at boromir; Thu, 04 Jun 2026 02:09:07 AEST
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVt1H2jwZz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 02:09:07 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVsyT3ks9z1XM0pF;
	Wed,  3 Jun 2026 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780502790; x=1783094791; bh=bM1kqB2I7ccNsczdRZIIAAZK
	hxV1GPeCnq/iZ+usHRI=; b=WFhRJGC1VTOKqg4nbUqjw8wUmajyhrl20glXCTfd
	LYB7LGRo0dUZiohl1oPSb9dNBvdWnXwnMmMA0GNx8+XQsWCVJ75zMTVO0BGj5gdp
	XKOzAtbjQYtOojx5YiErCZ9mkbgpESywbHaW4VmjrLupv9pcGKK3BxhHOcM+qsgW
	scfdqsdqyFPqX414+BjQZBu+hGLIc+v6Ik94b4VyE37jmMcDwo3JZaBPBEIOgGsM
	5Gn3Yms08CLgGjcq+q4ZbfgW0PkMTOMFBujDZYNYKhTBC7dzA5+PfHwiPf2nOsS6
	aFjMotJljKzXKHXlYaeNl8kur3nL9jPyDQKCRn3/z9pBFg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4C0YUrlqjY_B; Wed,  3 Jun 2026 16:06:30 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVsy85MS2z1XM5kW;
	Wed,  3 Jun 2026 16:06:24 +0000 (UTC)
Message-ID: <fe0177c2-815a-46a7-911e-754a27e212d4@acm.org>
Date: Wed, 3 Jun 2026 09:06:23 -0700
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
Subject: Re: [PATCH v2] scsi: core: Remove remaining references to the pktcdvd
 driver
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
 <20260603-remove-pktcdvd-references-v2-1-c4402154d53a@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260603-remove-pktcdvd-references-v2-1-c4402154d53a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 6:27 AM, Catalin Iacob wrote:
> Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
> CONFIG_CONFIG_CDROM_PKTCDVD* references in defconfigs and around an
> export. Remove them.
> 
> Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
> ---
> Found this incidentally while looking at kernel sources to understand
> what pktcdvd is
> ---
> Changes in v2:
> - Reworded commit message on John Paul Adrian's suggestion to be about
>    the removed references not the export symbol
> - Link to v1: https://patch.msgid.link/20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com
> ---
>   arch/mips/configs/fuloong2e_defconfig    | 1 -
>   arch/mips/configs/ip22_defconfig         | 1 -
>   arch/mips/configs/ip27_defconfig         | 1 -
>   arch/mips/configs/ip30_defconfig         | 1 -
>   arch/mips/configs/jazz_defconfig         | 1 -
>   arch/mips/configs/malta_defconfig        | 1 -
>   arch/mips/configs/malta_kvm_defconfig    | 1 -
>   arch/mips/configs/maltaup_xpa_defconfig  | 1 -
>   arch/mips/configs/rm200_defconfig        | 1 -
>   arch/mips/configs/sb1250_swarm_defconfig | 1 -
>   arch/powerpc/configs/g5_defconfig        | 1 -
>   arch/powerpc/configs/ppc6xx_defconfig    | 1 -
>   arch/sh/configs/sh2007_defconfig         | 1 -
>   arch/sparc/configs/sparc64_defconfig     | 2 --
>   drivers/scsi/scsi_lib.c                  | 8 --------
>   15 files changed, 23 deletions(-)

Shouldn't this be split into two patches - one for the defconfig files
and a second patch for the SCSI core?

Thanks,

Bart.


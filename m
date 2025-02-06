Return-Path: <linuxppc-dev+bounces-5897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74227C0219B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2025 09:24:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpWsP04Hsz30B8;
	Thu,  6 Feb 2025 20:24:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738833896;
	cv=none; b=mSgOsQAM3BVPugJNPK6MZMMg798C6dvOIV4zndS4dBof1EtJWmL8Pd4YaWyDiDd7iLo9xWff03lkjBSAAZ25F1ZMv6hAwzCyEhJ/ZLnMWkydIfGH7TShK3THyaiOQxBch7Nb2VLfPZZrAQbYGPhTgU/AfCe5kyyEhAwjbBqd05UgWwcvioVP8y8K963KS68eTjAmxgZhanBp8XaDzfG8lbX0KvTsvks6vAtEy16U72FS3tZ25cGFWxSEBT9kaReZIlBTvzM4CJborx9ayJordGTNxFSH6//crGnS8SSJ88opJfzlytdvv/L7YelqPpK76yrYaE5aQYr37VTodVX8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738833896; c=relaxed/relaxed;
	bh=GOKHhtW/Dl3rRO6ZDM4GAwjYYG1gpsBie8HuDj0xE8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ogn6yVPsRSdwVWof/PNMTIxb65cMBNjloIXIbVAsMzTqT30MDAa2BsOEIcKO7u1fOv5cqECKoDRzVfD14stI/g/v4xwOAU9vblJ/7CfJxEbccqRf9mnAHy0J5rDWWUVBPNIwtvv9/ZR9jVACnak7vKZeAfqIV6klBwsDjppdAsY0xTw9e4oMLIO0+Tvzn1YYdftmPStoko1DQQc+aaV5Khumxk2x5nTwEoc1tmH2XEQhgJnFxL/L9/GJLYMoDRePTPJr+d1ij8FL5Z+PZfQc+aFlw3SC+ZcTVeKg9Jm08mXFnH1MvSnIc7oy5j/cjp3GAoKfDEf3k2hwhe7vII6BPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpWsN25Hnz2y66
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2025 20:24:56 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 5F3A39E5;
	Thu,  6 Feb 2025 10:24:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 5F3A39E5
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 3202915E001;
	Thu,  6 Feb 2025 10:24:53 +0100 (CET)
Date: Thu, 6 Feb 2025 10:24:53 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: panic in cpufreq_online() in 6.14-rc1 on PowerNV
Message-Id: <20250206102453.0d33c49f7af374510a995288@danny.cz>
In-Reply-To: <ugquf2uym6q572y2rck4h63wsd2us6jz7cepnqjpnghh6z6he3@dhdn3pvoahyf>
References: <20250206094148.787dbdaa0580d7ed6c510709@danny.cz>
	<ugquf2uym6q572y2rck4h63wsd2us6jz7cepnqjpnghh6z6he3@dhdn3pvoahyf>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:30:40 +0530
Gautam Menghani <gautam@linux.ibm.com> wrote:

> Hi Dan,
> 
> The fix for this was pulled yesterday[1], you can apply it
> 
> [1] - https://lore.kernel.org/all/20250205181347.2079272-1-aboorvad@linux.ibm.com

thanks for the pointer, will give it a try


		Dan


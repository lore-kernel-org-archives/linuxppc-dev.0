Return-Path: <linuxppc-dev+bounces-4964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6197E7719C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2025 08:35:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTw2J1DGvz3cDS;
	Fri, 10 Jan 2025 19:35:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736498104;
	cv=none; b=fGCdhm8n/nUqc7vfgYolMUivCukSyUhvBkqsZuQyMdJHZSl9lu1le4xEuBkmgskLljepuIaZTiwhbsTfnTgVrMpVT0FLjbzhkYcX4x5IRHAjJUp6OaMwT86/un/A6KB87weJXXaQmdNJ0rPYFNJGq0zRlmyXqFBS7AZIzoyjXKyri1JhSnRenXTaoyWaE2Ms6gOoF4+VIh8bgxa21lkDOgfvCYFEwpQ/v7FBWz/QZ7dRnysiqGGhzs1pDFOtEcT9g+npnbOs/VLtEi5ra8PZs2BIyLt50ItmFC+VB4hS4cKL2Q6d+NFQy3qhcMCoFnIvHPNAb/K5DOaPQ4M8hngDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736498104; c=relaxed/relaxed;
	bh=ftR5xK3zV6PsOkkYqYLxN7Q8ut8/FhxpKWWmxghVz1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogfy4j5HREEldvhfz8xOcpLcIHayJy/Gqe3ZWZ1w3DWkCGYFwdesqdjDaJKQ0y9TsInOx2yRZb7RM33EfCHXjlRogTkum3GMceOMxiKPL1HlgtaDfjfPffhtASnhqJnSetCDznN0O7+jxyn/fSvxoQWZPJYte8XLb408yjRX51DxElSSAlary+ID1eNG98uxWdvgip7tw7cT8nRHidfr8D8AcfpA6WtpS710Sfr8avylCFSmur20wFiardLo4yLa/cGr+sPznmbVZbrooEBzrrlJQCB2RQo+KI0Z1nmXCyXTHr45uW8qnG93YJHGuS2qPeNfXrd8Bynv7ZlYVrlsow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1m0nxVOp; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1m0nxVOp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTw2G5v9Jz3cCt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2025 19:35:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 524495C5C5E;
	Fri, 10 Jan 2025 08:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F606C4CED6;
	Fri, 10 Jan 2025 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736498096;
	bh=uetuYKqslO3JkV7dYssDwaERrvLSPO6n/5ur95ONLTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1m0nxVOpUw6difROGwdz3tss2Yun6ocLI9OeVpFRrH5L6RRYqJDpO5hkKrY9egxHA
	 y9QUIHv3eFqIXsspc/e3MAhJrHwGc8uZ1YIhPe1xjxfk0LjBPCJoam9LySTk4y7btK
	 0p4BitTthSB0Sx+6teabyRysYNTOJkD7YOw+BM+k=
Date: Fri, 10 Jan 2025 09:34:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: johannes.berg@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: Kernel Warnings at fs/debugfs/file.c 90
Message-ID: <2025011024-yearning-prism-020f@gregkh>
References: <a1cf98f7-c16b-472a-b56d-f745e94017ef@linux.vnet.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1cf98f7-c16b-472a-b56d-f745e94017ef@linux.vnet.ibm.com>

On Fri, Jan 10, 2025 at 12:14:13PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> Observing Kernel Warnings on kernel 6.13.0-rc6-next-20250109, while running
> fstests ext4/001.

What is fstests doing in debugfs?

> Traces:
> 
> [  433.607975] ------------[ cut here ]------------
> [  433.607984] WARNING: CPU: 2 PID: 32051 at fs/debugfs/file.c:90
> __debugfs_file_get+0xcc/0x274

This is an assertion firing, Johannes, any ideas?

thanks,

greg k-h


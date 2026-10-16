Return-Path: <linuxppc-dev+bounces-29608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3CCCA46C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:21:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5pYX6DzDz2yql;
	Sat, 17 Oct 2026 02:21:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::a3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792164064;
	cv=none; b=PGa3whJoTDNU10uPJbwb6cQfFIurGxc0sU2Gb2Ux86s7+CAbaBf/gqlmCDPfx9ZjSvLgNaRUfH4jremYh9h/xeQrDRyvZiIe82QxIkMJlzog8d0FNvt1CkcVI7orf0X7CR+v645r1ryaCvxs8p/82nMb55fay2izcwDiVkt5WxewbuTnZdjR9G38hKS7lWqAnZv8+g4bonkO2KDSvgiVC2wLrRZleg/u5pMozTnLpe7nYale0XuveUfoojG05QnlpCZC6qUpIFCE3tgBqtylO30mKDXVjqVZphtQrNJ8ITyw1eAVHLOMeTktT4gg5Il4aaIA/dSwc/C9HWzgpyAMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792164064; c=relaxed/relaxed;
	bh=GQR+UVqtdqHo+p84ll+R7GQUXSSsvkHaMsIaIIobxhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkMb5+kpqpDTp/A3AKoo5OQlVJoNndSp+WJHww3UBeDEub+qfHXUmqJt6mYOKJkiYGEja5RseBZ0hev943FCvaMDNkEU6lvostGcjYscHjcNJI2wQ83A5uRXdwEa18LSslJxQV/olmWwRP2l5SpbYKL7oumrb39P6UW0yUbILZJcHbKttE3S9E7h3pPNtXbSfP77nF5h81WUCO/s5rY3rjRdzB7oU7ZxWvc+YNByyJghQyAwGKLGhrfYG6oEIWLBNPZl3BrgISyMmoMODWzTXMyNGzexsxKK0ybeHisUW+YWd4bkmZEYaJa+LfbZX9p3WhhF3CTIg6vsuOxRbGuqWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nWSUl4hl; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::a3; helo=mta1.migadu.com; envelope-from=qingfang.deng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nWSUl4hl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::a3; helo=mta1.migadu.com; envelope-from=qingfang.deng@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 81 seconds by postgrey-1.37 at boromir; Sat, 17 Oct 2026 02:21:00 AEDT
Received: from mta1.migadu.com (out-163.mta1.migadu.com [IPv6:2001:41d0:203:375::a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5pYS5PJVz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 02:21:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=JgjAGc1yvO+GZR/lMz41Sy+B81/XedX2R7qPQROM1P0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792164042; v=1; x=1792768842;
 b=nWSUl4hlokvwgLuhWa48Yuch2a5eeT874fDdERarqgr5Z5NhzlYB6m/1hT5bgfmpWuNlyfXm
 86jIxEXNzxqM3atokqQMUSRoLByurW4VLRCGERrOr59Vw7TcVd4UWIMqcXd4m7LWX0XgNdsdtBw
 c7Qqm9CCWheMrEGAWsG1Ra7M=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8e118369b878a887;
	Fri, 16 Oct 2026 15:19:13 +0000
X-Mizu-Trace-ID: 8e118369b878a887
X-Migadu-Flow: FLOW_OUT
Message-ID: <6d16da53-0917-45cb-a5eb-5b85de5e2fb1@linux.dev>
Date: Fri, 16 Oct 2026 23:19:02 +0800
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
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Brad Spengler <spender@grsecurity.net>,
 PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015165959.i.798-kees@kernel.org>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20261015165959.i.798-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/2026 1:00 AM, Kees Cook wrote:
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2838,6 +2838,13 @@ static inline void *netdev_priv(const struct net_device *dev)
>    */
>   static inline struct net_device *netdev_from_priv(const void *priv)
>   {
> +	/*
> +	 * When GCC can see that @priv came from netdev_priv(), it can
> +	 * compute an object size of 0 for the net_device and its members,
> +	 * which makes FORTIFY_SOURCE fail valid accesses through the result:
> +	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127875
> +	 */
> +	OPTIMIZER_HIDE_VAR(priv);

If this bug only affects GCC, you may wrap it with a
#ifdef CONFIG_CC_IS_GCC block.

>   	return container_of(priv, struct net_device, priv);
>   }
>   

Kind regards,


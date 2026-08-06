Return-Path: <linuxppc-dev+bounces-25532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B555C56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 21:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGL8v0xdLz3brc;
	Fri, 07 Aug 2026 07:32:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786051951;
	cv=none; b=l/GHrJ9PFb3Ps9XScX4bJ6xF/LDJzk9DQ15WX561n2Bcw5SuoqCz3wMmkXY9olQOl+z3CNCUoxwN92YPuY8SPokXaejaOQGmfrm2zz18mu6jENAILtNGXX/oDlgrEHkjP382aOUotdDOptAPHOfUA2c5KI7PFu9FFVGAfiWx3L0DoZ1o4Q2RJCh9i8YOrQ8bqTcilZi3n3YA/TZ9DvN2QLIlzhIfVbizEZ7ZgYSbyjGHQcidHu1qnbrjyHTGKzdx2zTGgGLizpLNk2OELzvG9NKaC2voy3r+n4vmZLW+E9PVBp/uu/Zl0oGtVrBCZXjDqoRIzutj6RD2uTLvpOPvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786051951; c=relaxed/relaxed;
	bh=6vf8m71Thf7y7jGfiPJQl4yxKA5uMf4oLhl2ZsCsSRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avrRIWJQUA5n1Y2iIlNHLN3w8iIEMyDjvvNu/ZB7tJEmqcocIAFtVlkpeyJpnoEa3u/BTRhqyBAdarNQlJM3ETydvzaORkDP4o+iBdLHdIItxM0c+1prk7fJ6H5XqORoVb1CrJOMvd6VMO1UaSYaGgWxFDqJ0R40BBIh+LUj86NRUWEPOpUpqpkD6jTeWbq7MBkPLEuPjeSCzWWAJcmh8NddUnUhwMPt1PMC3MiN3mHq5e9LJHdr1oF+nUQTLqA60H+2ZCWJgk7D4ve7WQnpRjxFBNPS1FcIDq/8pcll7rkYejvL25xll+VjxnybM9hHijMYVGeEuUk2Ke4Lii1fEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Em58OHcs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Em58OHcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGL8t3YZ9z3brN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 07:32:30 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d01663d816so24639095ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051948; x=1786656748; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6vf8m71Thf7y7jGfiPJQl4yxKA5uMf4oLhl2ZsCsSRA=;
        b=Em58OHcsQ6YeaGbrgl34qmPPQrpPgBoQbviiNRloqBHjMpI89/fDty7Xj/Ccjf2aMc
         m6/QblgrA4K6irkCSLTxZM9Kw4JCam/6yvbDMJf9Tvyj8xtLpusm0rb2GUdgDcqCASFp
         tG7isbj4tL8I/iTGfQOEMiZsuZGd9/SJhGh7wKOuKdcuUJ9+067OUuvwULjLsfgk/psP
         U0iq8nrv+X9hygNY7fwouqVpYdWzsYeVc3rEK2Ny1vTSixKLYvcld+VoVx7dPab3Wd/3
         6//2oTVL2IUtJeurp7mAfwV+AUM80cAF5EoDo3STV+fMOREWI6Mz5eLH6sck8o++HkjW
         gwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051948; x=1786656748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vf8m71Thf7y7jGfiPJQl4yxKA5uMf4oLhl2ZsCsSRA=;
        b=gN5iem83ax6YRSQgn8CyqgZ+0TqoKz2icarG8ZDVEL6UYnO+XebkcECMkfKlSjC2Ah
         7apOv6dAmNzfVrCljnVOEVRQbq6WmHAAdj69m/zLvJsQqkijs5kZKiApZwlHLXcZ/ROJ
         Kroksdu991tiH3kKQmIKvf0j1/hcDDumx6JI9iXUNyPY3JqtqC5DeT3U6zFG3OcEyt+A
         Q9jXvYfx5ykVWfxGGfISvRdcqGU+3ScutXKwvuCR9VgQHRcSJp6wnILBTmqEC0jiOy5R
         GaBXR6ZRBa4zR4eFRAufaWtlhIYoE3xTk0O5OaabTPnsAs26Ticl1dw6gkiZVLcIYvxF
         0FHw==
X-Forwarded-Encrypted: i=1; AHgh+RpYRUpFLqI7ULAOqCOhiZQWBe9rAqB1sMuf+tVv4QVRGXe6GLPeMFu8qUXyymWH1VWJUGWMmTqzCSJxIxk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPfFL2sFUrLhH9JCxQ+tTpNifqp2McP1MpVqSMrv5lJzu6mxSE
	LrFDg3yIuk9Vq3Cg63hKwrQRNy1Mpj2VUl1lQrmIVMF4CwItvTTO8n11
X-Gm-Gg: AR+sD10NU9bt2KNUq61aZuZEDBmhuNpxJ8B6Enog8UJ+7VL95qRH90BP3XsJlrRo4H/
	6hDFoYWpZq7R9t1kmQ8OJEKwHYOeH4WTBd+GJxZ1xq2Fx23+BpLXAArLG4QllO+PbQRaCYIYxuR
	nJd1PBNMPCWN5ZUIz/sJvUurxJwWlsMyguolFrrOUewlANEIuDGTa8fqKZY4+1Ij4LptvhHqG80
	09++C8HknXGICsQl7dxffF7eJDv3n+ceUmQIfMK/4D9xvyibjlItqppdgmKHmVfYrA126jgDRyE
	0Wtxk6GsCNhQeTOjt1CJ9HX/D3ee6lDOJ0x7kTWK1fR7s9OoLTBvk5YDBX1XardA1V8f+fze8pb
	7ybWsgWzc7n4hf9yPnREwzGKO08qC13rLbNg7SrZbRzywHEgoh4pti7zH7+Fvvgq0r1ZeVwSUJL
	W7q/vhUQHngVxvzupqoTtz+n/GNyNdLsT9hCj65sdQ2FXj3XxggihYBQRQo8xJvzr9hb0VJLQ/4
	4ueUdX9+c+J/S9k49W3xjnF
X-Received: by 2002:a17:903:8c5:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2d106e99159mr54741385ad.22.1786051948008;
        Thu, 06 Aug 2026 14:32:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e957esm235465ad.75.2026.08.06.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:32:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:32:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: wdrtas: Fix kernel-doc parameter name for
 wdrtas_reboot()
Message-ID: <cb17b508-71fe-4c74-bdc2-58d622b7eef5@roeck-us.net>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
 <20260730060617.7-2-bbnpreetsingh@gmail.com>
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
In-Reply-To: <20260730060617.7-2-bbnpreetsingh@gmail.com>

On Thu, Jul 30, 2026 at 06:06:16AM +0000, Babanpreet Singh wrote:
> scripts/kernel-doc -none reports:
> 
>   Warning: drivers/watchdog/wdrtas.c:460 function parameter 'this' not
>   described in 'wdrtas_reboot'
>   Warning: drivers/watchdog/wdrtas.c:460 Excess function parameter 'nb'
>   description in 'wdrtas_reboot'
> 
> wdrtas_reboot() names its notifier block argument 'this', but the
> kernel-doc comment documents a parameter named 'nb'.
> 
> Update the kernel-doc comment to document the 'this' parameter.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

This is a 20+ years old driver which doesn't use the watchdog subsystem.
I am not going to apply any patches to it unless the author shows that
it is a real problem observed on real hardware, and then I am likely
going to ask for a conversion to the watchdog subsystem unlesss it is
a critical aproblem and not just something AI came up with as a possible
issue.

Guenter

> ---
>  drivers/watchdog/wdrtas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> index d4fe0bc822116..6c25171de224e 100644
> --- a/drivers/watchdog/wdrtas.c
> +++ b/drivers/watchdog/wdrtas.c
> @@ -448,7 +448,7 @@ static int wdrtas_temp_close(struct inode *inode, struct file *file)
>  
>  /**
>   * wdrtas_reboot - reboot notifier function
> - * @nb: notifier block structure
> + * @this: notifier block structure
>   * @code: reboot code
>   * @ptr: unused
>   *


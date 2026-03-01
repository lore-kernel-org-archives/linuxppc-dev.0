Return-Path: <linuxppc-dev+bounces-17478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAF9FD0078
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 21:53:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPG5Z1bGvz2xNC;
	Mon, 02 Mar 2026 08:53:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772401986;
	cv=none; b=gZCwj04hOL4xl7rF7n97XyJQFvCz601eo1ANxx4DLcNIQVrhNZkmRSP1hfRJi7YZKpJqhGORKbg8oYHktXUBqVtUjEFQd6v3rOAGxNfStxPseov/MWAjbqMeYj7O+fKn1V+GYc3LqnrstqEIaIE59ZGSygiDrfSYoUvyeK+JIl4qYgmC47jnbpCghMvT/uWtWvtF6Nkedm8q67m+E4u2Za1+UxtTxRmW2k6pdfNROdJs4EVNrbT4Oi9VoNHwmGQD5HXbSbM8LfFeGqCowJ1PGkwbDpKMIFhzDa3LfctzZORefrFXPsNGFkhdm6BPlurWc6RL1qwvhOzUa8Jy+l8t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772401986; c=relaxed/relaxed;
	bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTTHVLGE6iUi7SXxt3I6VSJOoxGz3hK/tUDb8IfWj+Omij5dtZ6Iy6Z0L96o4l0brP3W87ttCDIo08tvuE/a7R1jJfK52pp+EpdehY7YEa4jK4rwj9+XEc0MUSSylbNJGN+iVNiIWWize/ckMhU8u9wNK7s3J73roVA+UFx9OOvXJjXhFCrhptOK+P7jvLcrPIBZAy66qDbKwau1B6WTPOH6jUz5dlAw/paClXxrHLyKoRIdaqY8yfgqLg3Mp5MXqONNXFlyIqqAphiefZ4tPtrGKwzW8Uh/JoY8b/J/UCu0gtQZnP2qki08EFQCPft6FnOxRdgx0c3qc2PB7DpyBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6PtZQVo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d6PtZQVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPG5X1XZVz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 08:53:03 +1100 (AEDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-439afc58ac7so895997f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 13:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772401979; x=1773006779; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=d6PtZQVoGqy+8OUgSbK35O1p2A59dVIfoQz8k5pN8MLdfYJVFUZanFmAejJvtixrDc
         5XZCd7VekNTlBHyhf70VLq/JXGJZ+W3NNJVpkeDlkXvGpAtJi9ybfMEGNE5vNffxi5MQ
         dKafMJ5XnQmmL150lHen1oiadxVEUr6N36V9GiGCZJnYG2WGNa39KQUa1P2oNvD5JJto
         hZu6JuSKKZm7l/q8xVC6M2oSYDXq8VE1AwMyVvj95wNInvDQJF1QbEsBXHl7y4BTNrhO
         D+D93IXcw20JGpUOd5+jiruzGR44duY7vAAlz3IcLTwHOIMfEWlGcVU8epfqieNIXSWl
         1hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772401979; x=1773006779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=koQImFXpLkADZ1LojXg4lG7gJGl9+vA57vGDI59IYvFZH1ynkjgUvLkpC9+MWkD4uR
         IXbpqSBrUwJu6tvpKi74bpNgJFuszsx4E2CdR73JFndQCwEI9iCihGdTLvGrNeXC+B+8
         4zZ0s2AcTCuvdLF3ae2uh234ELP3Nh/Ahquu7KfqQj5eE5oG4H4aZ79hr+PldwhBT99H
         oRSnLnUgwMSrQLNn0mexHCJYYruF10YO6q6UC8OZYKgRWAPe3A8U3VR1hiZo03EDfQ9i
         RTu09qgz2WtDfGHiTXfUYkNA2JRpnOYRALc+O/lWBtKMX6ny2oSgwn/1NB2y6UQCYVq1
         KBRw==
X-Forwarded-Encrypted: i=1; AJvYcCVwIW6NE+edUMP4K/U5/hDHb6Pa4Wi4vr34D1VrdjNCJfIiRtNIWCXgutda5beVObxbPRzVXrQfBGU0fg4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxM8OLYakcylgY4nBmPhZ+ZYfLU5UuGK//w9oAGDUmoJVy+tJ+F
	vD+SUGc0IoNAKMMgfUeuXr5bs3AB7dTh9oJCQd8Bj858bciRpAowFJcc
X-Gm-Gg: ATEYQzy1KDaG3FK7R6Mym9CRTIG6bqwOhvTdyuRp9gS+6x+DQ/vi22IUoT8ceA3nmHA
	2Se4T/I+FuC9Pj/YlsnlZWMXO6SE28XpC0nl4btk7dt5u1VkTLZgfqPkm3ejf6DC9XUaZVJF9+5
	3hXE9Esh1F9uEHNAjV2+Am5voe52UpThZjL3NGqbCXUQOZhitfj9L4GhxgYTs8zil8IWLeIiMUz
	bRvmdE4Rq/HNPSJ3q8Zq7cwtQg0zOyc6dX1Lzt+Q8c7XheyO+ioK24cgM8SWX2BDhhKAtXZvqZe
	Yl+/b2s5aQ699pROtyqh/Iwb9gduvQ+JaVkuD3qLICAAJDjhUg3zhDH8lreRrf5DKQ0kxFZ9Fx8
	Ry7EI5TxEKYdzdxPBg+bsJKw7ftl3lvdzfWJbEq116N8Y8Gi1cTwqgiPagSuFIdJcVYYvsAByBZ
	DW6XeslppkMdziUlX6ySMTcye+r79ngClG18RP5OCzdV69W0jYmQNumiEv2fTinpXILNYhC5zos
	TM=
X-Received: by 2002:a5d:588f:0:b0:439:afd8:6235 with SMTP id ffacd0b85a97d-439afd86565mr5809623f8f.18.1772401979049;
        Sun, 01 Mar 2026 13:52:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm61132f8f.27.2026.03.01.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:52:58 -0800 (PST)
Date: Sun, 1 Mar 2026 21:52:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const
 pointer
Message-ID: <20260301215257.7bdad5f1@pumpkin>
In-Reply-To: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Mar 2026 20:33:58 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> After converting powerpc checksum wrappers to scoped user access,
> following build failure happens:
> 
> 	  CC      arch/powerpc/lib/checksum_wrappers.o
> 	In file included from arch/powerpc/lib/checksum_wrappers.c:12:
> 	arch/powerpc/lib/checksum_wrappers.c: In function 'csum_and_copy_from_user':
> 	./include/linux/uaccess.h:691:1: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 	  691 | ({                                                                      \
> 	      | ^
> 	./include/linux/uaccess.h:755:37: note: in expansion of macro '__scoped_user_access_begin'
> 	  755 |         for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> 	      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 	./include/linux/uaccess.h:770:9: note: in expansion of macro '__scoped_user_access'
> 	  770 |         __scoped_user_access(read, usrc, size, elbl)
> 	      |         ^~~~~~~~~~~~~~~~~~~~
> 	arch/powerpc/lib/checksum_wrappers.c:17:9: note: in expansion of macro 'scoped_user_read_access_size'
> 	   17 |         scoped_user_read_access_size(src, len, efault)
> 	      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cast __scoped_user_access_begin() to (void __user *) to fix it.

I posted a patch to fix this in december, I'll find it and resend it.

	David

> 
> Fixes: e497310b4ffb ("uaccess: Provide scoped user access regions")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> Thomas, I encountered this problem while preparing some patches to start using
> scope user access widely on powerpc in order to benefit more from masked user
> access. Can you make this patch go into 7.0 as a fix in order avoid dependency
> on this change when we start using scoped user access ?
> 
>  include/linux/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1f3804245c06..5d9f6d45d301 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -752,7 +752,8 @@ USER_ACCESS_GUARD(rw)
>   */
>  #define __scoped_user_access(mode, uptr, size, elbl)					\
>  for (bool done = false; !done; done = true)						\
> -	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> +	for (void __user *_tmpptr = (void __user *)					\
> +				    __scoped_user_access_begin(mode, uptr, size, elbl); \
>  	     !done; done = true)							\
>  		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
>  			/* Force modified pointer usage within the scope */		\



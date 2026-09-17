Return-Path: <linuxppc-dev+bounces-27567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A38C982CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 12:22:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlvz74kd8z2y7Y;
	Thu, 17 Sep 2026 22:22:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789647763;
	cv=none; b=Re9pnKjdic/D1lSnWzkNBaj6yW5NZOq2mQJ9biEOwob3fNS5bnlC8vxIZOMBUyBP3V5MHAz7PL3P9zNUIIC8GylqFVkdqpxYAWA1lF7N4JzLLtnwYLkpL/BzUNv4sPqbBAM7qTrJNBhUNkDLNAcNKsf0Z7lzkaVLVyn1GzL/vMpycU/VDzzH8OVzMkvr5L6Ssu4dyo48O9ifuFNCUOFQHWKlMZXOxF2vpT2keg4ao6QBpJfudBFx+9mj7YeVaI49fuCrI7uPHsplGAxtTKQjkh3cdB08BMg+JxMATE7Z9qkTXAYpolVQ6z97lqgm6Bh1uCzv3tfjYgDSz9o/OjKA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789647763; c=relaxed/relaxed;
	bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XO62v3antKqr1EkbFuvg6Zmc4ZMK98m8/1/n5IVBjHUTyFNTisjSOwZtOqcjKOCl5oGCJFOcya9GN+YcYxhjp8wjVQl4LFCROpyYQXsZLwKsSRyucDcCi68frQABAQ75I6sC6yut8J4txMmQmKmH8VDRgWa1lyeFQq74Tk0bVBVuwrK6lfFhjJaJ217pRyK6fOn2d2n9da3DJRehCVAGQNCYs7OeGNxF10OYMZkCsYCXbAGMbuRIOmE/DcqVns9PT171UPfrFw1s3qt/7h8Dwco4BjFS0QF1etw6ljUSM3+WB6NGpvy/p+ohtdyHqPBp2eG3nuxu+vMfCBIQy/godw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jF08J+rJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jF08J+rJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlvz62mlNz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 22:22:42 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7274955e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647757; x=1790252557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
        b=jF08J+rJsvRgnmeVQAxggKPHjvmBYb04GIjlGbZ7ULDOc72TLdzT2ElVrGzuWn5jK1
         k/5yjxVtLGS1K1FnEbLPVazOZ8xJOMJ2XzXnWccFb3p+8P9KHsOqCFZ5xQWTXyxB0MMk
         kUCwOrLYBKuHk7RTJrXzjsjjsXrCQRSOlNA1G6g5eRmn2NBsBreWlATHTengsyn3EWJQ
         O1d5LvyNLEPgVPLusQg9K/dhFrNEQ1rqzIjtJR7XvNH2FFtN0VkOpNm5jOmmylSstOAX
         DGRXl3yh+azwo0m+YG1LvvgS9jV0Ru7dsD71m3mW0PjvkgZ/RepprLlwbEmAqubmo3h1
         1jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647757; x=1790252557;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
        b=nfDhQ7aZLH0CHB7t66aSo2DoE6YhRLYdMVppAsveB9RRXmJ3sJ9/nTfu6EbBu2BJoo
         VpcMxuJ35ONYnIyo+6E5jvTNVCEPf35usQHGphuztVLWA2ZODVks+yIeOMxEaPSLM4Ld
         XcxU9vdtOv/8GNDwWCiGo/jVWczpozdncZm8+6xLm1nXBb7zjASRhmpDIpdNHPh0S5WA
         UGmm14oiS0f0QpnJJSqbg5BEcTpGdKEkpPSwqE8fN7gd1+3yCsoRzrUvBbpvCA0DoSPp
         qj6BinlSnN3ovuLS9RIDUdVxAXyLfjVzazXSH8PGkiHPiXcscCZ6vfxp+QTA7bLbxkgb
         HaTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzebgL2vjS6uNHbJ0aNcFYbQL+LclubKzMY0VW413m5ovVnrWEK7m5B8XbuGYKTvxDjc/cY+/mvTShyttw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n0UjkcbyItuc/+BdLLt9zdO8P+MVC/C/2w1TFd9TtTg4i3Gu93
	6muRl6AaZ9Cnpv1rWeXgvJ6se8x+XljLDXBAmuLIR95ckmziMFvWp4RO
X-Gm-Gg: AYBFou1NpuGkQTFrmTvW0yaa2MidTSwu7/fqya1sa/TTr2zxndO3qvh3X1bKZPt/JWr
	Ku8IV7QVBLyC6CocU6CFjQD3mRsIkwZNc8yDWwJOAhK8iZse5oHRKt1j2qnz1NC898+r/aBkuHi
	ggGa/Yd5xVqt6HbBO6iGDuLU9PvgKTP7zv0HeZpvWfzC+5Cn8jpxAqQRs2wKAf+8ylFwfXUfSmo
	TH6G2aAh1WK0Bmt0pWobzbddmarEruWpNY7dX1czSzQuomf7230sAFhaLzcgjbfI1shNTKnh5lO
	KsCEE/ijRB29F1ky/zKuWJCJHNbbRjQc+cshve6PMGB6xkMJxSiYfIwI2I2RngGMIjuNzaVNmea
	2SZWKUv1Ih/bvN4mqXljRS1g8Mj+FobIsT6zoor8/3ZoXa8aMBtG7uYxPYSl3qnSG1tgIREetWt
	XVR31BFgChf/G5ozU6DQQZP9h+okDnWa3PrhSxQSHAjJHE6QG5eD4L7Wvh3HmhRvfS9kqu1h2Eu
	6063IEbMKvPS3u7+iTrxEjZ1HDBIFj/CI36
X-Received: by 2002:a05:600c:4ed4:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49eac462571mr73688225e9.2.1789647756735;
        Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm15969081f8f.2.2026.09.17.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:22:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] file: declare the FD_PREPARE() variable with
 __cleanup() directly
Message-ID: <20260917132231.26314015@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
	<20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
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

On Thu, 17 Sep 2026 11:09:43 +0200
Christian Brauner <brauner@kernel.org> wrote:

> The whole CLASS_INIT() detour isn't needed. Use __cleanup() directly and
> give the destructor a private name.

It also makes the code enormously easier to read.

David

> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/file.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2b864f457211..926cc58d0b7f 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -146,9 +146,6 @@ struct fd_prepare {
>  	struct file *__file; /* do not access directly */
>  };
>  
> -/* Typedef for fd_prepare cleanup guards. */
> -typedef struct fd_prepare class_fd_prepare_t;
> -
>  /*
>   * Accessors for fd_prepare class members.
>   * _Generic() is used for zero-cost type safety.
> @@ -160,7 +157,7 @@ typedef struct fd_prepare class_fd_prepare_t;
>  	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
>  
>  /* Do not use directly. */
> -static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
> +static __always_inline void __fd_prepare_cleanup(const struct fd_prepare *fdf)
>  {
>  	if (unlikely(fdf->__fd >= 0)) {
>  		put_unused_fd(fdf->__fd);
> @@ -199,10 +196,10 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
>  #define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	CLASS_INIT(fd_prepare, _fdf, ({					\
> +	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	}))
> +	})
>  
>  /* Do not use directly. */
>  static __always_inline int __fd_publish(struct fd_prepare *fdf)
> 



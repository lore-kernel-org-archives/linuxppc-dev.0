Return-Path: <linuxppc-dev+bounces-28949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FD2CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 08:06:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzTNM6g3rz2ygK;
	Tue, 06 Oct 2026 19:06:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791273971;
	cv=none; b=aLP+w4RJBC1h21ROoJXrYYhtTOm2HkBp75TVNywOVFa3EY4hKVbfsqmAU3lIP2JhPo7TslA9qPm2sCWD8oJlvTADrAYbeTVN5avdqyo157pMFBFP41MTJz2zEdQj54hHBN8lanBCskmfZgVWpKPs3Gddf0OUJUctsL8PkIzzMUz6jlRTZ6ab9p+RYgo5S/kVyXjC/37lMqzxdWUb7QwARcvEx4BBQaJPZMgxmsZbTrnAdDk5mgji2h4rATYQm9ePh6dsV+vpVH9u7aEKeI4FgEWWd0IAoAhWpDANpG27e/Nv38HHCk38CZgrFeLQbyWrkkqQ+0x/MmbBwmew7EFhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791273971; c=relaxed/relaxed;
	bh=1iRWCA6wCWJlgzY3oDPG4XgaBTe90S3n9EMW8VxS/yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6SAXZubmTP6GV8DwoEpD5RIOzP1nZkDcyEfDP+kv9ARqBCBYpMfr8yJonljh/jtF29Xbu1id6Y0v6gZhS5DaX/+l8srPP4Qe1ZJBtpqmXUfyb9QxBtRJWon5c7mD1FI3CWEukXFGgf0aKxY/K3rOcp5LnYgrEJK87HffDOBFjm6XgdQ6H3Xj1D4iiP9Lz1zT+J08bYp65cja6E+YOPPIcMydoE1e6F8tn9fUiGQmWzZBgtJJ4fe73hayy27BAHDJ/9OpIOXGsaaBgSQ09Qs6VVFxL/tmSj7RPp9pjynrVTKsYKhxjP7qJB5PSfhoTtRf0k50w/sZsATOLZLBi4W6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0WsOWW+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0WsOWW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzTNL4Hy1z2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 19:06:09 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso154701a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791273967; x=1791878767; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1iRWCA6wCWJlgzY3oDPG4XgaBTe90S3n9EMW8VxS/yY=;
        b=c0WsOWW+OYqzAy7hN5ol109SZqDDqo35tCdy7dQgL/BzZKycna2tA7DX7eLh1LdgeS
         0ThQdprrF7TSDrfJpGILl6nujmxCGdAG7pS7RaOh/k+sx8JoElpdupxN8aDWkjlJ7Zzz
         yLNJdm5HQRsrxJRpNdStDgPoKMiDulG4vjHZ/l4J7kjLyeoywn7rq9WSt5MgQpYwi7TY
         NDWg+h7IOiWSScl3enxlf9HqBgwlPAAezMMW4wcfdSZAMRxhlBzDBm3FaBIu1BT+vhlE
         xQe44hyCll1nZuDUBFhI5KYwuQsQemLK9t1Ws6ReeQGIZUBhjLB6XnmDIKkMFO7elvbr
         mbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791273967; x=1791878767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iRWCA6wCWJlgzY3oDPG4XgaBTe90S3n9EMW8VxS/yY=;
        b=bRO+uCawmwblY60coyvj/s7gWYGYmH/2zGDTpWJ6YNp0a6D7K3sUSHslFSqhuUlDLU
         KRZUNxskitr+IsZfNnyJ6qCZZeUsieGL9XSVtb9UGxPFY9oM56dLvN+3EqZr5WW4RBEt
         4qDHQNwhdxT+HSgszTD2HJI020+2vRG/wYsDBdFux0IK+1mIjuVcrn+wKh9r/lfCqMZi
         cIf75YqD4unf3mDV8oCV2mgQV6InsUO68dA9jeht+Tw61J+cg6SjaJPiP2ISsGjO2wha
         Ypw1C6/IpjiPHjnBToHNqvRXPq5pxZS+hB59j/6LvBFsLF7dMP+fp94rjyTaCAqBy8qV
         MqOQ==
X-Gm-Message-State: AFuF++mkHUTjKliEILWTVzjwcdoN/Z8V346sMb5/2N7+lN8aii8jnSIt
	OUSTLkiaPqL50JWjWyMHma22wiyhPb+1RA4RoYmNb+/54ucObdsfeShW
X-Gm-Gg: AYBFou09UKmjs3DcKhQyn4R85xEhUSWHMkBsM/PGY4VHVLxzal+9KtQHwm3v1T0QPZ8
	0tSkhfml2HXcW6/1OcGJ0+Mu/pThKxhm8BGqTKg/WrfTcT/OBAYDK8jmCt4sacizOzU2f4LzCo4
	/GmAQ2+cNOFswlybq9gpLfgIMe+W8+R8AoPk3FQGU+ctmG18qFXmhh+lhgiZ6fnlb5vZJmSku6O
	pHWHRCA/JDE10kQPDwdHApv5iuaI6EYiPEnObFKA0UdSGjCRUjC1vPiZ7pZhVbdXgkI2rNxw7FM
	aXXelns56jPzxMo+AEXMxreMDtrZLpljM9FqAu5rGd1wJqFrivFoIoUf5sTnNdp1CcAzrx/W83u
	vckWgLZauIcL+NC0UHb6bW1AHa8d2w7qLUrROLT4td2sYbzijf3qWuw6GNWq7JRT07lsyb3pg1/
	JTPg1TeRL2hBtCeDPsRQGGV+Da23mkwu0/vGQnWbEXJ4WsjPbRGn2MCVwcMtcVYLR+wsyKd+RGY
	LmD2/GFCQ4Ax39a2KHVutXrgtkXGfN0XN/WgnZflfw=
X-Received: by 2002:a05:6a20:6a1b:b0:3de:48ca:c576 with SMTP id adf61e73a8af0-3e124495243mr617591637.9.1791273967463;
        Tue, 06 Oct 2026 01:06:07 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0bfc3805sm4532577b3a.21.2026.10.06.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:06:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 13:36:00 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Amit Machhiwal <amachhiw@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <asSrye034NRaM9nN@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261006065945.391637-1-jyoti@linux.ibm.com>
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
In-Reply-To: <20261006065945.391637-1-jyoti@linux.ibm.com>

On Tue, Oct 06, 2026 at 12:29:45PM +0530, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Free the bitmap and the mpic in the common error path before
> dropping the device node reference.
> 
> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
> 
> Changelog
> ===========
> v2->v3:
>  + Introduce 'err_free_mpic' unwind label to cleanly free mpic and mpic->protected
>  + Link to v2: https://lore.kernel.org/all/20260930180919.335930-1-jyoti@linux.ibm.com/ 
>  
> ---
> ---
> arch/powerpc/sysdev/mpic.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..d799cf4da7bd 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		if (fsl_version >= 0x401) {
>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
> -				return NULL;
> +				goto err_free_mpic;
>  		}
>  
>  	}
> @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  						 intvec_top,
>  						 &mpic_host_ops, mpic);
>  
> -	/*
> -	 * FIXME: The code leaks the MPIC object and mappings here; this
> -	 * is very unlikely to fail but it ought to be fixed anyways.
> -	 */
>  	if (mpic->irqhost == NULL)
> -		return NULL;
> +		goto err_free_mpic;
>  
>  	/* Display version */
>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> @@ -1526,6 +1522,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  
>  	return mpic;
>  
> +err_free_mpic:
> +	bitmap_free(mpic->protected);
> +	kfree(mpic);
>  err_of_node_put:
>  	of_node_put(node);
>  	return NULL;
> -- 
> 2.55.0
> 
Yeah, this looks clean.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


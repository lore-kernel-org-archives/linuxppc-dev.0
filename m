Return-Path: <linuxppc-dev+bounces-21229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F2CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 10:24:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL72415PZz2xqv;
	Wed, 20 May 2026 20:24:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779272668;
	cv=none; b=k98LM1bND4QGs45N05Frcn3mjtg4YwydAXFzBbP1k7b8nbs/TeP1Yko05/nN7h9wNBiCZWgax3RGX123MS7Dc/F/952Jy7/UCOQwjaBqHcUSCpfduvS3F6LbTSc8GdnWzRR6Aw5Wyad/PTOD6uR2TZlglZsnAlH++ZJjnbV6KgHmR/AvB6rP/E+Jmdw+F/Sw2N9TCKNzaW0fLCehBqEUlgxvoxczVBZCcY84SP1tcPc1wHNwDfLaXlp1g9NnKt31UzRiwzownOokzzzAnGYgQQ2WP17WyY1rCeRxALhGOtvhC6IX/iq1/YsR2Hj9cGMnX3nY2mux1pvBD3MebqmuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779272668; c=relaxed/relaxed;
	bh=Fjyw2SPSbDAWDTOYsBSPfcvH3EJiKjWBtVx5pcWE1q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMRgfwVMF2VfJY9b9dwPE2UtSZIarQTbC4l6TxeSxhURXw3v3EYfMDXaJGJViB76P7MRjHa0RNNha1q0k30ano1roP9+mOioYmO56x4v8+oyFawRQR0diRIQHMqlbElTtjsyq610SkNVMO9e0+PtNqnE+btPX+A1yZfXrdc/9d8/m9UIfmGpgWLcAgH4J/1zsAFoSmLy7e5LmfjH2smfQA5R0rFqNT9x+epzWLHTYSkXrdIrxcXPoNGSXDroQsEpP58g6cJk1BQB5Q8pGmO2bkBPMb2jlQOwenXQwRVnZLb31lMad80MqizyxvompGleMugCKUbKSF4/V3dyYK3bHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ROH9xyHF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ROH9xyHF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL7223nR0z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 20:24:25 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-44509921fbcso2920087f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779272662; x=1779877462; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjyw2SPSbDAWDTOYsBSPfcvH3EJiKjWBtVx5pcWE1q0=;
        b=ROH9xyHF7qhyIDrHQPXVe82CjQ51WnEY+yJQV7RMiv3J3h23v1h6ayO3em0Zet8yl7
         5TRI5el/H9y7jXlDdCVe1hfzTXkeV19YLRh+SSUk9VtHR8MtcFk9HH+svHiwmBEjDsnN
         B89DgOc7JZq1MKNhi2oEmnO/bsbkGQvgj7CmkfPrYXla6NQC8q5yKtJ7ZBcb05w6jbOB
         ctIj9I9mdjKHH2Z5FGcGpLXkFlX6o2bTJQLQBO9y9uSqRfgSmYl8rCy1/0PzXwHpCGeo
         iM70/ewMrAmA3AdKh/Zj4gVehjoktGlvCqTYk0zuuKNDh/zN3f+sfy/xardN2tK2JtrL
         76CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779272662; x=1779877462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjyw2SPSbDAWDTOYsBSPfcvH3EJiKjWBtVx5pcWE1q0=;
        b=HfClRONkA8P9JyLd5sd4jvmTeBSJhP95pnZ4rbpMc2OrVLOI1A9BJZRI5+830F8mvq
         LVaDhR6MnkymP0y9ue2oqxgGcO1NIcP403szTbGyvVqmIXkdLePkA6VNUGJ6SG9fT7sO
         6fKYnyinuvoqDrfZsIkaggJ1ZkJdh2f/3f+LdZ/Z3r1biqvWyRWCJjffFsOTpZdBGAQJ
         gIjcL8Pb6vTYhZb/t+8dfR8ydD0Vct1/Yqz4XMD41lBcpWtRl1aho2h9lsdk0wl+Y6sH
         RgmZ/z5rjOAZWT8zUh+qm1QzYGqHnNyLFhjOQ2RmA0NdeXzs5MXbq/6QUThdj4/Mvzbc
         YV6Q==
X-Forwarded-Encrypted: i=1; AFNElJ91JyyxDf7NFFAbx3KJKl5coHA85uIjyJ+2w6a69FAYj/pUwDmxUoCvlsiOZEz/jWd5RqOuWxiLjrcydfs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyI0R7FejuK2xLy8c0D9xY282FKGUBEfkt6hVNbkbMNYpBT59Of
	ezvLnNUZPsMUsveP38Ykes+uxCW4hjOtY1rhX86eE9E7HmjAuG50iNLS
X-Gm-Gg: Acq92OG1WsBs/h8sJemNOlvH6ZpY01476KZEhl9b+OHavQWyXJRkD2lyF4V9iSP/uBJ
	y0nQeamT9TEGaoY2oVGz0SwyLAe3K9dkuG0ajc6SoC0pfOClRC4M5nW+zN6Vm8EyIdgzuSaJFTZ
	JjINZ8CkPt0PokRWxL1TvN2DpYEuYahqpT0pVy7bqkEOz4lSLHks+IN4zrFpRdJpzpf7jfqeOnD
	cxDpEEm+qhpaYXbDOwWxbI8GB1xwM9Cu2hJ25KUqdTNkp+sWYjg3w/gzIWqDG8yN6ZTgHWIQh9X
	2E2L2UfBA9xlf9tFpZUE1MHQWnARkuc2g4y0268/RICokavpOwmXu32tXEFE/Ps2egk3gttRoQZ
	qnBp0d45AkkbowAIokIomQ0e8oUsjO+BYnIzwQ2cEWFGP622PjilD6Ld9QdqL7Uqh7sT2MA7fOS
	wK9yWhyQWtrzJ5LhCjVGGEDBU=
X-Received: by 2002:a5d:5f45:0:b0:44d:821:1a0b with SMTP id ffacd0b85a97d-45e5c5dd260mr38410505f8f.29.1779272662508;
        Wed, 20 May 2026 03:24:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm51188114f8f.3.2026.05.20.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:24:21 -0700 (PDT)
Date: Wed, 20 May 2026 13:24:18 +0300
From: Dan Carpenter <error27@gmail.com>
To: gjoyce@linux.vnet.ibm.com
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
	brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
	nayna@linux.ibm.com, akpm@linux-foundation.org,
	ndesaulniers@google.com, nathan@kernel.org, jarkko@kernel.org,
	okozina@redhat.com
Subject: Re: [PATCH v8 3/3] powerpc/pseries: PLPKS SED Opal keystore support
Message-ID: <ag2L0kO_zK5hzx-W@stanley.mountain>
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
 <20231004201957.1451669-4-gjoyce@linux.vnet.ibm.com>
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
In-Reply-To: <20231004201957.1451669-4-gjoyce@linux.vnet.ibm.com>

On Wed, Oct 04, 2023 at 03:19:57PM -0500, gjoyce@linux.vnet.ibm.com wrote:
> +int sed_read_key(char *keyname, char *key, u_int *keylen)
> +{
> +	struct plpks_var var;
> +	struct plpks_sed_object_data data;
> +	int ret;
> +	u_int len;
> +
> +	plpks_init_var(&var, keyname);
> +
> +	if (!plpks_sed_available)
> +		return -EOPNOTSUPP;
> +
> +	var.data = (u8 *)&data;
> +	var.datalen = sizeof(data);
> +
> +	ret = plpks_read_os_var(&var);
> +	if (ret != 0)
> +		return ret;
> +
> +	len = min_t(u16, be32_to_cpu(data.key_len), var.datalen);
                                                    ^^^^^^^^^^^
This isn't the correct limit.  This is the number of bytes that we
copied into data.  Probably it's sizeof(data) and, hopefully, it's
at least the offsetof(struct plpks_sed_object_data, key).

To me the temptation is the initialize data to zero and
s/var.datalen/sizeof(data.key)/.

> +	memcpy(key, data.key, len);
                    ^^^^^^^^

> +	key[len] = '\0';
> +	*keylen = len;
> +
> +	return 0;
> +}

regards,
dan carpenter


Return-Path: <linuxppc-dev+bounces-18336-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC3FD8779
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 23:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb7pZ02Myz2xYw;
	Wed, 18 Mar 2026 10:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773791061;
	cv=none; b=JMPCqsqNZaRRGZt4RQrS8Zbp93RAUGR1ASkPmmeCfWGPJf6QJ3jz2u6MvLvKzl5GF2aUN1zvowr9pb7kCyXORuOGdngzkXg2EpRfFKdLJo/3RiTlH8kHdSSR/cdMiwvCAyPvYYxUWopZJtI7cvJxoX2gy6FVFBlEgnYWFyayuX3F3PROXWF+ctYcArm/08cIO260ZMLBxozsRYlL42wwv7mNOEjqSDoxDRsbZ/gmUZSc234UA4jdnziEzhIJZgP9jTsRmTgXz6D5gi7ztAx+uXE3p54gQEjyP5MwcQfBBeWKtUn5QOnogZBAVuyOi/t9cIS1vhUTzDlCpybcfvmr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773791061; c=relaxed/relaxed;
	bh=sDIz43D4MTuOarQG71u0YgFU0v977L2RxVybNkE8u+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkxU9uRzpqfkjSz4QOFWXNNw4p0zcob54ebyw6H/fkNQsAeYOYPG7hUWZnaJbPKSC0nC3mmGNrJCwqT6TvRbApWYDl9MxDAnhYjWPeIlh6kE8kQ1LNjavkxby/3ErA8DrCXBBrIqNvd/qS4x6BB2xlcOF2WU5S3cWKSAifb5OXl0+L3gDqFoTL8g04tHzkWoh9kcgZ6v/nGpldwonE6LoXn9s6IbOlMHGiXgYBVjT98oYifv5ppZkS4rich/XNTQOGZCSIk86LFuMb5JUpLdEtDy7u1u9G3VAHZtbhp/5tJK2Xi5oN4v/JQWIclhoE7+S0ENyqmYHnfR/pZ87YPXPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=LUyho57F; dkim-atps=neutral; spf=pass (client-ip=35.89.44.39; helo=omta40.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org) smtp.mailfrom=embeddedor.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=LUyho57F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=embeddedor.com (client-ip=35.89.44.39; helo=omta40.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 339 seconds by postgrey-1.37 at boromir; Wed, 18 Mar 2026 10:44:19 AEDT
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb7pW6GLkz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 10:44:19 +1100 (AEDT)
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 2XaQwMPN7aPqL2dyEwoSYv; Tue, 17 Mar 2026 23:37:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2dyCwkpb8qfpW2dyCwu9EZ; Tue, 17 Mar 2026 23:37:04 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=69b9e5a1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=5vZi_tIctBNeQFYZvx8A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sDIz43D4MTuOarQG71u0YgFU0v977L2RxVybNkE8u+4=; b=LUyho57FaqByRfJY7uhMTFmu2S
	JtvA8JfGgXdiudXrchA0Ne/x/yclFIlMivpsXOevHirW5mjG/icJGiTomPM944RHVFmL96nWTmfbf
	0OHakIJxjnSoVrU4ROHvZ6m6HnQGzW17aca0t5fDloRsihkysr7Gh1NC13gYw5ykkbNKanAPYAwX3
	ZOl6Fnzyv+XdMK8DiJpToUkVbAaVXuNLyL90Cnml9v2GZJ+wQyyhgc3WQAUWQQT4YWd9f7CZoNVUx
	IbnseujQlUkv6pZY5YwQvJt7q72HYKUyhCFr0WLWS+v0YgGP388H1jJ7N+E3jkXuLlpo6PdDlVIkD
	xU9H6wJw==;
Received: from [177.238.16.13] (port=58304 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w2dy9-00000004JzL-3q9f;
	Tue, 17 Mar 2026 18:37:02 -0500
Message-ID: <bde61932-9c7e-4139-8d6a-8059c205a217@embeddedor.com>
Date: Tue, 17 Mar 2026 17:35:39 -0600
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
Subject: Re: [PATCH] crypto: nx - annotate struct nx842_crypto_header with
 __counted_by
To: Thorsten Blum <thorsten.blum@linux.dev>, Haren Myneni <haren@us.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w2dy9-00000004JzL-3q9f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:58304
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNl+4vmYEuQGDssguDzbnuHzvpGtB1jNLUTiypsH67Q6wuX/fDbSmW0MQZUHjybC8Fcd7XKdhXWQ3r6KHovYzbV4sUlDzVgbHIelCNF/T/EPLb2ttW91
 AnRVu1V7htdJCMnj9Ss+rfyfGlswy2jEr69UxBuO3bn/6EPfwWCK/Cue1xlkDfuFXcL+7mEH49YrDSXDr/d3SOPNZyvULKSTeWt4jw+Yo1CqKxmxDCQ+hS0S



On 3/17/26 14:18, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/crypto/nx/nx-842.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
> index f5e2c82ba876..a04e85e9f78e 100644
> --- a/drivers/crypto/nx/nx-842.h
> +++ b/drivers/crypto/nx/nx-842.h
> @@ -164,7 +164,7 @@ struct nx842_crypto_header {
>   		__be16 ignore;		/* decompressed end bytes to ignore */
>   		u8 groups;		/* total groups in this header */
>   	);
> -	struct nx842_crypto_header_group group[];
> +	struct nx842_crypto_header_group group[] __counted_by(groups);
>   } __packed;
>   static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
>   	      "struct member likely outside of struct_group_tagged()");
> 



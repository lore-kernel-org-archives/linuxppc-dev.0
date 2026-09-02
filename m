Return-Path: <linuxppc-dev+bounces-26437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7C2C624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 11:40:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZglM37JHz2xpn;
	Wed, 02 Sep 2026 21:40:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788349231;
	cv=none; b=jzFz/bY1ItbU2Fl1e3xlgLBmQ0nZbiVVi+CS+LvMpG3SKjAJpYRBN4+5jlYQXy0UFGMLiOtE1MLXmfPXlhFtDYAmChpPBSib5mEEH5NCnVELvRRCe0+ITYtr8ZZq02yBgTE140Mc+0vml4HG0L4MLXLMgSG7MfcM8GoBZxswXgMMxpzeRmD/3zH9URwU/yGbSxaI+nA24J8DiZTawnfTwWwjiG8OycQf/nYnWPiDKlP+lB/IkRHrNcA5ywURk5dDjf52g/spjYSVUGCbEEPdtZDXDMEQZ6jXnwfbrfBNuzE5QQJ4aaqwvGw1Vr0Y58ndK7I3Fr5msAxzu+zkkZ//rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788349231; c=relaxed/relaxed;
	bh=wVkVuPhoPxzk6Z94L3N0Zj2zqqxuaLOIcq/Bx7B8iNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g7uV0xEndF6+DpjOVgMcKuv7trQfBMNvMsE9aryF7kqEJLsUGRhzM78QaMbq4R39CmTjwq2obb19RhhVJ8JZfia3ettuGX4J/8Sw3qkh6PRT0mhBVaATcypeqIyPNISyIdL7pAUqmNROFX/zFEIYgVEfOb1gtCFYYAY5ksn3hZjiPX0Hb8ZvgJod7H/CbUENN91msEII/U9fWVtN/zzdzDbIKwAPAZKjflEWKCClcgpDQMrnqTPNCIuuKWd4cOT9NNl6z4w4fQ27jcCGJxKuIUYb+xRcA8LEBYkeULEgzBvhYhxvCkLPlsyz3XrYgDwLcSSuvk/bD0TMgC+vKBS0Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvJ5GP25; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvJ5GP25;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=eli.billauer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZglK6FWWz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 21:40:29 +1000 (AEST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso1526064a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349225; x=1788954025; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVkVuPhoPxzk6Z94L3N0Zj2zqqxuaLOIcq/Bx7B8iNM=;
        b=bvJ5GP25NCswPnc8eNsL40zM9RDQpNLc/6VvTYi97VdSatuC8G6OTIwGCF/P9u7IXM
         aG+PFoloTufEI95Ar3EBraSHtKnuPbnNy7+5zoYUKWVDjcNmHmQTuo9XvEKOJlh7ca+w
         gp1eWkmrzG9xlC4i2C2/rnpneFlplVn8vNznZhQUkoAJxYvF9gGW1T/wWTlTS00A7Z+r
         NIk29SoAP5k+T30swgH2AoXJU6siNGgN7jIggVf8DPzsGB6VX9hyJ3sC6ym0N0ONQBCp
         NRu5jsS+/QTUVNrmCQyQzEunp+V11iRMujDZBTan2D3XIrnbsoUEcpaulYnp6vF4oF08
         WYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349225; x=1788954025;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVkVuPhoPxzk6Z94L3N0Zj2zqqxuaLOIcq/Bx7B8iNM=;
        b=HtCmZzxUWtO490J3FGv0nujV46XthkvqOQVQSvPfIyRGxTmvz7CtUn+00VWlc8z3VO
         hbrtw6qR/fj5t9EpfLV3SVSZ8mYAivkz85mKldGFOeuh7sPWXcs8yvYVGH4mHSj2LDG5
         yQwHqcBk8W6iVKJNKJoIAcYutQOl838nyJSx+VyEykMn9S/7FbQMzm2GkbD6q/ZBJCUu
         iJ/mkMuGDlUv0cLicdIU7Uepo3D+HXIkFdu6FPYAYvoxMnIYt13EysNbUKEVfSsOjG0O
         h7USqK749Yu1rLnX6hcHBLd9rXEv/DocmHWuaVcgFDd8ib0d52HT+uatB9DNt7baGqk+
         MtVw==
X-Forwarded-Encrypted: i=1; AKwUvBy2UgXO6RLNAjVWXir4mUiJvPhcBE/0/iPPHoWO+Capba47cqtghWv3trld0z47fXLEAzpkscIZWY38RnI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nba8gjSMi0WMenXwVoWAqqekp/5vLOZotzhsa8dk2ep+WUWzJa
	N+PTw8UTUrBYtSK0hcn9OFSND2uxHo31J48fvwlicxkH1gceSNobEMuN
X-Gm-Gg: AYBFou2R+Oy3Lk1lu2el9cW6Ou0vI0sgG0wPfGedlADawAGtJMb36CEeqGWjuV1EGWq
	/8pvDiuZw1cyxkYfXkkKdeo+WM+PQIgyXhnTX32QS3UyJesH/l0w9ub4bUh+wyMXb5DR6MH8MXE
	Ebg+7kbyKHeLQRDFhXo3r7r0OOSkWF/4kFp2LKxJB22tKVFcz8mg0TvDNgHzeauXdEtTmr23MNI
	cp3TT9gCTR6XGhvwh/vXD3tmIyte631c2yYTEXKL9TTMIe8T8SdXqC4RqerRyNUITzKnxOUgOaL
	yQvZ72s/MS0PGBgbowxTUamg40QFmxDKGwlghZJ+teoizMU4jpeo+df36ias2zb0V+o7IBtJ5Cm
	Pfcbye8J8Uo1xfeiow3Fgq2tj/OAi9fIMxQc4n9dGRzL8vhlHnaj6d+tMPhjvIt59Fzf0GlnBuY
	YraLo8BWAprXBDLUeVJHGPzAyM0q2mWtiKO+ffIQw/+UJ+A/Bm1gCfM1tDytHWxVvv8Ud/o7PwS
	8psyWBSY5b26KaaHTqE3qc=
X-Received: by 2002:a05:6402:218a:b0:6a6:584:d9e7 with SMTP id 4fb4d7f45d1cf-6a6832e4fa1mr3314668a12.15.1788349224695;
        Wed, 02 Sep 2026 04:40:24 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-45-68.bbcust.telenor.se. [85.228.45.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f8c7a0esm939877a12.13.2026.09.02.04.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 04:40:23 -0700 (PDT)
Message-ID: <2d7b127d-6079-40c0-2020-dc7767b2396b@outbound.gmail.com>
Date: Wed, 2 Sep 2026 13:40:21 +0200
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
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
To: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <apVmYXlqsVr_p4Oc@kernel.org>
 <7adfefaa-91c5-4bf4-ff98-5dfbba0eac96@outbound.gmail.com>
 <apcKQBRCFeF-usK7@kernel.org>
Content-Language: en-US
In-Reply-To: <apcKQBRCFeF-usK7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 19:24, Mike Rapoport wrote:
> On Tue, Sep 01, 2026 at 10:42:47AM +0200, Eli Billauer wrote:
>> On 31/08/2026 13:32, Mike Rapoport wrote:
>>> For large sizes kmalloc falls back to page allocator anyway.
>>>
>>> And the doc is out of date unfortunately.
>> I think it would be a good idea to update the doc first, and by doing so
>> officially change the API. After getting this change approved, it's indeed
>> safe to rely on kmalloc() even for larger memory allocations.
> The documentation always lags behind the code and "official" API is what
> include/linux/slab.h says :)

This is what I found in slab.h:

  *
  * kmalloc is the normal method of allocating memory
  * for objects smaller than page size in the kernel.
  *

Maybe this needs a clarification too?

Regards,
    Eli


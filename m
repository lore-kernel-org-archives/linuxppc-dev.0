Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2B60A6F77
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVJo/07y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKlsl1YNKz2xPB;
	Thu, 05 Nov 2026 13:01:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793834146;
	cv=none; b=iwlpsT4OfZN+w/l4y2hdQ9IHnaQl8WR8HlOTby+IKn+bZQNUSX5Sps9qgOYOrn0YZOklsHShB4CIGct+ExbwsI5rI3xWK979g5Fj4F4OXxU8AZULDDIWev6nWIixZcWMtk/f7XP9qg4ZLm8g7aBsR6MIE/0UdjbD2p8rgT0R9CE80R/mw+qokBhmAx0KQXqYuVx/mYh383wQgpKFSEAftrka4yzV67c5KQSBNAxmipyZse4h7DnQhYq+m2g+/bWOnQJVJX8z2htU1iO+i8PXLwI7VhQSm1dbAd2IuWbe54Az/03fUyXthKU318x68FacdEo3nNbC1uxmlTaZaaG6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793834146; c=relaxed/relaxed;
	bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8vgTdb1x/plwqRd9oWVc0dLlugtKL0u+skdu8pR8u0GjLTH4bgyauO2jHdELRcKYm6190SBS1VrdxYUkQrdyREtmZVEUpmZ/Jhl4J+jS5VML2Q4bp0toA5ruXhLjhh40tP25b3DetZxLZCnCG3F1o0jdd91NmJozbewjaPZ/CniOAj/A+gO6xsaDio20kKBJASDIrjNDmFyilBDLRE1+YPWRSnLkjg4dFF+g1oN2jclxGG9SrY6Js1BdZhSJSTwsCQ9HE52uSxtK7GgQWLIaDUv2qHh1bt4P6XC8PJJ5WCkWP53819yc487DzQvBvNFX+oeqGbBq1KNAfKdlB7Ahw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVJo/07y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVJo/07y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=azpijr@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKhBS61X0z2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 10:15:43 +1100 (AEDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso13044455e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793834140; x=1794438940; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
        b=FVJo/07yojMqlV146I0FvJsJoYJ5HGzj+ai+8X9LZdC/zWAgL1nkp4uJ/7kPsFN/HV
         DvAeikiHNMgKBFilrPILf6jXkgkmpXrnP9fVI4e+CbbvOcD+uhBpUH5oVvBl7lwVuDVz
         dLiKHAAY/GZ/H1o1NRg+V4NY8CkUacgtDgVCwi/K0rqDM6Ph4Y19QclW10+IIlfpClSp
         PRytNtDffspT88T9mqJKkRm8mhjtY4r0NKeR1OaiKUc6nV1R2kCxBqREuqsR5P7wI4EL
         b7DVSSbrLdNmOsp5pvPdN4biOsygxMn8J6kqrg/12BT589axY5X5rfqDjAktgxPi5Ou7
         wqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834140; x=1794438940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jw1A1CrCQXufCGBVmtCdk6Ioy3GBOtyXllOzk3wnD2c=;
        b=iGrNOvI4CCKLgMwozThGpznnRAqk/d2XmhIElE2eB9DFQNRcrl6lx27lrtHejAjFiH
         RTGhRPi3qHtve5dBq+cnhfyu/o6ChJeBx4hz8fUPD1tzE9TU9dQPgWWgd48bYTO7o4aM
         Ao3/hu15XUJGI2IHXa73MKpAfJJPTkoSKXkbpR8cbiOerlF88v33unmDYnbAFKM9/bRV
         i0Ryl4tX4aQQkBE9D7+ISB2weaTzrqmGiGE7RbODiAfyDdLhzVdWLCTMJ9U5uhPKttOw
         YpoT2Rbsohexiu+vyw0Ihord4/KUATwJnbfQKEd2uv8bIkbMtUx5Z6NoTaaCdUBqAsDw
         n7tQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/ufEZfiTeNxmBzK4EU6LbyqC1oCwXmebMj3VNPoq1St6GO/9Gv1NpAI34GiVe8oXGi+YY7tPDLvEWsZk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/5A8QZ5Lu3C7RveDn60MRZP8iBUt8IVfy4xnflws7M83KtNxJL
	yB0Q/0+nknBrP0/NRifa0OwCUKKHVxmXxZHB+MVyhampn/mYZkIygmG0
X-Gm-Gg: AYBFou3YEXqPu9pYForQ1vPF9QMttWmdo/DOSKs9sJwg1OhUKg5QhGDwkLgLGzQUCep
	XeSmKbzgMRy8Fg8Bx3WnH6Aq8y916hy19iCyelFRojy720bDGGjxZ+qPoZVH+RAtBWnPuqpphO1
	nZYtz8FjlKt04HpB1WpG+/x48HPIvzTZ8BGu1KV5Xjqm0BKaDZUFmdYK/KHsyANAL3R46wngeyZ
	VQkVsxhtcLeCdOKu5XE9mh1AWsuaJVw0BBZDj6qWtE1IwRkZu08VGZHmR6s3HcmwxD6prx9WBWh
	l4AGsdNZTbXxi52KodxCTcqRGdvWY5cO0sE0HRBvtl0cs7nRNm8JmT+PVaNz2RAFHrTogP7a/c2
	cfgvxwPDeuD1rF3IoeFBAJIFIvqczyILPYa8LXsKb8tj8h7uC5I69Q/iwvcwKrIIDublJh/JuOz
	xlb4LBkYnogBHJ+KjlfLBxiO6plprMp1USHKoIf6ggqEv+qzeZgTobrvdvIPo7080stYNT/Kle8
	y6UWJzskg6hQ0YcHJTUEr7ES6WAjM3A2ZPOuKGpKq4dnQ+KWAPn87C8p0iNbcJaUMPy6t3DxABw
	K02cL7oJ3Bp1Pkvve2lsm6I=
X-Received: by 2002:a05:600c:3f0a:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4b3c3545341mr83410955e9.20.1793834140542;
        Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20567sm6769827f8f.51.2026.11.04.15.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:15:40 -0800 (PST)
Message-ID: <ad6e93c7-203e-470f-804b-fbf7ac9890f2@gmail.com>
Date: Thu, 5 Nov 2026 00:15:38 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-4-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> +	pmdsize = read_pmd_pagesize();

read_pmd_pagesize() is pmd_psize() in mm-new since 5d123bb07b18
("kselftest: mm: rename read_pmd_pagesize() to pmd_psize()"), so this
won't build there, will it?

-- 
cheers,
jose a. p-a


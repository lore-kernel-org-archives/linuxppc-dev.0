Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D96606A889
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kkQ5o71K
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRlVy3PnMz2yMn;
	Sun, 15 Nov 2026 07:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794686762;
	cv=none; b=XPuwfATrLdg9+JAiaIwETr7CCP7VGXwYhCaKT6T5o4MKNJZcyeX/BuZXNp9m3Y1NaHRevXQT4vdII6zYtBnnMjwrEURKl4ih/CVT/pnSsWz9BWaHvhzm1Z7PWuszW8ea0k1QwicbP1ngGtmpFAjAcOHWAIVumKB7ITZElmFvwtgfK1KTfQRpdJlfQVpAhZtpGOpKVU7xp2yyEIxaQ/CcFAS4ywFxIhav5ergQDoH17KaNUtC7w6a2LjYbXeziUTmN5KHumvk9wDY4l99Cl+9BuXYJyazeQjbsBPtY1le86KtL6q7R5xnGjNSANVnBt+QgwBg/ANFaNpoTJ+NubEuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794686762; c=relaxed/relaxed;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID; b=ft9rM4/9D41c2e2g8Fn2tSRgECx/0qFYEdmgpGW1YmBn/F7OvNms3NZNewFN2p24U7ywZ2lEkdd161ONptvZegQ5+c9OmYVtwKj/lPMze9hbuQbxqNSBfDeOjX7eQDxEfwAJ+W4xqxFaph/3vqEPU3K3cvMyrr//Bm/JLs/B0QnP7kXKCL3rzyhC/8HAeEF7jlx4xqjGtfTmU1tXKT3950FLJhaxZH6O3ysUPSIbRF+vmCkAMRgCqUPPiZwcB6Algng5l/Eq6KEKtmvC8OEhy7mHDQ4Jew7Dfbb7AkM4OFi+P4GLh8+8sADUDIE7wXRE4+jvb+03tasGYxVlL+f5qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kkQ5o71K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org) smtp.mailfrom=chrisdown.name
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kkQ5o71K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chrisdown.name (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRlVw1Mnbz3c9G
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 07:05:59 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8b271e573adso1161065b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=lists.ozlabs.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=kkQ5o71KsU48A+mqRI2s6G3Sv5o7MyNPr7JXdRcjVo5o4n5B1cv1zaCVvW0n4h04P5
         MyA5LUVIMjkyx+LB2S5f1k6WkASNaoJoiT4sPXUqAM0f/HZCjHbduKzzh3JDAxiif1wB
         zjbWZFpaoF51yCe4XZa3sl32BejD/hOHJMhg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=eWaMH+zaQ46eHOMTrabCe3ApQt4ctzXAAvRFQKvuuBWL9DaCs3MyJewpySFRztCM0E
         mqA4x2HOOfYv/LX0Zx2ZckHEJv2MeFoDx5Dkta9ezLu+VU9mP0jdNijdp56Qyq64J0oo
         rGe+boifrBDXjSOu0sm3iqF1PE+ToecsSEa3Pruj64y0xSoziCj8+epzZgMYFGuT8KTL
         E452/LkVipOpEkjNz7CBEl57W6LbR7/EFBp2F5MH/OABxZRXDDvoihbW8EfMxrUM2xJk
         +kdGdQb5eoyGZ+pJQWbDaq6hGxZcRWNhsaJK9ZeRKsum9s2uUuzcEBEDqOunkmRhtavK
         2wXw==
X-Forwarded-Encrypted: i=1; AL+hErE0tR7mkv8WJgdm6ZsVbgsgGuSy7wO8dYY1w6BRcBbkcM8uws3Foq7xrcZnVumF8jwoVk56UISbcKjWU70=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+adeULYdw4d6xwhV+6qTQUAfiaus5DwgFhRTbJ4Nb55OejJrVd
	B1wfYpoCIBpN/hDaF56dIBmCT+mSmZ6cb7qLUVHbWFr7ZsHqS/v68jAJ/iTXYHTDcxY=
X-Gm-Gg: AYBFou0o3sCVIbzUFV/05YU8cHXPDway7XwZttEBKS5qpYACaV8OeM2cCIP+rgPImVq
	tIFhN2MwSZwpAJYT/knAXKv7GWRkPXHZLJh/hjmVRhfTes/PWxfPUes3cQqEqbWsvtCxXRp0lcI
	PcdhjiCtQ7y1cgu92ZO/cbUuHNUfwJxW+3di8Gjvq9lV65Su4bXA6JDiT83O9dGgPJngugU84Fb
	dRgveJtZLDsoICsuV1yF5xAJa7AzG8KxsLefHeOhT6EWuG0PO19bVNU4CXkl5h+CSdo/SFlXdeF
	z6fseloKWWEJa2W++8Vl5hZ6JoPgV7RfjDMRnslzOSUU11/+QErygTxKbpS7I4yV2uhr8pMpPng
	opH1WEusvBs7ZSYKSzijD2z55bXV+qlVqHfi/MQXrqGRZWedbtwzrUj7zuRLtF8PiZbmN3NpzIV
	iDJikqm9ErTPRpn82CSGD0/4vXyYE4B3RI5sNbIGmAW2o7MRzxd2qfX5KNmuIJu7Pf8pMVVM/Ed
	flsHUBC22DZyLV7jHS9acWKAV9DK0rfLwB4H8AqyEG/YstL18E6N27feSC7OCaOyM9hiE1pLa5q
	OxlOFrJC2UnILXBGjR6jb1eKEXx6TnfBxZPRi39DvhEABW5JkMgD3B0Zf5nazS+xmDkyDarWNcV
	ps9vZW0iLAl2RLniqgHRBJVm3Ca5YA4I7Ulvwm5zgmQtdkJkGTySKDzMRR6ECDIYDs5ZtCI2xWz
	UJvF1SHolX9tqJRhqJI9MuUmYGrwHd6MMwUOZgCRIKrO1+jJGe0r9bq7ke
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris


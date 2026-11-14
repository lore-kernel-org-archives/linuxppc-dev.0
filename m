Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E38606A327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=BkZ2Jf/N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRlVy6czNz3bVW;
	Sun, 15 Nov 2026 07:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794686762;
	cv=none; b=Zy0rxI9b67q4mXJDExZ9Km3XVyKSwmjam7/AIs3Z3LYrM8rioykcJKTeEK0FFT7oDZfbNlFfWROZxvl3nxQx+go/ADuZoCIT7ISg8/UdHcBalapENuY9EjSrQ0ZSnkVXKveGvrCqBy3E81sZZxuaLWLtrGKu/ROEZBFk+JQrIBkk2kZOJIQCb0kFu2Fa1U+gZJMXqlsvB8l5tANfDo7qPgSAFjgMvB6uaafKp5SvNHKSNFkme45I+oxRNL8ddYi3SddQZbTm1gDmT/vM0wbCJ9ZMxpkuu84PKdPvgiiLE3Hkmi8BY6oic+Omc/5OUHM3PTXmfXKxftR/HPHNBfOkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794686762; c=relaxed/relaxed;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID; b=edSwR4BZRvAUvU19hdQpcpJaLdbz+a2qdutZ6TEB5OcIQ0r6vJWw/j6fHxmFRV/rSCVhDYTuOiRXFR010CEs63ZwtDUbQ7zz5kU8IZMn2QJVVDJv+MaePg93wN7ykyS/L+K0STKOXBihGDovmak8dBoBxdTI+fBYHZnMlxQN55cugjwXJddD9OMX8ZsL/N6ZM3GUWyUTIKN/HyuifVdvS7BqyGxRQ4ce7aCnM64t+BcS7xx8md2fHHMqh7N6txpdRT8iKqjNCDuL3c1/PceAZnMvKZrfk5txKKJvhmD1F06mP7WeBMOaLG0p6jAXdDy6G7O8zHOHDRIWyN541Ajubg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=BkZ2Jf/N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org) smtp.mailfrom=chrisdown.name
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=BkZ2Jf/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chrisdown.name (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=chris@chrisdown.name; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRlVw5218z3c9Z
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 07:06:00 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1012762a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=lists.ozlabs.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=BkZ2Jf/NMkDzH1CG1X7qkyq139ChwlaYOxKhDNtZtaEQk907mg7f09+Q3h8FfWZvJk
         cflfdNeCRZBP7CVNpZ4lll9TPz9x4jC+p+oD3cEIS7264GucTUGymAuysJkHS0IBm9rN
         F5js5PbQ5VPP0oYDd85+YRrsKW7LJwxvx9wkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=fSWiVFYg9EO3RPPqbz89XePoAKRXbop1pZv7xLnTY0GJRsW1qae6de83nfpZh6zKmB
         MXyBkl74ERx3BkJAsVwMXioLRmx7cL1L3aVnFyOWyszDJVYft2M+DKYNW/Us53e1ipe0
         UZf3MzkahTWyrSyZjWvwxzc590SW3TyzveSfogGRMEwqeUtqy8z8tsrt2/3qtCjzthyr
         R5dVNSKyuPUDc5//pYSMS76tZzeBz/kViwagLIJz3f85JxH8nyVm5aX053KJN1HvFueK
         L7ClEeQe9utvm8ue5Bmd2J19+5vvSAP/1vI3vusOtUbJzty6LEYXQx/uAyuD1OrHU/tV
         UtDw==
X-Forwarded-Encrypted: i=1; AL+hErE6PUk/2pACNS1shKPayFUBcW5D/bpLbifUVaYKhgl7LtNeVfcDaKKPo5qmdM41vBuQ1p7wzonGHjHBOaY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/DvSjjdLplvB+FR0Og8ekwbjilAK85wS3YIxETvvUlZHsBHdp7
	ycxCt6I9TjI4RRqqVHq2WNRiOB/pIvKLEwohn/yK1wa9I5bQhudGUbxsqQlbieED/h8=
X-Gm-Gg: AYBFou3Zh64gmAz0m0cvDty00s5Hieatl7WQGq/HHW1SkQ3STjcY3uJqtO1UALlqaqN
	n84y18+JaihPVnajMn7Ac9i7G9FKKoDuTpTuiheFCbathqSRs9utg5F/iXLJ7aj1pO3Fi9y2h3z
	Qw1yok4vDrWPdz44cbMdSMM4W1M/5FhSUFxhSC1ITgmNV+tkX/rmLXieLICTjsSc44jCcFmEmQn
	b7UZ0sl6RcxLQejgdfPPQqeJREJ3hEvHxsqFnQOUlq/HewtL/lzJuKENIhBAXnXVoaVP79/SgSd
	op1Q5n/6sj58f8c1vA6vD/R5M6b7ptQJ+H/ymviX3ovkv6vr6pFb9p3GVakRi+2rJcPz/fV1QZL
	kFZz2hyZnf2a3i64NvjNo10KQJWFDK2blS7XLCd9s80P4fcWq5/I2HUVcND15ylmha3CgI4l6zz
	qNgHHX2hgBeu5tP5VUNOhrp3omJ1pNmbBv7evIZx9BMVoCChW46z1fXx+CAk8jCrThpiSauOngH
	GzGZ+k/zn1mS5bEJjqHwAF2x+4qea6tUG5zPt9VfNQmYxXNktibOVo3oBSc0VyH1Qu2lUnK7EZr
	0cNQioN5xc8p1R8KQOLELOLJohoqGmX5+q6JdVR2AKJRxHeHC260bYoVm9fPGSioxp+sDQSVslt
	ngKr7pZlS25/ZAEhq0mbbFabydIu/uTd8WFBcGYjNmRs3ehTN/xfRPitttYRTsUAa7E8gV7WIDI
	YKYPqQJq+HSMNiRg9RjetKW00cUCgzbnWbX/T1r3kKHH1or16H63bx+gHE
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
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
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
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
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>


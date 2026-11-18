Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXrdX61a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTp8L1S1Hz2xlY;
	Wed, 18 Nov 2026 15:12:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794975122;
	cv=none; b=UypmrZN3dcTfV1rZSsNQyXW/Tt5WiD/mPVNnLInb3CnOST1Z0zcBRr2Nv9M6GbVk4aAdqs9kFeCRnAK89GyB/l9olgkHEk+GetQKgocmmrMMwqIusD1hfB65yleBWu7IRkaN7dFau8Gd6dFO12VUsoF/ku/8BKydRrYwKBpQIPmvBWRVPlFLPt8AgbmP+tVNfxbDOiGsDiyrl2SAb//R6ZWgd/MBqAZWiQ7yFzUec1q2S1paSy8A1AcpHX9b2aSavDbfulFlgsHiXJS1zP+nK/XDCTkxUu6/Nkbs6LJDGPnAgQdL9h0uDGP+qgvJZ3xTKUh4BMmTT1vl2p3uNcT84g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794975122; c=relaxed/relaxed;
	bh=Gy1z0HGLQPQ7kJNGutS6TeEdiJI3oQdVi14nSbbISdM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fECZsXjmnGWVlJDbNUYq4SxRyZ7q6/QMMhKWA8NGjJKOdwrIYvIxCDMAcQB+7ZpaanWWk/hxrnULAArT3F1tLtVS/iRNpiDhOEWwrGldH+6o+xNk/4eftvnlCptfBX0tlYvJqZwTyUa+0THPSORn7E/SPs1BTCVy9g6g+X9cfosSHfxZcR/dpHAgQzOqfIpo1XiI7Cfc5Kbf93bgKVm3iHlreL7PF6kcIaSYKgCjc90urUX7TcyI3PoD4JYsxfKq/1/auN0tKiy5kYkhBw8U26oeieAWxFq+2lUiBuXUJTJHHoIkSjoXSRQuIXG6FxxK6DBmEsESO1dzJcueZQnGGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXrdX61a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXrdX61a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTp8K3WRPz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 15:12:00 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-33fb4680717so1387677eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 20:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794975118; x=1795579918; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Gy1z0HGLQPQ7kJNGutS6TeEdiJI3oQdVi14nSbbISdM=;
        b=YXrdX61a442rZP66z1T0ukIC2I9CuKkB3X87vnheiZ3UKjIEf+m1xpnd2rv7BB8yMX
         Wu8MmOcyy4F5En4anoB0P8ySEyJFagmR76PCdjUqmVu/lFqJMqTiwKToAXC0aAWlkIeA
         mgsSyb2mPOWNduW5JOMU54pri+5/jJK9lzlOmgt8gJr9s9R03CDJwYR0enJ8JuVSXp+4
         es3pn9Sr52/oyH5K69IRN4BjyJq5ydAa5Ktg3LKKlQM1aIYnj9/7cmUyIWrISkZzytVe
         RAhbpS4MdWN7pzyDSIIEuucjdvzgIhDdgi3lykdUYeqJZJbMwII5qze/o+1dfb2/zF+m
         fESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975118; x=1795579918;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gy1z0HGLQPQ7kJNGutS6TeEdiJI3oQdVi14nSbbISdM=;
        b=HlOoWmbJONo5h0bvA5U/n+nbxT38qUdeckFU5i6oz4WH97Gu3wQnYIuR7SP0vzou5+
         i66SErNybTbPBtX7Raoki/3V42ksPdTrVfvBagBhKhf8EClkD5D3lC9yqbD2+KiC3y6j
         gLlkG8dpXtRsU6uVG1/Ak5MgVxYFB3GFF5Pgin3AG11LV5tp2Nz8FTSXiVRV4D+cK0j2
         JAYloXkAXPe0UHjbhGKVxAlUFEBcoaUh4iKbPeRZuMUKXOGHHZAi2d0FLR167UF6dK6t
         P2RAS2zGj9PdJbPBMD+TnEKBNDsQrTBbKJpUIp/yRVqhTaBzRFBTZLIsSp4XUGBWD/TU
         zERg==
X-Gm-Message-State: APuU4Z/urXsjYf6CbSt+AYHacoQx8iRKeGewOwr5mmiAPOXV0VH365dh
	cjW84QxpkBfJjzUK9124n3yuMMORaq0ZNZEPug36ve7YsWOpTF0okYQ6
X-Gm-Gg: AZFdTZfIquSzAYDttGOaVr5JZiXWqR7f42LNsOMCpDPjd2RJVZ0hqMCB301ecEMR084
	qjCljYN92ZYQZ7nz36g9i4wQbKwK8HROTFnM7Qm7ZLzJ8K0aH9G0BReZzECevZrn4j3in5rqXBd
	iwd1JLvDlb9xPJwm3CO4WHcy3n/nUl7pPhaL7NvPquMTrtqqKwxZyxUOck06gQmjguLGoEA79WN
	x2N5MRWu9gY95UWBlPwZzqQjzbZ9JIrOBpWNDEJqhVfvWmuoPqSI5j+BkehI7QFwwbgDKHMPjip
	Nge+eJSrS3h9FME45hruVKy+RxJAeKfeQInlgwkHcMe9QAaFdzdGTv5d6C1z78PYWN+pD7u4Fu4
	yjW4T7mX1xt4YCd2oVyh1Sb2EEAYTptXk9vlPVeINeqLeX5zd6oFb9H6Rt2djpvx+bjc2XypuCI
	Y3JO6kz5JeZX+n3M32S5+QlHLoYRdGM7kmr/HvDVxzJvutC/i7CeofFvZ9mQgtt3erKQfocHjvU
	PyahIxl8Xz8eW/YUi34d5HNVM8rNGUT1lurqSudry3/4gCQEEB6/py+4/X9Nn4ggD+doWMERMCx
	33RJJoTjBxMQNpPbpizS9N1zguk=
X-Received: by 2002:a05:7300:bc03:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-38281427c34mr1917517eec.39.1794975118411;
        Tue, 17 Nov 2026 20:11:58 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d8015sm2686335eec.21.2026.11.17.20.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:11:57 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/12] powerpc/pseries,powernv: Enable clang context analysis
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
Date: Wed, 18 Nov 2026 09:37:05 +0530
Message-ID: <qzgi7pg6.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Enable Clang context analysis checking for PowerPC pseries & powernv platforms.
>

Gentle ping on this!
I am soon going to send out a new rebased revision for this and I am
thinking of clubbing this and the clang's context analysis enablement for
powerpc/mm series together [1].

I am hoping that we still have 2 weeks of time to get it ready for v7.5
merge window. Will appreciate any review comments on this.

[1]: https://lore.kernel.org/linuxppc-dev/cover.1790590014.git.ritesh.list@gmail.com/

-ritesh


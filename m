Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B312606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2lgoKJN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzFc60vgz2yPq;
	Wed, 18 Nov 2026 22:02:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999732;
	cv=none; b=IbQxBw680egJhwOD9peTuCHp8Wh5/hsAOl3PSFEqzb+DQisej70jJq4xwYoLlARsW2ArveTvOFFde296JpaDWEYHI4eRG7gn4PY5dZ54SnEi3SUzHvqzL36RIPeE48ng+yijsaIoVl3BZLczWtHuBR5cLCoQjErsbvILeBuxH9IdY8HwW/mWQgBSZP3Y/nHM9V3LkiAjS1JSa4OPB1YHmj1I9zF8kEQl3Tj7ggdAOLmc6q9Pq9R1+9uht5ZAOWsA30xl08mjJLzS50tdw/SPEnwoej+A5018a2JksR4uVd2XVlBr3bhzW6AF/92oCcjcgr+eRLaqWN3/WKVtiwZTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999732; c=relaxed/relaxed;
	bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oXQia9zBVerWuG8dGdKZq0SWXIOyisyoZ9YnVDGuNRVwVl1IZOY6JC0JHety9S0leMWt6i/2QDXRO8PjTb2t+GrpjSwE/g/mshLyLcNfzHMFNCEqF/n+j/pBQxKoPmXdYeUtBfR8U6PLv+/6vvAvsQ/3OyKFovdLWVAm4uTK4aFWTacZTNLpIp0Yt7EOeV/Am+d/wNk6a8/MDgvmo14DvvJmUnXibxvbcrZgdZ1i/D1KfswEdxqddWCEOea8qJsINCOeLXAI+Iz2S2/nw+zVrtvsUPE3ld/TxMIzicbitQzpTN9kEc+8TdugSSBHMiGfzY2Adz53sZux+RgLJgUpcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2lgoKJN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b2lgoKJN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzFc0KmKz2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:02:11 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-380b40312e2so2426390eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999729; x=1795604529; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
        b=b2lgoKJN+uGi3r/chxZviAKVZk3yrcMZClze58ObjSlhVNpQ4/nGSCNh9wMszeDhJ2
         jNEwYGq8ThUlb412EWzJwsioCPoF1GWznJS+aJJn4xP2oHsCiXEsXo8OTZUEheJS4Zch
         g5cEhMjZDlbnwr/iPxBy90Sv+uelnbsekq2hV8l2enbflR03FQ/SDLo5tg1ydYCxM298
         SvlDrZ4gx9i9tQFD3LiAHKvri+0tLeHYDYHATM0meE/Epg/4V0U2hrvK8pxV0F95gWe7
         zRaZ2DUVlGiLbZiW8au+t7+H0StXUsGoEJRai1/92J2Vg1zigsNIFpZfdwnOm+KaRZoB
         wYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999729; x=1795604529;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz6wQ0mKUNU0UkbDxsh2f3DKCiv42RamE0uqFpw1ylQ=;
        b=cnpci4IM23b0GrAID26laxgjfPz0E6ouhaBjmkCCtJODbaOHa58eZ6Z9BdSgi1HEZU
         YrpNkjnvNhblfovF69t0lz8oHvFgCKOawOL7zAo5WNpkuBoppgacHRAP+rUEJt+g/ELx
         CA2qrjmFZJ7pH9k91OC3JH6cYZcCeXqx+Pt8bVBAL0C0YhQwofJSUgOWdZSQFnKSj3SW
         tUKge3wOn5t0lsoEPo8eZsIDgwAyU+ggk8lk92XJgvXoUnuvUHVq0srTF4mFKlFdjGwp
         y+iA0GObPdFKBO8Db/oKXSjgufIAMy0i/fD5rIY39DtsxjXIn4h/Whqot/UEbcWPUrv2
         mejg==
X-Forwarded-Encrypted: i=1; AL+hErEoc4Zq2pUyp+6bdqorUuN6FPJSnM1iY5UaihN8LJMkOmc1E803iBGwz+xINTjwAym0Uh9P3h+8cx4Q5gM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z91F6Vohlz/fnxoXBysBSfa+UNgO+L3J6waUgUHfbGsezuckbbb
	foo9+SFOLQH8mZ++M22De1flz0d7Hsfdm7A45rAAUDzLqVpuz4o/UqE9
X-Gm-Gg: AZFdTZfyv/xRSQpcNhTsL3Qj32x9zEfKBJ8RAsU34+T36k0+4KjSXU+OMGvNdrvHsTF
	UuNiZeu8iV0aR8IeejmtB9FiE4Fro01bBaNAUocbALUd3hB4BH0SyT2pGcDhKY8aMMTeAk2LhDE
	JAoyBh9GB/VZpybg/frjA3xEv6UJRHwj4rhietp19ZhnZj4wJ+DU1FXMURYyLYNoEm/++M/SFFM
	2ivPrFdvw/6Fql0o1rxkW1Z7GYXjn/rLPEYHKMNhFtRppMbVi55wNnFXU89eDfCcvMBGdcvCC70
	45lSnOmWAKQ1v67howOw3B8o7blN+GKfHoIKc8kvUPrh6/KiTEhrZtMg3kS6xCICvfftaXX5GlS
	OMT9vI5/ervJ8uhMhAZEmtGZsQ9NvlCZsvAf0sccsUpKx4o17BoWqICnNWAB2rP+y5hCrGsQvyR
	KQ0e1PJRBFcjaxoX+SQiqcyVTChO5VYqYphlDq2mwp8KeRfws3eBpzhkWlBmrS0sPowxkGYJ0Tx
	fJ0+IviHAQsUZNrsk25VtJAzb0sFp0Zy9WybHfPQlPuW4W7e4GEX5VW8L3gYxLbJGB0vy02S4Bh
	o9tmsHioIaZrPJkJr5SPW7Pl7G0=
X-Received: by 2002:a05:693c:62c1:b0:382:1c52:da74 with SMTP id 5a478bee46e88-3828101d214mr2495287eec.25.1794999729242;
        Wed, 18 Nov 2026 03:02:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d8015sm6984944eec.21.2026.11.18.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:07 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Yadav <yadavgaurav386@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
In-Reply-To: <CANo8Ldu_Y=GduFxxukfbNQT-MOQmR8N0V8evYQPpO2+i1L1hSQ@mail.gmail.com>
Date: Wed, 18 Nov 2026 16:31:23 +0530
Message-ID: <pkw2769o.ritesh.list@gmail.com>
References: <20260807084050.25216-1-yadavgaurav386@gmail.com> <a4na92vc.ritesh.list@gmail.com> <CANo8Ldu_Y=GduFxxukfbNQT-MOQmR8N0V8evYQPpO2+i1L1hSQ@mail.gmail.com>
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

Gaurav Yadav <yadavgaurav386@gmail.com> writes:

> Thanks, Ritesh.
>
> Adding the tag and sending a v2 shortly.
>

No need. b4 picks up the RB tag on it's own

-ritesh


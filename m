Return-Path: <linuxppc-dev+bounces-16410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2463D73EA9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jan 2026 00:54:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2HbY1hWxz2xpk;
	Fri, 30 Jan 2026 11:54:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769723480;
	cv=none; b=S7AoWlFiwNdp/Nz7UUMS89izcnWkt3Ux7YmOlB8ekCaBQyOQGiGS30F/NpVVNfbe6ThZwWOII85Toq7KJ6Lc7NCCcaJKv9VMaZCMHooZuCnwRCIlK73YuxLr3z0q2gEmRSd4iiaFUPf7diIWXY8AiBxcurhJRTH+Kl+edqWCWS1SKbjpb5ppPywFN6GwAxkDChVaQUzkZN3fTT91XuBYpJp7iH20dqTuun+GsIXi77oxuENEkkbZ6cUVeHbu0arZI/CSsn2GhLqaxQFaYPfjs36h/gb7029dP9L9CxVfFRtr6fggBE0wGD9nMoAcKECg3D1t8amgtRNDUygwe8aWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769723480; c=relaxed/relaxed;
	bh=LQiM7IXyvO0gAzZaX2QrVT4u9XUkljlgG2xvuXbEx5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Myu6hX4oTbXqxyUOXxMW4v76EexHETYcGfDjL+eAvlfkX1orKCMGgcv8wh1RTTRicjNBGdXdClKnyLNDr++gcMYzDwlgo4txK56WuTmAqUeIjXQn0HO5Yiw7jLNVM4NU5cvvMnIeHVz02Uotjqaq5thv8GL/+OQz+PpiZOMsO7uCH1yTyPebjlaDK27GNiNqmoCJBLz1zRFOJTsVZbJYxCBSXIdEH+T7s9/fkjnG2E4asiJfP+G5s/T+FKFR5jHmPkjTjXYBL4Kjgae7gSOGpe3Nzpuz45olDethSUU77V0R4nqny7jr6C0m5ZfBLNJbqc/iT+mVu0W+8WgukwIMMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FaqBH9Q4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FaqBH9Q4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2CWp6b7fz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 08:51:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 279B243FC3;
	Thu, 29 Jan 2026 21:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC8C4CEF7;
	Thu, 29 Jan 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723476;
	bh=Q3zSRrovWIg3qmOPSQjV0l/EKEt3ItdS6bxMEwS5hy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FaqBH9Q4U7OFys5R54AL4OyCg9MohsuSenTOYbfovDHiAFJImhToOKL8cibZML05A
	 pLzDda4TwEdLJuUvW2ZVAPUGm+zZZEHs+G3NKafjtHBZqzrzBoSrN/3URg9JtalS3K
	 4tG+stzA4gyXCw+UAjlhzlPMt+pYWNs48CoaJMMAhQgj4KjmtIpsH3Du60NoD/xx7K
	 Z8R0skKUd6D2YIfUeagvZ/7G1xyhK2QCemCyGnyCai3m29eeQtqEt08Q796miVEWbk
	 uOAZS0dsfhwZ9hF4Kud/pB3ZbnDobW+SsvkA1/uRkVRBECfwr7FM5H25AyySQUsQJg
	 2XmxC14tZ94kw==
From: Thomas Gleixner <tglx@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v4 0/4] PCI/MSI: Generalize no_64bit_msi into msi_addr_mask
In-Reply-To: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
Date: Thu, 29 Jan 2026 22:51:12 +0100
Message-ID: <87ecn8m6jz.ffs@tglx>
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
Content-Type: text/plain

On Thu, Jan 29 2026 at 09:56, Vivian Wang wrote:
> I would appreciate if driver maintainers can take a look and see whether
> the masks I've set makes sense, although I believe they shouldn't cause
> problems on existing platforms. I'm also not familiar with PPC enough to
> touch the arch/powerpc firmware calls further - help would be
> appreciated.
>
> My intention is that the first two patches are taken up by PCI
> maintainers, and the rest go through the maintainers of individual
> drivers since they could use more device-specific testing and review. If
> this is not convenient I'll be happy to split it up or something.

I'm happy to take the first two right away.

I can pick up the driver specific ones as well if there are no
objections; they both have been looked at by the relevant maintainers
and they obviously depend on the first ones so they have either to go
together or postponed for the next window, which doesn't make a lot of
sense.

If nobody complains I pick up the lot tomorrow morning.

Thanks,

        tglx


Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38A606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20260707.gappssmtp.com header.i=@lixom-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kfz3tnSL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbBBk6njpz2y8m;
	Fri, 27 Nov 2026 09:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::72a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795728915;
	cv=pass; b=oAvI+bpA2TzI7ESHgwtdmjzPgr8kywloxgu5iUS4vyXLase3CDlmKUXtmf5FvVhwI9qz+m1zS5rcc+gMYBixLl95bZEjEXB+26MpwyPibhkHzVGU7/Vy/GYsg/MiO0YB+pB5TX8HVXyPDE88whTmFEG7a9uSiT1h4aRM28vSdEc+esuzWBT2ytnOx8awrVPGLmZzzTcz2laeHjh6gAHiDzCTJJWpNVRNulGr04x6+6BH6ukSlHMOxz4HXuaMEbO2mwQG9GesqqCeiAStFZZWvwCMHxWY+B1hJ+YZUjSyLYZZ8prMXHpMdP1Bym2v1Rv8hV283AbPdAbccQ+agN5PjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795728915; c=relaxed/relaxed;
	bh=imr/pu1mUMJ71goiXUQ4VVEylGbSw20Gr7BPKxEeuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSS0P2L4CoMjIM8EcXLzhk2QsTYJs+8cFqXjK32mZ0iRC7Ks1DLPO704vClo9H80VWTs0yqfMSm0o8ZuYVDPs/Fq8uYiqth9wU3oE8eoa5VeuYe0T3QTLVwJAXAJeACkggPSY9QUfCATa0AMEmPffiuvsrFAkaz8izMM5f6zds4VWGopyDsOyTy+VdjuChjPQ3u6K4a27pa1zB+KbQcIMiRMOvx1W2sPAiXfkPO/rcCYRAeOPaBnibVVAG5PW5Auy87J/kGCwwfYZwnd58Zv/8CK+QGR6z0ENAanWzsmict4DlD/gEUWuyq/r53vrcRR51W/jyL+BOL+qSeK14Ww5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixom.net; dkim=pass (2048-bit key; unprotected) header.d=lixom-net.20260707.gappssmtp.com header.i=@lixom-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kfz3tnSL; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=olof@lixom.net; receiver=lists.ozlabs.org) smtp.mailfrom=lixom.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lixom-net.20260707.gappssmtp.com header.i=@lixom-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kfz3tnSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lixom.net (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=olof@lixom.net; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb8wL0Rk3z2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 08:35:12 +1100 (AEDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-94965745d92so733414785a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:35:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795728909; cv=none;
        d=google.com; s=arc-20260327;
        b=T0s2ZiHnswLSVF2+40GB7pVSDDl1kgvznMuiowGTprA9TazqPPgLB2qmqKKxzK4ZkC
         GOrEHoqBe5UbyM1pCI0zFv0maBYjv5KSnsBmvEY+gBh0k2gyWkuSJ43YrZQRg+pPIeg7
         eew1Ww5gq9qDnjEZ3O2Kj4QCgJO8wxA2gdZtmiTR55BYNfZAWQC8WfhfDVvkM/utl95+
         teZT6yiAYNrtq5fCS062gpZXDl/ULeziToJLFDGVQGR8k/UqLRK0BHmbebGxHaXIqAZ0
         uWHRB1YnuyWML5M5E3Ziv4a0bhV6p1aUsRqJ3DZv1WxaswR5fk4sRY8CPX80Tfd2ZH0n
         a0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=imr/pu1mUMJ71goiXUQ4VVEylGbSw20Gr7BPKxEeuK0=;
        fh=9MdMIhf7K0MDGd4/QC/rzVSsAZ02/BWSdFWePot3guU=;
        b=hZ1EwMgxKCl3p2kEQHxUUUUJJNWi1T0oqmGNEWxkR7X4CElAQOj0Xr6gJH6rZp1nz4
         zO4kV03YcGCnAQcUt6jSNu9nRK6VK1J3DQRcp1CxdQI2EZmqNbhHV39H8pWj+XSlCjCk
         /EdhSWieRlazg59SxcndkNblUseO6YFlqNf/mqUOV8smeok+TW2PgZjbapFY9lBeT42T
         CRwk4bToBjGzPkQ1AZcMb+DBI022/km136ziI+GfPz4PCMvsTT10rIPB4Jdr7iLTvAhE
         O+ffIqDlrTpsK5VzaW9VwwPMTMiJ4FSea4rhfk2E+fF7IiMD9EAucmyEZsw0qIlu2T74
         uVAA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20260707.gappssmtp.com; s=20260707; t=1795728909; x=1796333709; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=imr/pu1mUMJ71goiXUQ4VVEylGbSw20Gr7BPKxEeuK0=;
        b=kfz3tnSLLPtwNB1ev/YIxUjJg/br2eoyrC50nnPJBX5zt3lvtoDS5mK6mIv1l+E6tS
         V3sFK9aEWVDoiZ4XLyDRWhIzPdyMOXOVZbYHMPdZBD7Dl7BoTRlB8ARrWDdtnjaj7/Oi
         ikexfYCDBokrZ0bsCMSrYf5xzWBmQl8jMGtFen49oQvpL1fkG4kr/EA9vk8j9czqCTis
         glr0n+PWxSzEo4tuCVHX0AYE8sv+xTUVBLhG+bISKzhwZUTK156XnHySW9lho2yZZQnb
         foAj0bXYaKk5ZpSsknovfkQV6hNo907Wr66maBa5/0u/nf4sUbGbblb1gxDNztKrymKT
         T4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728909; x=1796333709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imr/pu1mUMJ71goiXUQ4VVEylGbSw20Gr7BPKxEeuK0=;
        b=umAZovwp4obL4wkgXVyfpLXAsQWDsGB+dJh3N/9/lTA6G6IvHy+XqPpRq/8F33QiYf
         iKFGRcT15SHg5uze9Lvgt8EKzyXBRWMD8ciwUQX1Dexh55rJofgeo8j2ATOvbl1ZxdB5
         CwaqGKBALdujONwPMy30nPMJxmcR1CdutEBWcMSWQ2rOiW2Qu8lKHaEePnMH6akvwM/G
         r+osD9Oc6Jrj3C/H9hIda8WQ9NybttY9kCXJ8rTS6uixYR43OLOZpEUF0Y+bM41sfWyH
         C83DVoDChLhrliwrGJSMIBYJaT/e9HU+PGmmEEMvUA1V5Qf1pGVQRsqc36F0AYIU94q/
         FrOg==
X-Forwarded-Encrypted: i=1; AL+hErFx4KZxvecs71cI5+gLT4IkRuUCaBaFrjdpiPadY2mNx79UT5NVww4/SAOZCkTFhhbbRmeAQ1yDNR/slvI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+goR4bSFheBZhrUlSIH+5M8rP5BUYszaxhPITbVtiyGT/syYBA
	1YPCtpUA3X8NnMFd96hqZ0T4ezqiESEsL8xoa5iVVzwwSzBZoydMmnAip2Pf/DIwhtH4vkw5xKe
	K6kx2jXvGt2J8ryD/eHi6+w4w0iVDHAQYGqZLMEQfdQ==
X-Gm-Gg: AZFdTZfgpQ08OYucBt3xWit22+NvnElerJFoMS99guCzF5E9rUIVOJJvtHXI4smGZHt
	OCeaLWydSFdY3r7JTbLbZ7hNxOvUHcUgnQjO+d3zMYf6X14kUeJSutyfXUe2JQzrgU8SKxDuzxg
	pkZb1eah72f1YDxcD9jpmBFExwR8QtDiLWx/NptFBWcJOJK3xues8V9fIgonf+GJ9hTxTU8Kp6X
	zRoaZGbEyA5ujq/qb1Z6Ogw/ENpg1M/0e//WGOWNBvdAaQvUXN0d6BtxPYNN8RfefW1aIDIZ4ls
	IKvwPqfiZ4gD8z/9rIN1iEczUnhSMFBr2bSplrncyxs8Zf4BjUy8M4NJAAuwprszN1brtu7y4B1
	g579OmxZxZP2ojPA1oxX1GHWB6e7ZPvdSjRH968TssdCClxf5jhIheW7hR/cHUlc9gO3JsKM=
X-Received: by 2002:a05:620a:450e:b0:949:a13a:34eb with SMTP id
 af79cd13be357-949ba966a19mr4162430685a.29.1795728909325; Thu, 26 Nov 2026
 13:35:09 -0800 (PST)
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
References: <20261126081637.13160-2-fourier.thomas@gmail.com>
In-Reply-To: <20261126081637.13160-2-fourier.thomas@gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Thu, 26 Nov 2026 13:34:58 -0800
X-Gm-Features: Aa3M54o_c7qk5OPhsBIELSwKORdkmm8n7w3FX-EvieIWjU54dxA2oRgOKSssmhM
Message-ID: <CAOesGMge=cyKz-MLG3Ud_jcUBm-QiZk_VaMXe_Tn85pB0YuQ6g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pasemi: Fix pasemi_dma_free_buf()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Jeff Garzik <jeff@garzik.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 12:21=E2=80=AFAM Thomas Fourier
<fourier.thomas@gmail.com> wrote:
>
> dma_free_coherent() is called with the wrong arguments. The two last
> arguments must be the virtual address and the DMA address but the
> DMA address and the allocation flags are passed. If this function were
> called, it would call kfree() on a DMA address and dma_unmap() on the
> allocation flag.
>
> Add the buffer argument to pasemi_dma_free_buf() and pass the right
> arguments to dma_free_coherent().
>
> Fixes: 8ee9d8577935 ("pasemi: DMA engine management library")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Just remove the dead code instead.


-Olof


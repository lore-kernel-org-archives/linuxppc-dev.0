Return-Path: <linuxppc-dev+bounces-24424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D69C4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 15:01:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h36KV5Z8lz2xyh;
	Mon, 20 Jul 2026 01:01:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784473262;
	cv=none; b=GcGvZIjcYKPUPjo7gh5jjsQVhafOUaemBBc0w09RY9rpO9MrelG29CLhXXAlCRkaPwvod2t2EFos7tcOxh6IjNZpUCBFU3zdTgeBqk/43pTsZipn7SUwwv49VryTYgI13DklDMltG8iTJWCMxLOa37DyUEHtxfmkJpS2PptQlAP2zPSM6GxI4XXWwzIOM3Gff97m4kKxTffs+DS1gy47tjEFTFCx5mSgObn7YiF5n5qo6JAUrDhQyOdqaqkjObtrmK6AgXliDBuvFeaSgD0IZ33mIgRq31ZQKGxncngy4RPY0KnNcH6l8jk47jlzQ8VdSjEKWsXSGInapwY2vkFTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784473262; c=relaxed/relaxed;
	bh=7XFHPq5doombv5JpyLz/Wpbmjc5CVKs6Bpy3BxDsQV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQS/ywHT+DrOEkWEQH24lizd8nnS480ZL5vRsIYQk6YDU1dgUunJlRGF5im9u/v1MnDaLkV5qdLMArU2ec4AKhFFeqx2Qx2qcQDn9Q7nLBHhldZWlW/jgwtE5FG/BxvNKd1qrXAe7aBOk3+53Zpt2AGnlqbZIK/Kbok6NSI80lAWH+YsG81bRO/K/l2i+rI8LElS52Bw61G+L6aMaE81YWVUtyrDkFOkXqYSCFdsbkVVxrwVV+/Q0sm/RY2k8wJHgBlGkdeQ7vZKZ20T7eUT3smjyK1PmH6hzyJorPrEkt4Sem5/XA+2KCz3ityKHg08OTDesYT+JrMQbEdaQ2Cdfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIcXzbQv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIcXzbQv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h36KT30CFz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 01:01:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81C3660A79;
	Sun, 19 Jul 2026 15:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E2F1F00AC4;
	Sun, 19 Jul 2026 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473258;
	bh=7XFHPq5doombv5JpyLz/Wpbmjc5CVKs6Bpy3BxDsQV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIcXzbQvV4Wy2N1R2hRKBwzyf8X5lOFVNxdhJVOZcffsmctfBv1TEGtarCMq2Wpyv
	 f6zfyHuSzqs/hRqLhDnAO9rI4SVPD9DND8BxAEuCDWWF1HHxU/axoUMhnhwXJiTkwg
	 VGl/igeMHvs5mJh6OTVFdwVO+k/roXgUVmPhC8b7FEXmiJjhbH7+lt2zKouM/onmCW
	 hCliycS0AIgF7/bS9topBdEFwGcbw11pb8TiayDFlQXLOYHJqUEgnmd3c0XB9Hqz96
	 uHYIoJpcpY778ggUsU4H9QzevesVT+LY/3wUUJgihizT9j2TEXQoPDEbTQ8jOI7GMj
	 1efSimmyFQySQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.6.y 0/6] cBPF JIT spray hardening
Date: Sun, 19 Jul 2026 11:00:30 -0400
Message-ID: <20260718192718.0016-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha


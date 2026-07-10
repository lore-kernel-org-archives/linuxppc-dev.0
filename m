Return-Path: <linuxppc-dev+bounces-24032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE67C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxkp31kbKz2ySg;
	Sat, 11 Jul 2026 07:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783717419;
	cv=none; b=agOxT2LK5hB2vQFswCsCcfzAkf9aZw2ZYtRJ+32e/JC2zQVszB84Xsz4juxg4GJrzNkPivni2pBU2WYkKjQZBvxTBN/PYW4E5rvzt02i75m9oOdDR8HzeUS2xzVuBXlS3bavEWr2yQdsJJMzJ5ZDFAUBc60yUGwBRV+kIu69o+6F9hVyedxv5BdpuDAhTelyxKM/YhT58GuOgGU3chJhXGSasxdb1IpnD91MXqGO1YZm5IgDqomTKwi4FeAzitT1t7+T2wG5U2Pp/WYj6F+xC5ywx+NoVVxUeyOoRLJVyFcSiuVzO/DjJ3rJNoQ7mDEc0f54O5Zr7xZz9UI6OJ2wCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783717419; c=relaxed/relaxed;
	bh=A6ZivBYGr8LA2bUO7cgwXGSWiepiPbzSVpCEbDDI1mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3ONrsLhW/u8omn2fUp15GNdyzth5Ei1dTAtLSOJiMcrWgg+LYPCvAicAIn0h33HAg4PHNv/uBJG7DnjfFOdzzaOW4VtWG6byPQCILDEhvimu5FGniLQfn3j0ht/5gmDKbrm8PKK+TRAO8Bhbxqc4K5i9oe8JKEgCAGsJIgVnylYXI0vS3DuqdQlop3v9DS8wt6eOOq9L3V+Qpk+qnvHytMzjXPNoTnavsBxnB9LsemT2EDJwVC004p8XelAgue51cSdlB2ZTWf0g7/iW5f8n8i4jCI9xwaMGqvoIspaJb3Zkj0RGoq/kDU5iNl9GPGMMe9PqPCoCNEkDXbdBaeK+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbNNNPck; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbNNNPck;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxkp22Drqz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 07:03:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0E25F43F07;
	Fri, 10 Jul 2026 21:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05B61F00A3D;
	Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717414;
	bh=A6ZivBYGr8LA2bUO7cgwXGSWiepiPbzSVpCEbDDI1mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbNNNPckQrdYDAlUSL/va76XXbFFV/M71lQjXSYpZT/R5DWVOE9hLvDwyepCkV+zw
	 ew9ZsWbwWN3d2JL3oWsBOBLyE83y4owtF0+Eyss+Ai0jBE88hI7KMHwNyYgVLs0tgc
	 R5LE4B1uMRLduiGro3EUze2g8wiC5dBhPdAjQ/NM73CB5K0KQKdHKAEfsrl78RVPG6
	 c1ric7fIVn82IzCB6bfwmTx6BFo+538W0J9wxsGDn5F9e+dvjbVsL8qBKk44CWUlaE
	 c3IW3rfAYZ38PYZ6FJ2XJCt7tcoLdN+QSeg5ptN2Cn+4OZp0QKT8LywmIqJJEXlp6z
	 8TOdPmDMZ7dHw==
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
Subject: Re: [PATCH 7.1.y 0/6] cBPF JIT spray hardening
Date: Fri, 10 Jul 2026 17:03:07 -0400
Message-ID: <20260710163023.agent5-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
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

On Thu, Jul 09, 2026 at 03:22:54PM -0700, Pawan Gupta wrote:
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.
>
> To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> The flush is conditional to spectre-v2 mitigation applied.

Queued the series for 7.1, thanks.

-- 
Thanks,
Sasha


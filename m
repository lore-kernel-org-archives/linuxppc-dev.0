Return-Path: <linuxppc-dev+bounces-27383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B964C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhX235mZz30P3;
	Tue, 15 Sep 2026 22:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473027;
	cv=none; b=bkgtWVKS2WBPjYeyEBItxajoyuoNQkSn2qItbjOccrLMipb4KhCDN2lYfije9J/cjFeOoSJkSyfL4hk8koRGNb6ClSEF7M0WJjX6yRhmwVsjrHHFxHjvTJuP4E6HFgurI+lf0BgI7f9xOM0LhY/AEx/CtU6uKsHhGXeu0qvIu3kunkhcWTKu0G1DytkNG4RsJrOOxBBRfWee+nIkI5HKbD24dLwMqcRWusE+X8WohkAXbYpHgVnIq4p5cOhsiZF/tuHNWc6JzC6xDRWy7csGrufrer+i81wsdrcScAcyLUVhsbv156gtWFY8lRt++auwC9DWeuDotVa7GLTr+mCCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473027; c=relaxed/relaxed;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMjzub9zUhk7gX4Ddzn1/buNck/WXF87U5p9+w0fD+da/xsHdORJHx8YGatO6HTxq/1Hg/uQtg/jw1LctpcQJ/qDvBYQxYd3CCMPou5qqntDDOVs5yrBOFhtfHQnQy+P9/hpJRaTrpwbonZ2ELNUzUfUJsL/naUKx2oPsoIcyx4DWIbTGS5X8/0EBZ2HP4SSCcyvV9Uf12YAGyp9l3MLu66DFtUcBnJKq03Mzro46DT1CXkcdicn7xClLohiHB82Vz4yAnMPQhs4jtPlHFPVKd6diMDJ2+lWseZQkLTCmPDjrNlKwrqK73h4ZwSOyZ0E1N42xOz9UQd8arVC7FlUgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K53ZeQCF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K53ZeQCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgLp5b5Rz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:50:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C0B741256;
	Tue, 15 Sep 2026 11:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B31F000FF;
	Tue, 15 Sep 2026 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473025;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K53ZeQCFgiRlmkmUKqyt03ueVesYZEQr8ZHRmEnHJr7bteBPMY+FhF3KYLtuCparh
	 nKgFz0/6jbq1bui4jC+jYX4ySwDgwyBFWSGcoZrPkCnnSxGxTvfC6BSUPgQq6hQvNN
	 +1Spfhekga2XDw3G/J02TP4WSUtA8F4az2wYUgLljPdaWE7BVEbc0aUoQxQBuF0+j7
	 SIyPhVaxFVjk05zS3THf3p+jtDoLWiEkH1QK9B2j4QqMORMMx/IRGI5cyQTCspKNmd
	 5UGZ+jgOkWGk3ahuQaW3stL2pre2KPKFH28rNWpoqvzsKrFKXAxDwAFKyj9oMjB17X
	 ecSlXehy4baoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 03/50] alpha: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-mm@kvack.org, bpf@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-sh@vger.kernel.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jann
 Horn" <jannh@google.com>, virtualization@lists.linux.dev, linux-alpha@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:50:23 +0000
Message-Id: <20260915115023.DF7B31F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it once the untraced system call has stored
> its result. A task that reserved descriptors calls syscall_trace_leave()
> and joins ret_from_sys_call with the flag gone.
>=20
> We mirror the traced error path where the switch stack is set up and the
> return address and the syscall restart state are placed in callee-saved
> registers.
>=20
> Btw, let's remove alpha... It's a pain.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D3



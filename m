Return-Path: <linuxppc-dev+bounces-16161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66056D3EE9C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 17:20:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxnrf6bj6z2yFm;
	Fri, 23 Jan 2026 04:20:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769102434;
	cv=none; b=Qo5YvcmxhUDaBrGLuQeHDdpMw9DM/8H1MOA7Ed5KXQbNs7JA2dnsVOq7Q8wkYygZVKxhQwL/MCoudQu47RgufoCm/icEtpMfjLuQjHrgSx9FwKYTnFZfl6CBhk7LwN6flHfJWj0Ygf2OuCWEzMfjaiZRSASeZuWOMppvWn5UXagPfCE0kEicn3LvExETwtN+9d6Ql3L//eaB1pnNOTXv+nbPNmL6EVY49xiOI3+s8hESI6iLjmMacOzT6PXh0oXxU6OfrUlR7BtBdN5bmydfl3KSOIulYBkSrdXJfnaBU7G79edO630psKTlIznVC+Kp3C0jcZjhfK0Hp+7QCSuNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769102434; c=relaxed/relaxed;
	bh=geI3Z3VZuSC+3QFB3AAEV5NDvwqLLUEMuqEM48ID4vk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IG8nWYt1C2hAJr/eEjGzOQwdIGcexz3KS4wJu16OtLoajqZPDtgI0ylCEwOcCjFZZw03zghomaMvAxFG0oDfJSHHlJDA7H4t8Srn5830xSOCQ0G1wVDxqrZlkF84J7vt8wLI6TBywXkaiC19YaNbte8EuPfD8xg+JVRaUtxC999a1/Ww6uaE0QtN9l8YvqvGqs8HJmpgiQc3bDPOvQRqAGqKTIg4SMCGyroN6UbJAs49+0/zsoTCBllxTA/KbTqErmVVpWm19A5/wF2AUSV1lbo9KZtfYPs+y5f8+idNb7fzzAp14yoFXHdCgOBcSIiTKB9poV32LRN6C8XML20hnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fOrQwU6g; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fOrQwU6g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxnrd6LBgz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 04:20:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B41F600C3;
	Thu, 22 Jan 2026 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E5C19422;
	Thu, 22 Jan 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102430;
	bh=R+AGZOzKvwQpWoujXGlEYoRGINMghLh8EMK9qhENUb0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fOrQwU6g/8TPH/MEIGQUiwAk8+YsdtosCaHYpgbU6ewCVffXDBX+ef6F2o3ov/cX7
	 PINGn1QOi+UNjqGhY7olv8XWiiLEVwLtjfoff9u6l7pq7pKmSorFReBz28iHW028Dp
	 QelHEjqmUMtHJ8yRJHkbbuZccnL5qSoVrB+6NeC+tt++YoVaLh5WW42v01UYPMN6PB
	 BF2eVS7Y7/DOjqjLzuBrxO6PAJbmFlcqlo3r3HE7zqGs7r6Jg2h2SP9zG3h1UVY/wG
	 gs+bRON15SCQMHgMBd19XSxDja5BQwPbMgyoDBm0ioNUo8AbZJcXiUD3QH0zDGj0bp
	 wMxd6AmsV7ZRw==
Content-Type: multipart/mixed; boundary="===============1735738550655913399=="
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
Message-Id: <55608f784fe006db8781a09b89717c4e80c5005b4d451e7e22bb95b956f8296e@mail.kernel.org>
In-Reply-To: <20260122165716.10508-2-adubey@linux.ibm.com>
References: <20260122165716.10508-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] powerpc64/bpf : Moving tail_call_cnt to bottom of frame
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 17:20:30 +0000 (UTC)

--===============1735738550655913399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 8334cd667bba..9f6ec00bd02e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -24,6 +24,7 @@
>
>  #define SZL			sizeof(unsigned long)
>  #define BPF_INSN_SAFETY		64
> +#define BPF_PPC_TAILCALL	8

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 5e976730b2f5..d5757577f933 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -604,8 +604,8 @@ static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_contex
>  					       int func_frame_offset, int r4_off)
>  {
>  	if (IS_ENABLED(CONFIG_PPC64)) {
> -		/* See bpf_jit_stack_tailcallcnt() */
> -		int tailcallcnt_offset = 7 * 8;
> +		/* See Generated stack layout */
> +		int tailcallcnt_offset = BPF_PPC_TAILCALL;

Should bpf_trampoline_restore_tail_call_cnt() also be updated to use
BPF_PPC_TAILCALL?  That function still has:

    int tailcallcnt_offset = 7 * 8;

The setup function stores tail_call_cnt at offset -8 (BPF_PPC_TAILCALL),
but the restore function reads from offset -56 (7 * 8). This mismatch
would cause the restore to read from and write to incorrect stack
locations when BPF_TRAMP_F_TAIL_CALL_CTX is set.

I note that commit b18ae1c3dadf ("powerpc64/bpf: Avoid tailcall restore
from trampoline") later in this series removes the PPC64 path from
bpf_trampoline_restore_tail_call_cnt(), which would resolve this. However,
intermediate commits between this patch and that fix could have broken
tail call counting in trampolines if bisected to.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21257691486

--===============1735738550655913399==--


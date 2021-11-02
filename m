Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBAC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:45:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FA660EE3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76FA660EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7QC1VN2z3dfR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:45:55 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Ft1gRmz2xtc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fs6FVvz4xdN;
 Tue,  2 Nov 2021 22:38:41 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: jniethe5@gmail.com, christophe.leroy@csgroup.eu,
 Hari Bathini <hbathini@linux.ibm.com>, naveen.n.rao@linux.ibm.com,
 daniel@iogearbox.net, ast@kernel.org, mpe@ellerman.id.au
In-Reply-To: <20211025055649.114728-1-hbathini@linux.ibm.com>
References: <20211025055649.114728-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH] powerpc/bpf: fix write protecting JIT code
Message-Id: <163584792256.1845480.13895202988410061927.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: songliubraving@fb.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, stable@vger.kernel.org, andrii@kernel.org,
 paulus@samba.org, yhs@fb.com, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kafai@fb.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 25 Oct 2021 11:26:49 +0530, Hari Bathini wrote:
> Running program with bpf-to-bpf function calls results in data access
> exception (0x300) with the below call trace:
> 
>     [c000000000113f28] bpf_int_jit_compile+0x238/0x750 (unreliable)
>     [c00000000037d2f8] bpf_check+0x2008/0x2710
>     [c000000000360050] bpf_prog_load+0xb00/0x13a0
>     [c000000000361d94] __sys_bpf+0x6f4/0x27c0
>     [c000000000363f0c] sys_bpf+0x2c/0x40
>     [c000000000032434] system_call_exception+0x164/0x330
>     [c00000000000c1e8] system_call_vectored_common+0xe8/0x278
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/bpf: fix write protecting JIT code
      https://git.kernel.org/powerpc/c/44a8214de96bafb5210e43bfa2c97c19bf75af3d

cheers

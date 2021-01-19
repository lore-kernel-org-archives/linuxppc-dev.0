Return-Path: <SRS0=EbLt=GW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 09:02:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9DA23103
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 09:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9DA23103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKjNH2Y06zDr44
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 20:02:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKjL56zhczDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2021 20:00:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UW4jOfQ1; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DKjL46NJdz9s24;
 Tue, 19 Jan 2021 20:00:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1611046844;
 bh=cHNpqBjjlw8Pr4axpRHQyxwCq/g05L5in9E5bsY/hec=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UW4jOfQ1xHYkRKzCwGIRSdeDy4jQDIYAV33Z8Zo7vISoNzYqYS3BmGmVhKG52kC8u
 Dp3b3EdqeMoq1IK4R9rZBNuscFWGL72u2B3VicH0kuqkNEKB46JDgpTqWYfD/yiyxZ
 rbSKLH9Phi+lDCe7XRAitpTTW34Sfx0FQLl1tmG31+brFeUZGLDyKrxT53RXogEVW4
 DpWC8I/Ug1F8S+21SaVKgeutlm3QQqnONGETffaoNqXl5vUHdYRWcDT/3yoIpcWVqW
 36XvbAIQSZZslCv/Z35ZCW2QY7STj3Qt/dAx0u3kwf2KTFgRfmH0a18ZNEjHYo8Ur9
 L8br38tfmUG5w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/6] powerpc/rtas: constrain user region allocation to RMA
In-Reply-To: <20210114220004.1138993-7-nathanl@linux.ibm.com>
References: <20210114220004.1138993-1-nathanl@linux.ibm.com>
 <20210114220004.1138993-7-nathanl@linux.ibm.com>
Date: Tue, 19 Jan 2021 20:00:43 +1100
Message-ID: <87mtx5qp1g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: aik@ozlabs.ru, tyreld@linux.ibm.com, brking@linux.ibm.com,
 ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Memory locations passed as arguments from the OS to RTAS usually need
> to be addressable in 32-bit mode and must reside in the Real Mode
> Area. On PAPR guests, the RMA starts at logical address 0 and is the
> first logical memory block reported in the LPAR=E2=80=99s device tree.
>
> On powerpc targets with RTAS, Linux makes available to user space a
> region of memory suitable for arguments to be passed to RTAS via
> sys_rtas(). This region (rtas_rmo_buf) is allocated via the memblock
> API during boot in order to ensure that it satisfies the requirements
> described above.
>
> With radix MMU, the upper limit supplied to the memblock allocation
> can exceed the bounds of the first logical memory block, since
> ppc64_rma_size is ULONG_MAX and RTAS_INSTANTIATE_MAX is 1GB.

Why does the size of the first memory block matter for radix?

The 1GB limit is sufficient to make it accessible by 32-bit code.

> (512MB is a common size of the first memory block according to a small sa=
mple of
> LPARs I have checked.)

That's the minimum we request, see prom_init.c:

	/* option vector 2: Open Firmware options supported */
	.vec2 =3D {
		.byte1 =3D OV2_REAL_MODE,
		.reserved =3D 0,
		.real_base =3D cpu_to_be32(0xffffffff),
		.real_size =3D cpu_to_be32(0xffffffff),
		.virt_base =3D cpu_to_be32(0xffffffff),
		.virt_size =3D cpu_to_be32(0xffffffff),
		.load_base =3D cpu_to_be32(0xffffffff),
		.min_rma =3D cpu_to_be32(512),		/* 512MB min RMA */

Since v4.12 in 2017.

cheers

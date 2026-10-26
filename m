Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441E60A2601
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=redyjGAN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD5231JfTz2yKn;
	Tue, 27 Oct 2026 07:34:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793046843;
	cv=none; b=cfg2+bIxAcGXC8NfxWt7kOK1HPLWiVIqfJDZRLjt7xJq9AT6LQny2Kfctx3xxOhPPsMLlVyO6xiJKp7jZiZy68dYQ1lM3Had+MVoLkQctCPfpjUCP1NXy7kUsPWwxZHl0eTKArFNa72H+CWoN1dd2o1gsJIeJ73aNd1s8FnhoLhyysRP0YhRG7gmuqjvq7/cfRjons6c4Vc6r3/f4xzKMwx+N5mL5bIevo9gjHxBGi/hI88C+Dh/+t4ho7G88rpRS+whb9j4EyH0EMd+nk94/15iFtyN+I2nbt7xQuBlJnu3qyr12zaxfwIfaa/IyfEjxgsI3FLG+tJmPtnYonuVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793046843; c=relaxed/relaxed;
	bh=SyrOD4nxK3+1VMgtAgfF49M56P+HbkcbMWd7Pxr1oWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egG/ScYSYGUUzNO5OZ42FwuGcvhduNL9gRnmYy2PnZBVtJ3/Ka5y4/M3sxWTLVUpsuF6AkpFPcHOoWr/S6qtqaA1cxV3+aC/3FiTavLEUjNSEzhxFc/TdIycUSdi6MI3d/f7DIPGqtvq+CIVzmZCoBiDrzDr4DjHTFhODHb0gKh/ZVsZgT/YJa4IHe1Ngg5Ahu5HJpWPStN5QBmdKTz7I/wBeOmcaarr+IF4+t18q8y6CicHS2u9hp62ygqSiwp5GTkRN/4xkLPe5qZ90l6lPofCTSY2YFOTFujkCb4qpaDB5aute+wdLPZ03naOLlP19hIr/jn3DPo2h6NtGeYAzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=redyjGAN; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=redyjGAN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD5215fmNz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 07:34:01 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jD51z6Tzdz1XM30g;
	Mon, 26 Oct 2026 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793046836; x=1795638837; bh=SyrOD4nxK3+1VMgtAgfF49M5
	6P+HbkcbMWd7Pxr1oWA=; b=redyjGANn7/hLRfLhs7aJOh09mMJ913xMSk7MTEI
	vI3Yk+s+p0yVkDCpMQBkATobFCWeKjI8MDdl0Oya5kGyVhdhQsB9tiSqma0WpJB7
	sHOYpy//JNNKr8/wHwR1F4f1zN75z9KZ4j/OBxG9BUTnaaaG7d+V/Aie0C8HOot2
	3t7Ug0ZcZlVN+N2eGMbrCfj4VEbPEPREZZQ9Ma9SCJ+ZtFr1eaLmOMcrzskC9qVx
	AF//O5TWyviTss8PWYHm/E5RHvzMsokAro2J90COLpQhWZ70awNRGOz2yh8ivxOS
	6X98WWQKVFaNO3retvSGawqTYBryI8QkJ9wRl339k6TEpw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HsMcfnYmj2MV; Mon, 26 Oct 2026 20:33:56 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jD51v6xNKz1XM4Tl;
	Mon, 26 Oct 2026 20:33:55 +0000 (UTC)
Message-ID: <54994cfa-ced0-4eb0-bc7a-43b860c6ec19@acm.org>
Date: Mon, 26 Oct 2026 13:33:55 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/iommu: Fix an RCU read lock leak in
 mm_iommu_is_devmem()
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <chleroy@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
 <ed315ff8-36fa-40ef-90f9-01ad197a9f94@web.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ed315ff8-36fa-40ef-90f9-01ad197a9f94@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 1:27 PM, Markus Elfring wrote:
> Under which circumstances would you become interested to apply a statem=
ent
> like =E2=80=9Cguard(rcu)();=E2=80=9D?

I will leave it to the PowerPC maintainers to share their preference.

Bart.


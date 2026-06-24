Return-Path: <linuxppc-dev+bounces-22955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806CACDB470
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:18:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glYFJ5TZyz2yYq;
	Wed, 24 Jun 2026 17:18:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782285508;
	cv=none; b=N4+Ou6S+gvLhGZOABqiygLrqBbGqP4rMkSGdnMMbYsM8aVhRk+bpmNavNbxohS0gKxFwpPNjdam96upzzQPpxNtFlWdAECmQD5RZ5M8SMoedUX5P3h79dPqARpv9orS3bPBFyYbRSvWxq76p1eJup9Re68Cwj96OcL2E2Vo5n6SHYzcm6DwKN21eFd9wx50TEBd8+xFlqfQWiTYZZktZtColdRSHVjc4AdDBGQ6QjJxOS0Vc61qcm/oOSAn/0t2O3qR3BTweg9bnsQC0n2Zq4KXYtzAudshwNSPoMsvd1Xmf/Gb+wNbjwmgNR4VqL9sA4u2juuO2x83N24PGAf8Owg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782285508; c=relaxed/relaxed;
	bh=tYnX/KYRq2a4qOnQiI42I8nnFvl3gY6ZLXnptEri7C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jxuqWmaaaYjt8mTtqfOps5FdDiDbiokrN/PWgv2LkvbeeVaHaiXy36a7Oy3aVTAMM3j/pxF6/K+NM06WpgYIz65A8QA6zlyX91raAG7Wt+z14vR6BElfmoeC+xbttGgW93uoIKEKfMX6FHg8rAkvf4cBTq6msRR5duHPfyK11N61IPp1fX9pExzjXaFmH8lW2/3x1PK11w38mDNmm6zqSAxP+b4aUvS/RiCD+iPR9s7PaH/wK18uirR+5sfdoXWHOtCPzjznXARxp3gNl9HsHni9XDBxfg0WhsjLIvp/tdzSMuaH7i31lOqEHU9A5E3uVjfP21VB2sMf9Vz+jZwxoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=M2+l3uNL; dkim-atps=neutral; spf=pass (client-ip=150.107.74.76; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org) smtp.mailfrom=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=M2+l3uNL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ellerman.id.au (client-ip=150.107.74.76; helo=mail.ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glYFH2RJ6z2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 17:18:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1782285506;
	bh=tYnX/KYRq2a4qOnQiI42I8nnFvl3gY6ZLXnptEri7C4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=M2+l3uNLi9Tonc74vOLrYTEKdAGXPNtC6WCfhv+Aa9wslGvgEeu2M1PMPSOT7TRR8
	 ojLKjYbaRHNb6Fz9s3YxZ33QGdHLN8bVtP6brk4uyt/6M4H3wGdD5u0PGJmTV2NuDp
	 KUyjmkkhCyUWP51zHAD4OEYBwnaWqkoVMzxDcldb03U7u3hVmd1PprgTsnd0MFG3b8
	 +PQo3/r0AUIpcm03ULoZdoTRm0YrgLzN8+9G5MyjJfp1NYz6lXNoPY75Fvn+lpow3S
	 ZLSSw8ix4beJ54RsHG8DOxSWm/8x4cb84Hfj1CBp8nf1yGxqpuZQmQkRltDNcjjNy2
	 GO86iKC6ICh2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4glYFG0Dbsz4w2B;
	Wed, 24 Jun 2026 17:18:26 +1000 (AEST)
Message-ID: <2847c36f-aba7-4458-8767-7617e13058bf@ellerman.id.au>
Date: Wed, 24 Jun 2026 17:18:25 +1000
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Demote myself to reviewer
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <87y0hspx0u.fsf@mpe.ellerman.id.au>
 <7bpasqtq.ritesh.list@gmail.com>
Content-Language: en-US
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <7bpasqtq.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 11:00 am, Ritesh Harjani (IBM) wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>    
>>   LINUX FOR POWERPC (32-BIT AND 64-BIT)
>>   M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>> -M:	Michael Ellerman <mpe@ellerman.id.au>
> 
> Thanks for more than a decade of maintainership of Linux on PowerPC tree
> :)

Thanks Ritesh.

Maddy can you pick this one up please :)

cheers


Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D188DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 12:56:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6458610A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 12:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6458610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQBC91mKvz3bhd
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 23:56:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VEpEllcL;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQBBR1nqGz2ynG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2021 23:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VEpEllcL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQBBQ5PQdz4xbR;
 Thu,  7 Oct 2021 23:55:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1633611327;
 bh=Y0KQwZsDfOdTg3GKHjg+c55QXVx0McJy0Ytp18M8szA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VEpEllcLwgz2G4MZA7I2RQmq2EXfGMtV2HQq4pqI8wAzGRZcL9maiLMmTv/UcjLtq
 ukJ9T/0IuIoUMHyCcWAbHxF16I1MJRPjqV1QaCCS1MEw6qnEr7O0Mgj8EHBsQYf9yY
 9PcsQniqwDS7oMUu42H/vDSUwnhyVj2Z5+/2W+/k9Ypk3cIusigGPt6Kw7hVA5IaJa
 YnMeUIZMSk2hALgXA2WykJ5mOuG4sEjUD+/6GVU+mTQaOTmYBkKjsBAZegibQ/pvKz
 RlbaFb20Ka0d4XuYWY3Eq4V8vaxxOBM3gHraOnVkS0DZWpgqQFpzYriYoSIjQpjS6Q
 QY9V8LlCGJbiw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Kai Song <songkai01@inspur.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh:Fix some mistakes in comments
In-Reply-To: <878rze60by.fsf@dja-thinkpad.axtens.net>
References: <20210927023507.32564-1-songkai01@inspur.com>
 <878rze60by.fsf@dja-thinkpad.axtens.net>
Date: Thu, 07 Oct 2021 23:55:23 +1100
Message-ID: <87ee8xngec.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: paulus@samba.org, Kai Song <songkai01@inspur.com>, oohall@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Hi Kai,
>
> Thank you for your contribution to the powerpc kernel!
>
>> Get rid of warning:
>> arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead
>
> You haven't said where this warning is from. I thought it might be from
> sparse but I couldn't seem to reproduce it - is my version of sparse too
> old or are you using a different tool?
>
>>  /**
>> - * eeh_set_pe_freset - Check the required reset for the indicated device
>> - * @data: EEH device
>> + * eeh_set_dev_freset - Check the required reset for the indicated device
>> + * @edev: EEH device
>>   * @flag: return value
>>   *
>>   * Each device might have its preferred reset type: fundamental or
>
> This looks like a good and correct change.
>
> I checked through git history with git blame to see when the function
> was renamed. There are 2 commits that should have updated the comment:
> one renamed the function and one renamed an argument. So, I think this
> commit could have:
>
> Fixes: d6c4932fbf24 ("powerpc/eeh: Strengthen types of eeh traversal functions")
> Fixes: c270a24c59bd ("powerpc/eeh: Do reset based on PE")
>
> But I don't know if an out of date comment is enough of a 'bug' to
> justify a Fixes: tag? (mpe, I'm sure I've asked this before, sorry!)

It depends. If you think it's important that the fix gets backported
then you should add the Fixes tag.

In this case I would say no. The comments have been broken for years,
and it's a pretty obscure API.

cheers

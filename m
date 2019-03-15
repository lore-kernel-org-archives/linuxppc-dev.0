Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A61C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 04:26:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4902186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 04:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="oaHYdJGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4902186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LCFR0hJdzDqRd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 15:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="oaHYdJGb"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LCCf4v1xzDqQv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 15:24:44 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id u9so5494121pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Ns2BikTimGEvj26ADZRD9DW1O6qtk4kZmoPLUHoIyE8=;
 b=oaHYdJGbcL/e5pFQGi/YqJlyopqeZK7aSPQAPEMJM7FGBwodkFNIlkwbrJ7kIS70+H
 8Q8EmNLObLC3/UtRMMPH33vGtKLItzUntzBXhpzItUxouC6Lx0HqI7puROd7wctSktnT
 bGKOb/COx0Aq2mbBiLGwfl0NmrX7Jv3vWRjt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ns2BikTimGEvj26ADZRD9DW1O6qtk4kZmoPLUHoIyE8=;
 b=WiCO8XTc/VCw4XG7INmzb9H5yZiOdagqpietC9ci31r12RzuJwLVvYSEMFAlG0MDj7
 pjHH4UsZC1jD3hgRlR0MSrYgtEqFrLMijvSDfjIdf2NuzCoPsdlQsxJjyvqWvCr04Be2
 lEZfmPJgAZKO+VqH3AwOd38KiqIjlB3fl1vJCNpMAMxpSEfLAMExHovdDeDsbtqcfb8s
 2TND0FsAkAbCIdSZ7WHcbXa05JwvVYDYCjdM7GlJUnn/wi8siKaK3eS+m/Fw0FkDKSOU
 s5yIdtHt4qqtmHhWNL/8GQS2jcAx+A3AAZgiSczLzmmx92lZXaX0TuhUZCmTtt8OYyri
 CG0w==
X-Gm-Message-State: APjAAAXqLlvwPzuXSnzfaWU+MsFEFDUwP7y90L1fq05G9WhbW+VZ8o8E
 xTb3lawJPN4a1S8kbXCTnxujHg==
X-Google-Smtp-Source: APXvYqwWbnwSChy35tVzJGS+KlwlLNOVfU1P3UPtX/FUYAXf29sStZ4Wm0ZVcPhIMh4WqpnwXcQKBQ==
X-Received: by 2002:a17:902:2a89:: with SMTP id
 j9mr1385525plb.272.1552623880527; 
 Thu, 14 Mar 2019 21:24:40 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id z6sm1323087pgo.31.2019.03.14.21.24.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Mar 2019 21:24:39 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
In-Reply-To: <20190315022414.GA1671@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
 <20190315022414.GA1671@sol.localdomain>
Date: Fri, 15 Mar 2019 15:24:35 +1100
Message-ID: <875zsku5mk.fsf@dja-thinkpad.axtens.net>
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
Cc: leo.barbosa@canonical.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, nayna@linux.ibm.com,
 omosnacek@gmail.com, leitao@debian.org, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Eric,

>> The original assembly imported from OpenSSL has two copy-paste
>> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
>> the code branches to the CBC decryption exit path, rather than to
>> the CTR exit path.
>
> So does this need to be fixed in OpenSSL too?

Yes, I'm getting in touch with some people internally (at IBM) about
doing that.

>> This leads to corruption of the IV, which leads to subsequent blocks
>> being corrupted.
>>=20
>> This can be detected with libkcapi test suite, which is available at
>> https://github.com/smuellerDD/libkcapi
>>=20
>
> Is this also detected by the kernel's crypto self-tests, and if not why n=
ot?
> What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy?

It seems the self-tests do not catch it. To catch it, there has to be a
test where the blkcipher_walk creates a walk.nbytes such that
[(the number of AES blocks) mod 8] is either 2 or 3. This happens with
AF_ALG pretty frequently, but when I booted with self-tests it only hit
1, 4, 5, 6 and 7 - it missed 0, 2 and 3.

I don't have the EXTRA_TESTS option - I'm testing with 5.0-rc6. Is it in
-next?

Regards,
Daniel

>> Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
>> Fixes: 5c380d623ed3 ("crypto: vmx - Add support for VMS instructions by =
ASM")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  drivers/crypto/vmx/aesp8-ppc.pl | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-=
ppc.pl
>> index d6a9f63d65ba..de78282b8f44 100644
>> --- a/drivers/crypto/vmx/aesp8-ppc.pl
>> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
>> @@ -1854,7 +1854,7 @@ Lctr32_enc8x_three:
>>  	stvx_u		$out1,$x10,$out
>>  	stvx_u		$out2,$x20,$out
>>  	addi		$out,$out,0x30
>> -	b		Lcbc_dec8x_done
>> +	b		Lctr32_enc8x_done
>>=20=20
>>  .align	5
>>  Lctr32_enc8x_two:
>> @@ -1866,7 +1866,7 @@ Lctr32_enc8x_two:
>>  	stvx_u		$out0,$x00,$out
>>  	stvx_u		$out1,$x10,$out
>>  	addi		$out,$out,0x20
>> -	b		Lcbc_dec8x_done
>> +	b		Lctr32_enc8x_done
>>=20=20
>>  .align	5
>>  Lctr32_enc8x_one:
>> --=20
>> 2.19.1
>>=20

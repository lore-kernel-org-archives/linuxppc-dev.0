Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EEC43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 10:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411322073B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgwKo+0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411322073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tx1C5rm9zDr7j
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 21:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QgwKo+0V; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48twys2P0KzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 21:24:21 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id c138so3300170pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2020 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=gCqmwPFp7TY2eTdjr+ZUyIz1Ip6AqqBAjlv6bgc9/UY=;
 b=QgwKo+0VIY66oLh8sGuPN2RDQzXjwUZjjnlUYdSdaGr1VFYOq++9R7O7DsaaCzqQLv
 rceuNf3zM4jUOpPbItB6GPRbOH7qWUl61glnetpfSgvPyyzPw8iOf91yjbzRLFYmxIyd
 8qPsbq+orgghqRw7zPac4CJJXvyKXmUtE2ePUW+kIvHrQ7gCp8KPGK/yP4zOFraWD+YT
 HqKM4jLlzVK4z6cibSkTLymWfhBhIawohJfuAd3Sy4QA//2ke813n/D9wHmB+5l9sKtK
 oEEfR4fek8lrLe8SaIBBMU52RTN0z32vonA6zjVcXWbfPlqqS6fFg7bc6iVqSrBlsPcD
 iXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=gCqmwPFp7TY2eTdjr+ZUyIz1Ip6AqqBAjlv6bgc9/UY=;
 b=F7r/fDadDjWVZ7BoZJ6SngSblkVsSTwOFuhMkVjH2IklDGeVoZ5VoF8xlZVqQdcQ6+
 74NK+4CJawbAggrbTCqQS05yqLZny0x44eqd1NYll0JQkTuGWOmzVPFc1PLU3YaIHGR2
 W4w0JKhYm28pizhu6395ihiig6zLnkscmr5SCqC4QzR7oLnWS+gsRcZa5xeprnVtGqgH
 aCIIAuOEIzPncify/P74DpC+rHyZyvO3ei425wvnVaLIV7Y3lPTvxqp4MehdSlqKMLwn
 8vduJcer4oGSZ4m58MBuZCTBQTQ3ckmd3qaSxYvQhR9dSpq2gaBnpeKroNg9lhmr7hze
 TKiw==
X-Gm-Message-State: AGi0PuYCSSvExvFOJ1oxXFd2qdiAic7jQh8bR9PqQ9eJVy02q5ZK9sI4
 09DUetjzHbxv7zfv9d4q5Rg=
X-Google-Smtp-Source: APiQypJWJgFcV1aX1u5XsQ8jpl0z/rKhN3QKdgCLj3By2rILYlxyFwUK+UQvbOgo0jP6TBzhrm/rlA==
X-Received: by 2002:a63:741b:: with SMTP id p27mr7541277pgc.68.1585909457724; 
 Fri, 03 Apr 2020 03:24:17 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id g9sm4952996pgc.46.2020.04.03.03.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 03:24:16 -0700 (PDT)
Date: Fri, 03 Apr 2020 20:24:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 08/12] powerpc/pseries: limit machine check stack to 4GB
To: mahesh@linux.ibm.com
References: <20200325103410.157573-1-npiggin@gmail.com>
 <20200325103410.157573-9-npiggin@gmail.com>
 <20200327052430.r3id43ptr6ffwtoq@in.ibm.com>
In-Reply-To: <20200327052430.r3id43ptr6ffwtoq@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585909432.bgv5oyxscc.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh J Salgaonkar's on March 27, 2020 3:24 pm:
> On 2020-03-25 20:34:06 Wed, Nicholas Piggin wrote:
>> This allows rtas_args to be put on the machine check stack, which
>> avoids a lot of complications with re-entrancy deadlocks.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/kernel/setup_64.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_=
64.c
>> index 3bf03666ee09..ca1041f8a578 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -695,6 +695,9 @@ void __init exc_lvl_early_init(void)
>>  void __init emergency_stack_init(void)
>>  {
>>  	u64 limit;
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +	u64 mce_limit;
>> +#endif
>>  	unsigned int i;
>>=20
>>  	/*
>> @@ -713,6 +716,16 @@ void __init emergency_stack_init(void)
>>  	 */
>>  	limit =3D min(ppc64_bolted_size(), ppc64_rma_size);
>>=20
>> +	/*
>> +	 * Machine check on pseries calls rtas, but can't use the static
>> +	 * rtas_args due to a machine check hitting while the lock is held.
>> +	 * rtas args have to be under 4GB, so the machine check stack is
>> +	 * limited to 4GB so args can be put on stack.
>> +	 */
>> +	mce_limit =3D limit;
>> +	if (firmware_has_feature(FW_FEATURE_LPAR) && mce_limit > 4UL*1024*1024=
*1024)
>> +		mce_limit =3D 4UL*1024*1024*1024;
>> +
>=20
> Don't you need this as well under CONFIG_PPC_BOOK3S_64 #ifdef ??

Good catch.

Thanks,
Nick
=

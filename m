Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA253C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 06:45:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4F16140F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 06:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4F16140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQB0329m9z30Fd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 16:45:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CXsOrqeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=CXsOrqeq; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQ9zV4Sdcz2y07
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 16:45:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=TaoSe12bv0Z+SOinmTPXdVDvb5/DyJ+MESlhaD7JqAQ=; b=CXsOrqeqyohCN/Vb+BFVIULxX4
 eyd3+Xqq/s4sm/+Yes92DAqLt8X960ajdeGjhxYsEJ4iItaJbKeQvdxonr/eKwSCxujhVKbS2qE1v
 jJ3CSXCYOlFj1HBPwzz1url9l2/fZKZWFxMvW7XuOufTtaLgqQwLf2UaW2GFoIZ/FMoBeaTXPJ+BB
 qfVjNs1vMdE5h+gbFhXlPrj7zgMx5cFD/zIawSgaovtqP0xuzl4bjFc1zwHg3RDewM3iC2780erkc
 0i7d9TjK8PQiWSTGNHjjXIseNFWAnvdGzQtlBTmC2WGdtcwSyff/ha1SY+YkWOY67M9Y2mOO9ADe7
 pUZijA+w==;
Received: from [2601:1c0:6280:3f0::df68]
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ6by-00DqKi-Ku; Wed, 21 Apr 2021 06:45:23 +0000
Subject: Re: powerpc{32,64} randconfigs
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <45afab41-cc5f-dffa-712a-d5fb1a9d0a23@infradead.org>
 <21339633-16cb-c2ec-1517-2f5c4897fba1@csgroup.eu>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c973768b-8fe5-a5a4-ccfc-ebc109b6eb80@infradead.org>
Date: Tue, 20 Apr 2021 23:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <21339633-16cb-c2ec-1517-2f5c4897fba1@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/20/21 11:37 PM, Christophe Leroy wrote:
> 
> 
> Le 21/04/2021 à 01:31, Randy Dunlap a écrit :
>> --- linux-next-20210420.orig/arch/powerpc/kernel/vdso64/Makefile
>> +++ linux-next-20210420/arch/powerpc/kernel/vdso64/Makefile
>> @@ -30,7 +30,7 @@ ccflags-y := -shared -fno-common -fno-bu
>>   asflags-y := -D__VDSO64__ -s
>>     targets += vdso64.lds
>> -CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
>> +CPPFLAGS_vdso64.lds += -P -C -U$(SRCARCH)
> 
> Maybe it would be better to do -Upowerpc like in VDSO32
> 

OK, thanks for getting that done. :)

>>     # link rule for the .so file, .lds has to be first
>>   $(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
>> --- linux-next-20210420.orig/arch/powerpc/Makefile


-- 
~Randy


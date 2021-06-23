Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFFC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 00:39:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721166135A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 00:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721166135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8ksr6Rnzz3bvK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 10:39:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GCxZly7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GCxZly7u; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8ksJ4Gzyz2yXb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 10:38:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G8ksD5N27z9sS8;
 Wed, 23 Jun 2021 10:38:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1624408720;
 bh=JMomvG3n+cMFfx5sY/Bh8Fd1ZZWhqF7CfXvPRIz/GhA=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=GCxZly7udiJseSrEN1xzFOx6+/wSnqo3wrM3J2w2IQw3kDlIijoJNS8365gE4vmpq
 lD2mSo2jQ0GolCqx1Ny8Gke+UkeQ1EnZL0c/ooTBFRMlYGIIDNI//Gw9h8tYb16XKI
 5+W13xKV3hZJjUD2K/wWorepRTAVSJKtBu3xPkiLguTmu0gWpGI/gFB8kvWRDfq217
 eRloSN4yD8K7R1NbG0aT3SP1+HSLUL84rnAXjWjcCi5HwBLuzvGmCjOpppu/M8CsUq
 St945mKkIF2qHyZsA4JgMvm3BhHA+K0l3zpqz24YarAikH3AjTPttg5Jyjt4fQre/L
 xXMcwNy9MPXtA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/prom_init: Pass linux_banner to firmware
 via option vector 7
In-Reply-To: <bead9552-1e5c-2485-0463-4d161cce2a1f@linux.ibm.com>
References: <20210621064938.2021419-1-mpe@ellerman.id.au>
 <20210621064938.2021419-2-mpe@ellerman.id.au>
 <bead9552-1e5c-2485-0463-4d161cce2a1f@linux.ibm.com>
Date: Wed, 23 Jun 2021 10:38:38 +1000
Message-ID: <87y2b11kkx.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 6/20/21 11:49 PM, Michael Ellerman wrote:
>> Pass the value of linux_banner to firmware via option vector 7.
>> 
>> Option vector 7 is described in "LoPAR" Linux on Power Architecture
>> Reference v2.9, in table B.7 on page 824:
>> 
>>   An ASCII character formatted null terminated string that describes
>>   the client operating system. The string shall be human readable and
>>   may be displayed on the console.
>> 
>> The string can be up to 256 bytes total, including the nul terminator.
>> 
>> linux_banner contains lots of information, and should make it possible
>> to identify the exact kernel version that is running:
>> 
>>   const char linux_banner[] =
>>   "Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>>   LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
>> 
>> For example:
>>   Linux version 4.15.0-144-generic (buildd@bos02-ppc64el-018) (gcc
>>   version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #148-Ubuntu SMP Sat May 8
>>   02:32:13 UTC 2021 (Ubuntu 4.15.0-144.148-generic 4.15.18)
>> 
>> It's also printed at boot to the console/dmesg, which should make it
>> possible to correlate what firmware receives with the console/dmesg on
>> the machine.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>> 
>> NB. linux_banner is already allowed by prom_init_check.sh
>> 
>> LoPAR: https://openpowerfoundation.org/?resource_lib=linux-on-power-architecture-reference-a-papr-linux-subset-review-draft
>> ---
>>  arch/powerpc/kernel/prom_init.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
>> index c18d55f8b951..7343076b261c 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
...
>> @@ -1340,6 +1351,10 @@ static void __init prom_check_platform_support(void)
>>  	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
>>  	       sizeof(ibm_architecture_vec));
>> 
>> +	prom_strscpy_pad(ibm_architecture_vec.vec7.os_id, linux_banner, 256);
>> +	// Ensure nul termination
>> +	ibm_architecture_vec.vec7.os_id[255] = '\0';
>> +
>
> Doesn't the implementation of prom_strscpy_pad() in patch 1 ensure nul termination?

Yes! I was originally using strncpy(), but forgot to drop this when I
switched to strscpy_pad(). I dropped it when applying.

Thanks for reviewing.

cheers

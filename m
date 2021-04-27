Return-Path: <SRS0=wyLB=JY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C501C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 23:46:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59924613CE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 23:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59924613CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVJLN5Jbfz304C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 09:46:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=lpzhV1ii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=lpzhV1ii; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVJKq4Zpnz2xZt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Apr 2021 09:45:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=bjHYw5aHmkNeX7gCuVfcrHLOJEpKEgOqk23ARRx2OIw=; b=lpzhV1iinBNfc/QWyDj7fkDa1p
 ExQn3Q+M+DYUJm4WQs3yrh5BTfsf3tsib18tYLL9Ly3qzGG4oS127rl3hUI4KgO8Ncr45M7lARMFo
 LeAi1BGMR8I0Bf58pq8QBaGhsCVoMjcFPxtDLDp6jUrdWIaz7KE1RgipadXuJIgl/47ZvuV+yTAi8
 zOhhSB7IyldyPjiB2qwj1Svy23YKP07RQ1YxEKp8BzWmktZe3kpUlkesJkBUuYK7LtyPOx1UqstdU
 NJFUrUTuNbGL/t7UAex++7iE0XV/t/qvrxZVYwzszRfNKNs+Hvr0FWMbCG+N9ERNkKvrGKqvt7CWe
 rBRC6vAQ==;
Received: from [2601:1c0:6280:3f0::df68]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXOL-007c8l-JX; Tue, 27 Apr 2021 23:45:26 +0000
Subject: Re: powerpc{32,64} randconfigs
To: Michael Ellerman <mpe@ellerman.id.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <45afab41-cc5f-dffa-712a-d5fb1a9d0a23@infradead.org>
 <87tuo0az16.fsf@mpe.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4514b768-ef07-0b01-c87e-4c2d9eb95f65@infradead.org>
Date: Tue, 27 Apr 2021 16:45:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87tuo0az16.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 4/21/21 12:15 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> Hi,
>>
>> Is there a way to do this?
>>
>> $ make ARCH=powerpc randconfig # and force PPC32
> 
> Sort of:
> 
> $ KCONFIG_ALLCONFIG=arch/powerpc/configs/book3s_32.config make randconfig
> 
> But that also forces BOOK3S.
> 
>> and separately
>> $ make ARCH=powerpc randconfig # and force PPC64
> 
> No.
> 
> ...
>> OK, I have a patch that seems for work as far as setting
>> PPC32=y or PPC64=y... but it has a problem during linking
>> of vmlinux:
>>
>> crosstool/gcc-9.3.0-nolibc/powerpc-linux/bin/powerpc-linux-ld:./arch/powerpc/kernel/vmlinux.lds:6: syntax error
>>
>> and the (bad) generated vmlinux.lds file says (at line 6):
>>
>> OUTPUT_ARCH(1:common)
>>
>> while it should say:
>>
>> OUTPUT_ARCH(powerpc:common)
>>
>> Does anyone have any ideas about this problem?
> 
> I guess your patch broke something? :D
> Not sure sorry.
> 
> What about something like this?
> 
> cheers
> 
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 3212d076ac6a..712c5e8768ce 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -376,6 +376,16 @@ PHONY += ppc64_book3e_allmodconfig
>  	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
>  		-f $(srctree)/Makefile allmodconfig
>  
> +PHONY += ppc32_randconfig
> +ppc32_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/32-bit.config \
> +		-f $(srctree)/Makefile randconfig
> +
> +PHONY += ppc64_randconfig
> +ppc64_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/64-bit.config \
> +		-f $(srctree)/Makefile randconfig
> +
>  define archhelp
>    @echo '* zImage          - Build default images selected by kernel config'
>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> diff --git a/arch/powerpc/configs/32-bit.config b/arch/powerpc/configs/32-bit.config
> new file mode 100644
> index 000000000000..bdf833009006
> --- /dev/null
> +++ b/arch/powerpc/configs/32-bit.config
> @@ -0,0 +1 @@
> +CONFIG_PPC64=n

I used the suggested change here (above).

> diff --git a/arch/powerpc/configs/64-bit.config b/arch/powerpc/configs/64-bit.config
> new file mode 100644
> index 000000000000..0fe6406929e2
> --- /dev/null
> +++ b/arch/powerpc/configs/64-bit.config
> @@ -0,0 +1 @@
> +CONFIG_PPC64=y
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Please merge this. :)

thanks.
-- 
~Randy


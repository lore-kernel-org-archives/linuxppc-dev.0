Return-Path: <SRS0=8srP=EU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE39C5519F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2020 04:18:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B7E22268
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2020 04:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="PF9ft6fM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B7E22268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CY2Bb1CLJzDqhH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2020 15:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=PF9ft6fM; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CY28m71cgzDr7V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2020 15:16:40 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 62so8661706pgg.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2020 20:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A9pg18TbAKGWThbDZV/lSnw6ECunYCQj34w2OxbsD28=;
 b=PF9ft6fMnlNP/6Zsbu25kflNnmBKfJOO/H4rjrJ+ql33V44LVFpAQuQmFtilVhoNGy
 Y9ZrE3vibDv+WkakZbF/0ztWkgwwMeb61WAEri4qAVRQx9t+j+QtLF3SwSbU92l005We
 sDSN4NvszMB3KMpUcgrPvhc81wtKtX7FQllX/xYsrejaiM2AiGmJFBU5MuS1Mqpgoy9/
 WuBtiYmAeihC5b5j2t+sfKl50CluaCCsjKzYiOPXOz/p3MjL4IctEhyHyX/DbOlO45wl
 xj0iaBbrOfI0gI4BiCwzg5d3EgRXQ79eVt3vzi2h9kdepcB6fZFSPQ/Y6SyUS+NB3shM
 djsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A9pg18TbAKGWThbDZV/lSnw6ECunYCQj34w2OxbsD28=;
 b=Au5kACBnkjnZuR+6kEMTgfzzN1xMflGnj7PcXLYsmHe7sQ+FEHJvsCWa9ejRCcw8Lg
 nWf4SzAEzt3m/mp+TsdIDtUpej9YgPV0wSeo8TZIi6lnjusvithUHj1PcODBeaTGVnBF
 AksrEzcYj/FZDDRbp7wCZ1QBdb2vtUWa3gkWdyOiAYpSwb9bmEDth6iN0sgLa+rjYV+J
 LNU2RFcmYBiK7gdWxXsdMSReCIsLJKZNZEas6H8TDxL+jGjShdHMqIYKuLphGgHPmdAs
 2LEpeDpqqsnpLJRhM2DlSH1PTZxR9+BYKr3n9y68UvvpN5DPvQ9ai7Eh1NIaBN/EXQ2e
 GpiQ==
X-Gm-Message-State: AOAM531/V2ISXryGC2koa3BKbfl91faTDy8UIF0Njo1s3bjoQTe0jnZk
 +LnHTzy2rHyEtOe7LpfqTJYPrw==
X-Google-Smtp-Source: ABdhPJxdtnYpfXnid7lmGwIEALBV3sGEAC/R8OHL5K5BnBiuttodEwRQNcVdi17epQTlF0c/PWefpw==
X-Received: by 2002:a62:768e:0:b029:18a:d54d:3921 with SMTP id
 r136-20020a62768e0000b029018ad54d3921mr4922461pfc.31.1605327396070; 
 Fri, 13 Nov 2020 20:16:36 -0800 (PST)
Received: from [192.168.10.85] (124-171-134-245.dyn.iinet.net.au.
 [124.171.134.245])
 by smtp.gmail.com with UTF8SMTPSA id 3sm11338509pfv.92.2020.11.13.20.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 20:16:35 -0800 (PST)
Subject: Re: [PATCH kernel] vfio_pci_nvlink2: Do not attempt NPU2 setup on old
 P8's NPU
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20201113050632.74124-1-aik@ozlabs.ru>
 <0b8ceab2-e304-809f-be3c-512b28b25852@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1f2be6b0-d53a-aa58-9c4f-d55a6a5b1c79@ozlabs.ru>
Date: Sat, 14 Nov 2020 15:16:30 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <0b8ceab2-e304-809f-be3c-512b28b25852@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Leonardo Augusto Guimaraes Garcia <lagarcia@br.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 13/11/2020 16:30, Andrew Donnellan wrote:
> On 13/11/20 4:06 pm, Alexey Kardashevskiy wrote:
>> We execute certain NPU2 setup code (such as mapping an LPID to a device
>> in NPU2) unconditionally if an Nvlink bridge is detected. However this
>> cannot succeed on P8+ machines as the init helpers return an error other
>> than ENODEV which means the device is there is and setup failed so
>> vfio_pci_enable() fails and pass through is not possible.
>>
>> This changes the two NPU2 related init helpers to return -ENODEV if
>> there is no "memory-region" device tree property as this is
>> the distinction between NPU and NPU2.
>>
>> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] 
>> subdriver")
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Should this be Cc: stable?

This depends on whether P8+ + NVLink was ever a  product (hi Leonardo) 
and had actual customers who still rely on upstream kernels to work as 
after many years only the last week I heard form some Redhat test 
engineer that it does not work. May be cc: stable...


-- 
Alexey

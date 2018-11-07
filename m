Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B7C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA4A20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwBlWuhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA4A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qqRB4N94zF3Jm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 02:03:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwBlWuhu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwBlWuhu"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qqLW6xrWzF3JH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 01:58:59 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id q5-v6so7432761pgv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=od9qZ/u5DMHeveh8MRZfHbr5BBNuRmqZVRi36J9gC7M=;
 b=mwBlWuhuVV4OEqMdCiTCZGTq8R6w85WZJC3puF8AB9KVZcrb21AItbT1kH5FL1YNTa
 gueduavt2Ar4pmDxu59eVDmqvvavL6bxmcOCTUX9jHzV1KzwnChlAxq3+nVugH0OTXAK
 up62uhSe51SIF9x8UE6426RzRmqoarNVyt0nNc5fodIbrDMo1nHojSxBC6ZzE6LDlJf7
 +DIR3FzYOgcZnDR9zUWHH3AHbMlPSX0zrcyIc74mMC5Osa+Ko2TBKgTKCjvAcrllCR09
 d4E97Z4xUT3UUFG7ib6aPLH2hogy6+2LedTw7CTAt7uxiF8O2hDw+3p0gHS8O5xYqiGg
 CIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=od9qZ/u5DMHeveh8MRZfHbr5BBNuRmqZVRi36J9gC7M=;
 b=PE15xzx5lbjjBeiTnhJUTYUeRZuzyt9TE1zpJWCMqguNLkAic7FvjFNsz6xXeMoRD7
 gRNl9dh0bYVyfm6Ut12BkcKJtq6aGc7O0aIxTgQGWb/7i4bki/UAiH1cpW7e63qRO0Ad
 NvhxXEzRJ7Ut6gKcFgVMr/9FjRXtVjjh9vw1oT2mPmLtZQlRoiDbDP3yN+8xtDOV4vJ4
 U1a1YQOzWx1EaQ7g4SK3rutnyyGb0MMJArzsL2hOyVomhprgJfDFaZmHowyQTR9B+r58
 byIVCpaz82UQc0qIfO/HZdfcNPM99q1gHPzy+d9K8SfAzIfopU/2zoPgzBF860pUqhV0
 Eatw==
X-Gm-Message-State: AGRZ1gL9rDEjeUcRl9SDR2Fm9yVIYxfvADZGz72XUnB/7opoOJNGx2Dt
 thiDQYUOhtLFZBp4AXzqyWQ=
X-Google-Smtp-Source: AJdET5eybj016H4i7jCX1MaaScdtaAhLZVgIKPMJaEFr+lTE2129ISBBIRoMTsi6f14WihoFLRVr1w==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr556795pfm.18.1541602738039; 
 Wed, 07 Nov 2018 06:58:58 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id q76-v6sm1155163pfa.18.2018.11.07.06.58.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Nov 2018 06:58:57 -0800 (PST)
Subject: Re: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
 <87muqlqdog.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ea4d4314-a7e8-f4cd-f9e0-15fedcd3510f@gmail.com>
Date: Wed, 7 Nov 2018 06:58:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87muqlqdog.fsf@concordia.ellerman.id.au>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/7/18 4:23 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> 
> It would be clearer if you said 'The previous commit "of: overlay ..."

Will fix.


>> added a missing of_node_get() to __of_attach_node_sysfs().  This
>> results in a refcount imbalance for nodes attached with
>> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
>> to __of_attach_node_sysfs() is:
>>
>>    dlpar_attach_node()
>>       of_attach_node()
>>          __of_attach_node_sysfs()
>>
>> Tested-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> ***** UNTESTED.  I need people with the affected PowerPC systems
>> *****            (systems that dynamically allocate and deallocate
>> *****            devicetree nodes) to test this patch.
> 
> This looks OK to me in light of the previous patch.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> It also means dlpar_detach_node() is again behaving as described in the
> comment to of_detach_node().
> 
> It would be good to make mention of:
> 
>   Fixes: 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow during DLPAR remove")
> 
> Which removed an of_node_put() in the exact same place for different
> reasons.

OK.

-Frank

> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index 7625546caefd..17958043e7f7 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
>>  	if (rc)
>>  		return rc;
>>  
>> +	of_node_put(dn);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
> 


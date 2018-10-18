Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD7C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:07:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390B420658
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmOmbQ1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390B420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bdnv20RGzF3FW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:06:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmOmbQ1D";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmOmbQ1D"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bdhj728yzF36F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 06:02:29 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id l17-v6so15308917pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7Zuyi2L6RFcg8t6RIwhB1Ct3UzeFe1haCtGu9hCmFEI=;
 b=lmOmbQ1D5MH7rtrW5vBLYiRemArOAiWw3Ki2nyDAU+xnz/g3qLlq071DxMhl7DkOFO
 YmrvpsEBTAYBtuPmf8DRt36lKO8NDwv7TIYBNj7WxPz+P+m/SxyvNvbvSp/hrmLgvtnt
 sQD8JXiWQQ1PpaWdhkGGkczdmMwYerfR8drv3o8pdXdvJvuk7mKXEqSbl4cb03WTD9O0
 1hUaxlTx44NoUeejMH94dKQ9fzSNgSs7ZC/KibKa9QxP/AukD1M1G+xzOEYRYT2x0Npm
 Vr0MbaSbzmJg5rCX54M18u51Vl+uZLC9Itx+2U9+eQy3JDYLCBwm8y8g8lFvMM+kPfQa
 0XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Zuyi2L6RFcg8t6RIwhB1Ct3UzeFe1haCtGu9hCmFEI=;
 b=dDZO2TAnaO9u+g7BrVOq6U9tamx1HWpeFlXdOXq9jALqBsm0YKx5m0LKI4ccDzbOpE
 mkE88PxhApPsWMLPuXUYUbYQlkHGuMumOpeJae6LqvfmGwlK1MaHwrsSS1tqpoTMXlqF
 2HjFjIqkJzfmQnH1pv4ZJ3Qfucr5vQmdTlCO2apQJW5LsoeZ8VUu+zba9E5aL7qpZuHT
 8mvhv4zqNsioVXjJGxQaioSnipcxxrzazif3FuBXQZrNCQb7k3QjUBtyTWmRshvaNhxL
 MllYYrYnXdwgUKXF4hVC/eUiKkUmQGF0r622lNLzlzA7K4Zkj+xSBppR6aAJBLADiKZR
 g5Rg==
X-Gm-Message-State: ABuFfogEGwBi4hoMld77EHve4hme6VFAoQrHtrv8y+5SW5X6P9z4pzZh
 1eXx/1wambVy8SyzZ1nmAsU=
X-Google-Smtp-Source: ACcGV63+Lg4FYVEQJ+FK6PprYbQQR2FYDH3VT1J35E00sE/WoYgUfrVyqqtUeNUIut+PFuH5moi/2w==
X-Received: by 2002:a62:509a:: with SMTP id
 g26-v6mr31331087pfj.62.1539889348097; 
 Thu, 18 Oct 2018 12:02:28 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id m20-v6sm21901819pgv.93.2018.10.18.12.02.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 12:02:27 -0700 (PDT)
Subject: Re: [PATCH v4 02/18] of: overlay: add missing of_node_put() after add
 new node to changeset
To: Rob Herring <robh@kernel.org>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-3-git-send-email-frowand.list@gmail.com>
 <20181018170502.GB15557@bogus>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <02a879fb-49b1-62b8-275c-d5ae6ccacecb@gmail.com>
Date: Thu, 18 Oct 2018 12:02:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018170502.GB15557@bogus>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/18/18 10:05, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:22PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The refcount of a newly added overlay node decrements to one
>> (instead of zero) when the overlay changeset is destroyed.  This
>> change will cause the final decrement be to zero.
>>
>> After applying this patch, new validation warnings will be
>> reported from the devicetree unittest during boot due to
>> a pre-existing devicetree bug.  The warnings will be similar to:
>>
>>   OF: ERROR: memory leak of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest4 before free overlay changeset
> 
> Same comment on formatting.

OK.


>>
>> This pre-existing devicetree bug will also trigger a WARN_ONCE() from
>> refcount_sub_and_test_checked() when an overlay changeset is
>> destroyed without having first been applied.  This scenario occurs
>> when an error in the overlay is detected during the overlay changeset
>> creation:
>>
>>   WARNING: CPU: 0 PID: 1 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa8/0xbc
>>   refcount_t: underflow; use-after-free.
>>
>>   (unwind_backtrace) from (show_stack+0x10/0x14)
>>   (show_stack) from (dump_stack+0x6c/0x8c)
>>   (dump_stack) from (__warn+0xdc/0x104)
>>   (__warn) from (warn_slowpath_fmt+0x44/0x6c)
>>   (warn_slowpath_fmt) from (refcount_sub_and_test_checked+0xa8/0xbc)
>>   (refcount_sub_and_test_checked) from (kobject_put+0x24/0x208)
>>   (kobject_put) from (of_changeset_destroy+0x2c/0xb4)
>>   (of_changeset_destroy) from (free_overlay_changeset+0x1c/0x9c)
>>   (free_overlay_changeset) from (of_overlay_remove+0x284/0x2cc)
>>   (of_overlay_remove) from (of_unittest_apply_revert_overlay_check.constprop.4+0xf8/0x1e8)
>>   (of_unittest_apply_revert_overlay_check.constprop.4) from (of_unittest_overlay+0x960/0xed8)
>>   (of_unittest_overlay) from (of_unittest+0x1cc4/0x2138)
>>   (of_unittest) from (do_one_initcall+0x4c/0x28c)
>>   (do_one_initcall) from (kernel_init_freeable+0x29c/0x378)
>>   (kernel_init_freeable) from (kernel_init+0x8/0x110)
>>   (kernel_init) from (ret_from_fork+0x14/0x2c)
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 1176cb4b6e4e..32cfee68f2e3 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -379,7 +379,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>>  		if (ret)
>>  			return ret;
>>  
>> -		return build_changeset_next_level(ovcs, tchild, node);
>> +		ret = build_changeset_next_level(ovcs, tchild, node);
>> +		of_node_put(tchild);
>> +		return ret;
>>  	}
>>  
>>  	if (node->phandle && tchild->phandle)
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
>>
> 


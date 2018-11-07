Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:58:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3CD20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4HZOM8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3CD20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qqKc4hm1zF3Gl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 01:58:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F4HZOM8S";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="F4HZOM8S"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qqGH34LLzF3Hc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 01:55:19 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id p16-v6so7970022plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L51Xt0giWLtqlH6i1s69vwVGY1Yo0BoONXTZaii8naQ=;
 b=F4HZOM8S4btK3nvPf4Mq9sUCWpHzc5nNuyOVw6X5eOnW/1jK72o3w418tYX/NCxn1w
 9abOLsgHb7V7cHsN3qebOU+nlMGVab0oV46O/QV09SPsttvfGE4b5s8itzNHTtaBo+xP
 dzNK84voCXzs8gwzXy/Dz9hbtUsMj9j24SHwEf3D957HFRnYtTdyaXF7Z6EiSIN2/3IH
 zAKq6g9pEJ9+d4LmDa1sasljke+D0bdh6HD9y7Wwf5xRZV3rMrdrgMrmGceY82I7xV8h
 aYAN4Y2accIKEHLwkxwyP0EdoK8uvY/U2dAXD760U315jWKVMjkQgGxngoYtvcjHcQBZ
 ss1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L51Xt0giWLtqlH6i1s69vwVGY1Yo0BoONXTZaii8naQ=;
 b=DSXBr5Cj297kJ04v9IS0mW3PQQe833cCzWD3PZwsOJpV/0xa5CX83ycgwQf08137AR
 0u4kHZyR4IBx+JM5EpsN0QX1t+otP2sekE9YVa3uM2DmEeDM8CUHvFWqCt0CIeF4Rl/A
 3usYn5b5JGeZceVB45At5nqrl2J7TQWKADqk/PeqICOyaTEUBvJDI+gJLmVUQOOmR/vX
 TmdJZhQtI+zSuHhm4Aali5V4G3+E7K4X7kePlF4+C3SyXhT/9u3zqZN/AXWqzcWIs7EJ
 vfT+P769pDSamSnYW/64DHhqJQ1r2yee2f8DHm8amSHiaj0772pUYZy4AMyNmV65IBYV
 RMxQ==
X-Gm-Message-State: AGRZ1gLD2r2fXaGPwCUzczv1BPX5X7a2OkN0AeuPEyftcerFBunD7ykF
 29PgdiqQcVDaMJE5BqaxFRw=
X-Google-Smtp-Source: AJdET5cw2MXlOGAj/QArd3b+NFPzgYVUt7thhiYE/uXoL84Fv3m3eAnWmwm9LUvMefN6hP/rraRVtQ==
X-Received: by 2002:a17:902:bccc:: with SMTP id
 o12-v6mr524258pls.281.1541602517389; 
 Wed, 07 Nov 2018 06:55:17 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id f10-v6sm754782pgp.72.2018.11.07.06.55.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Nov 2018 06:55:16 -0800 (PST)
Subject: Re: [PATCH v6 07/18] of: dynamic: change type of
 of_{at,de}tach_node() to void
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-8-git-send-email-frowand.list@gmail.com>
 <87tvktqedf.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <6bc78502-7587-eb9c-237f-d3f031979d42@gmail.com>
Date: Wed, 7 Nov 2018 06:55:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvktqedf.fsf@concordia.ellerman.id.au>
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

On 11/7/18 4:08 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> of_attach_node() and of_detach_node() always return zero, so
>> their return value is meaningless.
> 
> But should they always return zero?
> 
> At least __of_attach_node_sysfs() can fail in several ways.

Sigh.  And of_reconfig_notify() can fail.  And at one point in the
history the return value of of_reconfig_notify() was returned by
of_attach_node() if of_reconfig_notify() failed.


> And there's also this in __of_detach_node() which should probably be
> returning an error:
> 
> 	if (WARN_ON(of_node_check_flag(np, OF_DETACHED)))
>         	return;
> 
> 
> Seems to me we should instead be fixing these to propagate errors,
> rather than hiding them?

The history of how of_attach_node() stopped propagating errors is
a bit more complex than I want to dig into at the moment.  So I'll
drop this patch from the series and add investigating this onto
my todo list.  I suspect that the result of investigating will be
that error return values should not be ignored in of_attach_node()
and of_detach_node(), but should instead be propagated to the
callers, as you suggest.

-Frank

> 
> cheers
> 


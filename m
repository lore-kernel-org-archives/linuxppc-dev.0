Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3DC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:40:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C511E2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHZJNYGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C511E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GlrQ1Nw3zDr7F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 09:40:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHZJNYGw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHZJNYGw"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GlnX2f5fzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 09:38:24 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so3338684plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g3KVSBRx0QabCy9wJuZNKFW3vNbztiC+9T0uYuxrFE4=;
 b=JHZJNYGwV3YIGfhCzB7vObzQHxrAOclM4CSjYIa5u4gDZ99tt3d5/JZzBEgqhyM9tn
 mS1/Q1JJtSCfXgHdUxVtGaW7nbnBEJsUzQnG6KhqPOQpmLMSXH17sRdbuySNBjDnPOxh
 rwB8Lqjfkq0eeCHYfJ99r3S23LFMJ2OpVlWDXq04zDrw7EP3ezl1vz4p9hdcIQMHU1XB
 X04G2s/N8hBXguzll24uRaakrbdkNbozhGLTv4l4Zi8krGSEYmRsc0EoXpMtW2ecxrQ9
 Pgn0/fV5Vgkhh/QSM+tIVYYCJKnA2H9PFzN7yoh1BSdpF+nH4uzDKiG1f8YwK8EQHIvp
 lcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g3KVSBRx0QabCy9wJuZNKFW3vNbztiC+9T0uYuxrFE4=;
 b=K8DN7Yv/fM1N7T0ejj25t28Eh4GWi6rK6zzMMU+7AF4QCcnS1QFLqi7HChWMMhMpEj
 H7Rsia9zA+APbqwCw/d4YNHLzLfgvkDkYMIA7jfOwoUx6n65Me9TtXZnRxNT44/XHlL2
 crxFJG49PEWPu0Y1+jBOqvq9WaJLAZchxvWKpj4dXVa/MGL9EvWoRGmUI9upIsJ04qpL
 1MgmHNFhzRyuhRITCCTfrj7WYAzKTCcOvo/jXiLARmIE5ULWZQctpJgpjPwLwCN2+tgU
 twBmkU2cGH4B7XlFLngcgsWGyd7bT4ttUY9djgYf00JraIcFUJGSF2Qs+afrxk/OM8rk
 ubkA==
X-Gm-Message-State: AA+aEWaSKOZCKlvwA6lD6JjUuPsA+O/v9rg/+eeCxpN1PntZdKxNmYgD
 dPv82BZtgA9CHF8c/59jFE0=
X-Google-Smtp-Source: AFSGD/UqcISyDO9jctoO6bGBCuHa5o2LmSgijT6vdj+Pr1DpHP6rUDz6pcSpt9SrH5ytIjL8PW9zCg==
X-Received: by 2002:a17:902:9a98:: with SMTP id
 w24mr4557439plp.213.1544827102290; 
 Fri, 14 Dec 2018 14:38:22 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id 89sm9403568pfl.120.2018.12.14.14.38.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 14:38:21 -0800 (PST)
Subject: Re: [PATCH 2/2] of: __of_detach_node() - remove node from phandle
 cache
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Rob Herring <robh+dt@kernel.org>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
 <68a9e834-b11d-8b9f-1669-466709257f37@linux.vnet.ibm.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <878c5024-c184-12f3-2868-df6c79d568ce@gmail.com>
Date: Fri, 14 Dec 2018 14:38:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <68a9e834-b11d-8b9f-1669-466709257f37@linux.vnet.ibm.com>
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 minkim@us.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/18 1:56 PM, Michael Bringmann wrote:
> On 12/14/2018 11:20 AM, Rob Herring wrote:
>> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>>
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Non-overlay dynamic devicetree node removal may leave the node in
>>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>>> will incorrectly find the stale entry.  Remove the node from the
>>> cache.
>>>
>>> Add paranoia checks in of_find_node_by_phandle() as a second level
>>> of defense (do not return cached node if detached, do not add node
>>> to cache if detached).
>>>
>>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>  drivers/of/base.c       | 29 ++++++++++++++++++++++++++++-
>>>  drivers/of/dynamic.c    |  3 +++
>>>  drivers/of/of_private.h |  4 ++++
>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index d599367cb92a..34a5125713c8 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
>>>  late_initcall_sync(of_free_phandle_cache);
>>>  #endif
>>>
>>> +/*
>>> + * Caller must hold devtree_lock.
>>> + */
>>> +void __of_free_phandle_cache_entry(phandle handle)
>>> +{
>>> +       phandle masked_handle;
>>> +
>>> +       if (!handle)
>>> +               return;
>>> +
>>> +       masked_handle = handle & phandle_cache_mask;
>>> +
>>> +       if (phandle_cache) {
>>> +               if (phandle_cache[masked_handle] &&
>>> +                   handle == phandle_cache[masked_handle]->phandle) {
>>> +                       of_node_put(phandle_cache[masked_handle]);
>>> +                       phandle_cache[masked_handle] = NULL;
>>> +               }
>>> +       }
>>> +}
>>> +
>>>  void of_populate_phandle_cache(void)
>>>  {
>>>         unsigned long flags;
>>> @@ -1209,11 +1230,17 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>>                 if (phandle_cache[masked_handle] &&
>>>                     handle == phandle_cache[masked_handle]->phandle)
>>>                         np = phandle_cache[masked_handle];
>>> +               if (np && of_node_check_flag(np, OF_DETACHED)) {
>>> +                       of_node_put(np);
>>> +                       phandle_cache[masked_handle] = NULL;
>>
>> This should never happen, right? Any time we set OF_DETACHED, the
>> entry should get removed from the cache. I think we want a WARN here
>> in case we're in an unexpected state.

Correct, this should never happen.  I will add the WARN.


> We don't actually remove the pointer from the phandle cache when we set
> OF_DETACHED in drivers/of/dynamic.c:__of_detach_node.  The phandle cache
> is currently static within drivers/of/base.c.  There are a couple of
> calls to of_populate_phandle_cache / of_free_phandle_cache within
> drivers/of/overlay.c, but these are not involved in the device tree
> updates that occur during LPAR migration.  A WARN here would only make
> sense, if we also arrange to clear the handle.

Rob's reply did not include the full patch 2/2.  The full patch 2/2 also
adds a call to __of_free_phandle_cache_entry() in __of_detach_node().

-Frank

> 
>>
>> Rob
> 
> Michael
> 
>>
>>
> 


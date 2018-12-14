Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7834C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 23:07:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E63206C2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 23:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxLaQEnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E63206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GmR94RdWzDrCW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 10:07:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LxLaQEnJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LxLaQEnJ"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GmNG74BGzDqnp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 10:05:02 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id j10so2127200pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QnEvhIpM2cY7QkojVKyU9AUKOYtRzc3GEi68oBJEI2k=;
 b=LxLaQEnJbZBH+sv4XRqb+aeMArzk/AGAR2JHxx2GPFGSFw87RcsPHl+bwTkdeBQzYf
 DQSUNhjeHEDRVNGx4BogWKfR4dRQuH1hXvB7INt8gZ0IQWx5KVOOCv6DbQ2ZJV7i87gM
 P8BtERVOAZ/lOnzggo9S5FYsSTNB/F1v70H4mXOI3/gODMl54dZHUTWZHj3tT09ROHd0
 Fe/BFjuka9g2Vu10+9cwcD9GhelqB4JvznwFRmeo2XCweE9HYg89QhsAbuwyXZI4/qtc
 g2Vuj35IyBVjB9paPsJWO5wvDxrhjAqSmZVNuHdNegHSC3uT/x4tx+h2kZctNJK0XuYh
 owgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QnEvhIpM2cY7QkojVKyU9AUKOYtRzc3GEi68oBJEI2k=;
 b=C2ye0MzBi9ZgCdrj/k8PM31dpIRTUGul6opA6efbHv04+Qj87G6s6eDkwpcuQZZsRf
 SYWJ/nprBllBAkj4i9jcA5VzQHR+2qdNxa36wJrsTxC8fj7jwXKhqPDKYb4NiQchZRCe
 wzQKX+hJecbnVKiyoQ4C+jqHiKxTCU/ytaS5M5rj+wwsBbsNds+LHERONGobDK6S+bq8
 5DMLsfFcTvE8VivkfXrP9Cq+B6rVD1tEqGxw2i4X3fdQkXWwBBE5AuaiY7qCT1KDAEWp
 eUjx3pavC38szzFL6RW0mSTpbCWrR7xSERndLQx3qpHfYWnQtfKLii4wf0u1rpjBn5ac
 53mw==
X-Gm-Message-State: AA+aEWbOqgT/n8K8hhH9rTRQzrDQMrpDwW86zbiXpiukbxJAfE0ta0bJ
 sH/K4V83U5ABJC3O3FFoi7E=
X-Google-Smtp-Source: AFSGD/WG4rs6zJSBwJlPBimz0lwFeXv43Q/9Aab4LunAhles+ApDdu+f99WSZ8erQTXNBmKzEXBxHw==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr3447978pgo.223.1544828700809; 
 Fri, 14 Dec 2018 15:05:00 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id e23sm8568313pfh.68.2018.12.14.15.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 15:05:00 -0800 (PST)
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
To: Rob Herring <robh+dt@kernel.org>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
 <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <cb7caa9a-abcb-93c2-a3e9-185133f1241a@gmail.com>
Date: Fri, 14 Dec 2018 15:04:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/18 2:47 PM, Frank Rowand wrote:
> On 12/14/18 9:15 AM, Rob Herring wrote:
>> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>>
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> The phandle cache contains struct device_node pointers.  The refcount
>>> of the pointers was not incremented while in the cache, allowing use
>>> after free error after kfree() of the node.  Add the proper increment
>>> and decrement of the use count.
>>
>> Since we pre-populate the cache at boot, all the nodes will have a ref
>> count and will never be freed unless we happen to repopulate the whole

>> cache. That doesn't seem ideal. The node pointer is not "in use" just
>> because it is in the cache.

I forgot to reply to this sentence.

The node pointers are "in use" because of_find_node_by_phandle() will
use the pointers to access the phandle field.  This is a use after
free bug if the node has been kfree()'ed.


>>
>> Rob
>>
> 
> This patch also adds of_node_put() so that the refcount will go to zero
> when the node is removed as part of an overlay remove, if the node was
> added by an overlay.
> 
> Patch 2/2 adds the free cache entry call to __of_detach_node(), so the
> refcount will go to zero when the node is removed for dynamic use cases
> other than overlays.  (For overlays, all nodes are instead removed from
> the cache before __of_detach_node() is called.)
> 
> -Frank
> 


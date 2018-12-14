Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5626C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:50:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112C2080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLVuo4IU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Gm3V0ZhgzDrGp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 09:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLVuo4IU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLVuo4IU"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Gm0V2YPZzDr7f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 09:47:54 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id g189so3320120pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+sVeExr61Mq3L3NYAB+pagTiCuo2PfKJ9Dk8LO8Wc1Y=;
 b=TLVuo4IUnJfZh1r5l5l866Ynkcmx6i1y6MtYGhdhM4ouTi9WQHurmlMRQL6goJ8gwx
 v+woPrpWn0rySugQDvtO/IUtm3iVhR7AHKvmxNMH+SEI5K/j6YvBXw/xxK44xnQ30dUi
 sH5ASBxGboDVPKuJ87nqDzfBmw1s8DGcSMVX/aaumXKnar2GiJN8CkrU5Wq8b0qfVfuc
 Cl3fp+n+eM9wNAeI72jCcKYqNPYpgPyk5K4c/nj3HUWV2WzKAHyyccRpoW8RNeDfkJ8t
 IJD0u2BblxmBKT21m+2tKu0DmzW97eWVtQskd/0bSBYDvc9WdKaeZNqkzLgRY839Q12E
 pRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+sVeExr61Mq3L3NYAB+pagTiCuo2PfKJ9Dk8LO8Wc1Y=;
 b=tGTgbMqj9TFhyn/YZGH/ld44xF+RNe9POVKGkad17KAYvMv1Vjq1d8wytDdiiUOFTh
 9DxQtZyXp2wzDHTs7D51yQcWXt0UjlWrFZDH7QefsLOi7bsmKRc8nTUZIY/S6H1dCwW3
 TMcduwoH1Z1aZLN2F7/wQ93CYsu7pT50592qq0kwBvMgUP04qMui2B3+HzznpIZ0bt2v
 NKKAm3eck6re7Vyf/R+16aUXqZJ4Dx1bibj4AiUxARZ6nCJwCcyawkxKNbQF4MGR7nhC
 EPLnYsJyng8cCbkSuKe8ZQ5kN8rCf753M7sl2u/ut/AhPXZYRUcUGcnr7O8CoaZBE6jO
 fFCg==
X-Gm-Message-State: AA+aEWZk0FV6TcMBqagGokXqN4F9r99llh21/m0h3Zq4bUHmITphT92Q
 DGvzs6eyIfUpkPZl3+V3Aks=
X-Google-Smtp-Source: AFSGD/VuhBwckkyEdicrc/CxhZ5Y+gSFHmYsZOVo8nTpsBdeWdGM4WhzXvdOWIgvSSw0UnK9MTAcug==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr4574593pfc.113.1544827672290; 
 Fri, 14 Dec 2018 14:47:52 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u69sm13416584pfj.116.2018.12.14.14.47.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 14:47:51 -0800 (PST)
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
To: Rob Herring <robh+dt@kernel.org>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
Date: Fri, 14 Dec 2018 14:47:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
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
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/18 9:15 AM, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The phandle cache contains struct device_node pointers.  The refcount
>> of the pointers was not incremented while in the cache, allowing use
>> after free error after kfree() of the node.  Add the proper increment
>> and decrement of the use count.
> 
> Since we pre-populate the cache at boot, all the nodes will have a ref
> count and will never be freed unless we happen to repopulate the whole
> cache. That doesn't seem ideal. The node pointer is not "in use" just
> because it is in the cache.
> 
> Rob
> 

This patch also adds of_node_put() so that the refcount will go to zero
when the node is removed as part of an overlay remove, if the node was
added by an overlay.

Patch 2/2 adds the free cache entry call to __of_detach_node(), so the
refcount will go to zero when the node is removed for dynamic use cases
other than overlays.  (For overlays, all nodes are instead removed from
the cache before __of_detach_node() is called.)

-Frank

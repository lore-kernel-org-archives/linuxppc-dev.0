Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 12:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F62920825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 12:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F62920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s0260PChzF3bR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 23:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rzyQ5h7PzF3b9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 23:30:38 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id d135so1176481qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 04:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q/nu3oeqAnSKPEOeYOx5RQ4xAlGVKEFnZNC3cgIskd8=;
 b=cu1b9VW6DxsBcc5kyOuA5jjkxQTNOv/saa3LdHB9m+GrUaG9/Cyl08a9CXi59V9hYx
 otCja/rDdLwSFdAWdq8ogR9Ng39BxHv9lXhc8mfk8BwwW7YnEjPyiP72i2vK1zPMtlp4
 33MbayZSeNLpnHd3WMo0yxhu5A3PAwYzOHPf8CKalahfV6O+5vAdv4hWvUMwv5SIWmvx
 GabTGQT6GfKBpH/MARm0XNmQvr8w7w5qlFNNfnOvKBOp74H67IS75FPLJ5S9VLJpO8LY
 IhOjwH/A7uSqOYepcR7uYaGinA/xrnvCwhbReL31aAEBL4k6fRwvm3X3xP1NBs6tNooS
 EDOQ==
X-Gm-Message-State: AGRZ1gIjT85wvTSlImg9OzQmuxQNrcTMCk1nIpr/kvkDOvzCm/aD5w8V
 a60KR+eBs3me42S9Imvy3t5+JQ9Y
X-Google-Smtp-Source: AJdET5eL7Xrglb8ZlbKb1qTOPQz5/4UqldFz/f7qnvhV7hXTF3RqchFCKF2kkHGqzIK48H8rCFXzcA==
X-Received: by 2002:a37:18e5:: with SMTP id 98mr8313551qky.333.1541766635631; 
 Fri, 09 Nov 2018 04:30:35 -0800 (PST)
Received: from [10.0.0.8] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id u4sm601460qkk.51.2018.11.09.04.30.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Nov 2018 04:30:34 -0800 (PST)
Subject: Re: [PATCH] powerpc: Add KVM guest defconfig
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
References: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
 <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
 <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <6c6b0661-3271-a4ea-1006-3b1dccf53a75@debian.org>
Date: Fri, 9 Nov 2018 10:30:36 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Satheesh,

On 11/09/2018 07:59 AM, Satheesh Rajendran wrote:
> On Thu, Nov 08, 2018 at 04:23:07PM -0200, Breno Leitao wrote:
>> hi Satheesh,
>>
>> On 11/08/2018 03:08 AM, sathnaga@linux.vnet.ibm.com wrote:
>>> --- /dev/null
>>> +++ b/arch/powerpc/configs/guest.config
>>> @@ -0,0 +1,14 @@
>>> +CONFIG_VIRTIO_BLK=y
>>> +CONFIG_VIRTIO_BLK_SCSI=y
>>> +CONFIG_SCSI_VIRTIO=y
>>> +CONFIG_VIRTIO_NET=y
>>> +CONFIG_NET_FAILOVER=y
>>> +CONFIG_VIRTIO_CONSOLE=y
>>> +CONFIG_VIRTIO=y
>>> +CONFIG_VIRTIO_PCI=y
>>> +CONFIG_KVM_GUEST=y
>>> +CONFIG_EPAPR_PARAVIRT=y
>>> +CONFIG_XFS_FS=y
>>
>> Why a guest kernel needs to have XFS integrated in the core image? I am
>> wondering if it is a requirement from another CONFIG_ option.
> 
> Idea is to have a working config which would boot guest without initramfs,
> other FS(like EXT4) is already integrated in the core image, 
> thought this would be helpful for distributions, which default XFS as root disk.

Nice! That makes sense and it is a good idea.

Thanks!

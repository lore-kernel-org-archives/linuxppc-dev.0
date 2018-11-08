Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB0ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 18:24:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63BB2081C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 18:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63BB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rWsd3XdFzF3T5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 05:24:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rWqf6LyPzF3QB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 05:23:10 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id d135so28138916qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 10:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eXGLS0hoWSb+KngniYV06W8NR0yzmzjFeKNNVbkvHGA=;
 b=beYEH33hAPYsjQpX8/AyfW0ZLUJlf+stiTHOljhH34hXJ+hJDk1tQE0FVlNiDsxqal
 CrKJN17bxgjKpySSXA623v6dB2wfSCRDh37BYEJCkA0cd+L+upXHPZ+MG2FCSBnN74JT
 md4bJgA6JPFJQwaSRPkNlQThSFRk+tyd1cf3WNhrk/Bg9umhLkDwTzznHbfvxDos0XDx
 4RbMnw4hnItD+BQDVkkv5EyhlcWZA8BucB7J48TFPlJ0bQn8OvFf6sUUvq3Ufy3yM1cy
 JqUbvBpC36jVLerzfb3f0qpWEtormiwkN7y4r5WNQmhB/uRrIYP1BVfwzoF4wySQ+d+k
 IOVA==
X-Gm-Message-State: AGRZ1gLiZ0g+QfsttFNnoMfn7nqc/EDwo4QrTozw1giqosX2lHrM2RPR
 RRLHv17uI5ypx+5nkt1FsTiXta3q
X-Google-Smtp-Source: AJdET5fQx6vVWF1em/DM9Mg7lawAObfifHvck7zLc0rc9APfMIIZ0ZmOoVWRnsCxuicl2SP7C9LH1A==
X-Received: by 2002:ac8:107:: with SMTP id e7mr5380337qtg.221.1541701388070;
 Thu, 08 Nov 2018 10:23:08 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
 by smtp.gmail.com with ESMTPSA id v3-v6sm3484424qth.74.2018.11.08.10.23.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 10:23:07 -0800 (PST)
Subject: Re: [PATCH] powerpc: Add KVM guest defconfig
To: sathnaga@linux.vnet.ibm.com
References: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
Date: Thu, 8 Nov 2018 16:23:07 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
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

On 11/08/2018 03:08 AM, sathnaga@linux.vnet.ibm.com wrote:
> --- /dev/null
> +++ b/arch/powerpc/configs/guest.config
> @@ -0,0 +1,14 @@
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_VIRTIO_BLK_SCSI=y
> +CONFIG_SCSI_VIRTIO=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_NET_FAILOVER=y
> +CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_VIRTIO=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_KVM_GUEST=y
> +CONFIG_EPAPR_PARAVIRT=y
> +CONFIG_XFS_FS=y

Why a guest kernel needs to have XFS integrated in the core image? I am
wondering if it is a requirement from another CONFIG_ option.

If it is not a strict requirement from another config, I think we can keep it
as defined at ppc64_defconfig, which defines it as module (CONFIG_XFS_FS=m).

Thanks for this patch, very useful.
Breno


Return-Path: <SRS0=jSyS=7I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD5CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2020 05:18:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C3207D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2020 05:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C3207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=longchamp.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WMgF1PxrzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2020 15:18:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.65; helo=mail-wr1-f65.google.com;
 envelope-from=valentin.longchamp@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=longchamp.me
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WMdW46DDzDq9Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2020 15:16:45 +1000 (AEST)
Received: by mail-wr1-f65.google.com with SMTP id t18so5021341wru.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2020 22:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nJy5Y/wFhqFBhHT59jrIgHaVUD/qjpVN0AKUN1fDJdQ=;
 b=C1PugLqn+sZBd/Q9gOoDJXM7IdCGpNfDSfhvSdRYe8LMQZXsq+OK2JKS+nnPKsBDXo
 NGEENWD3i9vMgzmK/8PalBrJbq6tiPLv4IvVKYB6ckbAhxXKIc9yRPZeSl8IsGf4dKlG
 P0AgIQ0Mz9bzdSxBBv206hkVEbVMABLWa6PFpdpOwYFVJC+vjPUUox93qpKIui8g8dmR
 zRqjx7yT+TNIT+BOWy0CoHzJ/7b8obOyzD3Nk4OGzWyQtPpn6JvItlEMfEJFj7Pb4IK7
 kBSDFqmeFdoiXMvJyWJH4AEI9O3PRkVnKzti+bB5EBuLL5XpIQb60cHk4hbz8FB8SOGI
 1uSw==
X-Gm-Message-State: AOAM5326pQXqm+f5JThu/GZRujtJvSYvAp+2g3y4PEDlFuWL752hnUuO
 /g4cJZCmDeGTc/8EiZlPPsA=
X-Google-Smtp-Source: ABdhPJyMfKMei90bNH0yaIwELtH0DBWlPHSWNTMq2PHBi0nVjke+rsl1XhE4AKvnQFOJ7r2hpXI9PA==
X-Received: by 2002:adf:e450:: with SMTP id t16mr19495513wrm.66.1590470202261; 
 Mon, 25 May 2020 22:16:42 -0700 (PDT)
Received: from ?IPv6:2a02:21b0:9002:414a:5d95:b3ad:52db:6030?
 ([2a02:21b0:9002:414a:5d95:b3ad:52db:6030])
 by smtp.gmail.com with ESMTPSA id 23sm12321010wmo.18.2020.05.25.22.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 22:16:41 -0700 (PDT)
Subject: Re: [PATCH] net/ethernet/freescale: rework quiesce/activate for
 ucc_geth
To: David Miller <davem@davemloft.net>
References: <20200520155350.1372-1-valentin@longchamp.me>
 <20200522.155054.352367636201826991.davem@davemloft.net>
From: Valentin Longchamp <valentin@longchamp.me>
Message-ID: <aa59c21d-c15a-b087-cc17-04535ebcdb41@longchamp.me>
Date: Tue, 26 May 2020 07:16:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200522.155054.352367636201826991.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Reply-To: valentin@longchamp.me
Cc: matteo.ghidoni@ch.abb.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, kuba@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 23.05.2020 à 00:50, David Miller a écrit :
> From: Valentin Longchamp <valentin@longchamp.me>
> Date: Wed, 20 May 2020 17:53:50 +0200
> 
>> ugeth_quiesce/activate are used to halt the controller when there is a
>> link change that requires to reconfigure the mac.
>>
>> The previous implementation called netif_device_detach(). This however
>> causes the initial activation of the netdevice to fail precisely because
>> it's detached. For details, see [1].
>>
>> A possible workaround was the revert of commit
>> net: linkwatch: add check for netdevice being present to linkwatch_do_dev
>> However, the check introduced in the above commit is correct and shall be
>> kept.
>>
>> The netif_device_detach() is thus replaced with
>> netif_tx_stop_all_queues() that prevents any tranmission. This allows to
>> perform mac config change required by the link change, without detaching
>> the corresponding netdevice and thus not preventing its initial
>> activation.
>>
>> [1] https://lists.openwall.net/netdev/2020/01/08/201
>>
>> Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
>> Acked-by: Matteo Ghidoni <matteo.ghidoni@ch.abb.com>
> 
> Applied, thanks.
> 

Thanks David.

May I suggest that this get backported to stable until (including) the 
4.19 stable release ?

As the above mentioned commit, merged for 4.19,
124eee3f6955 net: linkwatch: add check for netdevice being present to 
linkwatch_do_dev
does indeed break the ucc_geth driver, this patch can be considered as a 
bugfix that should be taken into account for stable.

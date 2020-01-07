Return-Path: <SRS0=KFH9=24=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2813C33C9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 18:14:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B8820715
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 18:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoFeUEpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B8820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sgVz4YLQzDqQ6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2020 05:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e;
 helo=mail-wm1-x32e.google.com; envelope-from=hkallweit1@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FoFeUEpw"; 
 dkim-atps=neutral
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sgP81PgPzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2020 05:08:54 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id u2so537288wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2020 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=leZH/hyPq1HdCmvzNKu8P8e45+GKLsiInMdhc5pNFYE=;
 b=FoFeUEpwmgInfkhgPEk7Pek3DR6i0HrV/knpEhN/3tGhczrD1aPN2ANsFY07M1Epyg
 SuyBhe1kaDSrUuWjOyS44HZyXn17/Plm8petLwiuzuNOUFdLw/HIG+TkIUZufvi+swEP
 qxcnPQWpdHAXhjGujXyhkEchTeOmpgi3l6g9H3EbPFzU0g4U8yN2k93QkQ2JDKfKncKu
 Yg32KK2lEt5sXttWdCOwHRPaZZ6L+Fz2dID6byFNhAt+5X7gFN+QpkAb8B/FObCorFq5
 IYc/ZyXfy3Fcd+2Ldj9vM9nRVOvrttdK5QQMjC3VthxjdIKjMSkNZpsxiIJmka6QYbP1
 gcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=leZH/hyPq1HdCmvzNKu8P8e45+GKLsiInMdhc5pNFYE=;
 b=tZ3sMOD6G+FGhprX2SGHHDzod/U/FhcAL2LiLHHd/cXGfhkYo0+6Bz/uRGJ2A5rZCC
 kgQFzIK2Obc+KPqdYWyg9q+vkQBgbdfPvtOVmpnvFRgP0PNgVfpWiqIVQ9bRHc3oeMnm
 v2V9pgr6/ClRiwumCGY/kqCWvRz+8gf8aRQeZt1paQtpUWyf31sNv3mLNgaJzf5g2EZ4
 5zt5Dw8tJgFjCegyOmR6AfbS6Fq8S9wShrRSy+Z9CmbTTGHShtzsyJIPWWMRlBXfavGC
 xt1/X506gM/E5/CfjiD2LxdZJmf9F+zV46/zACSzxHKNCfBtVWc6TNUnyN7A/YVETQfL
 EwIg==
X-Gm-Message-State: APjAAAVrQMm9VRkFjBQdI4XgReNkleH8Y+horP6KwTqxi3PX70f4qBW0
 LUAwEBy0qcT3ZMuW+t0xpntQUnM7
X-Google-Smtp-Source: APXvYqxPVTpjxx8/KcW29Al+6XlZKWg5gYC2ZMbChGCuta74x2uYzEsi5/wzvNsQbKd1puAckBTfxQ==
X-Received: by 2002:a1c:61d6:: with SMTP id v205mr297744wmb.91.1578420529794; 
 Tue, 07 Jan 2020 10:08:49 -0800 (PST)
Received: from [192.168.178.85] (pD9F901D9.dip0.t-ipconnect.de.
 [217.249.1.217])
 by smtp.googlemail.com with ESMTPSA id o16sm534602wmc.18.2020.01.07.10.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 10:08:49 -0800 (PST)
Subject: Re: Freescale network device not activated on mpc8360 (kmeter1 board)
To: Matteo Ghidoni <matteo.ghidoni@ch.abb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>
References: <AM0PR06MB5427E4BDF8FB1BEC5DF3D45FB33F0@AM0PR06MB5427.eurprd06.prod.outlook.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <55f4ba5d-fd05-4a14-6319-d5d76c9675f2@gmail.com>
Date: Tue, 7 Jan 2020 19:08:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <AM0PR06MB5427E4BDF8FB1BEC5DF3D45FB33F0@AM0PR06MB5427.eurprd06.prod.outlook.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, "sux@loplof.de" <sux@loplof.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 07.01.2020 14:05, Matteo Ghidoni wrote:
>  Hi all,
> 
> With the introduction of the following patch, we are facing an issue with the activation of the Freescale network device (ucc_geth driver) on our kmeter1 board based on a MPC8360:

+Li as ucc_geth maintainer

Can you describe the symptoms of the issue?

> 
> commit 124eee3f6955f7aa19b9e6ff5c9b6d37cb3d1e2c
> Author: Heiner Kallweit <hkallweit1@gmail.com>
> Date:   Tue Sep 18 21:55:36 2018 +0200
> 
>     net: linkwatch: add check for netdevice being present to linkwatch_do_dev
> 
> Based on my observations, just before trying to activate the device through linkwatch_event, the controller wants to adjust the MAC configuration and in order to achieve this it detaches the device. This avoids the activation of the net device.
> 
It sounds a little bit odd to rely on an asynchronous linkwatch event here.
Can you give a call trace?

The driver is quite old and maybe some parts need to be improved. The referenced change is more than a year old
and I'm not aware of any other problem with it. So it seems the change isn't wrong.

> This is already happening with older versions (I checked with the v4.14.162) and also there the situation is the same, but without the additional check in the if condition the device is activated.
> 
> I am currently working with the v5.4.8 kernel version, but the behavior remains the same also with the latest v5.5-rc4.
> 
> Any idea how to solve this? Any help is appreciated.
> 
> Regards,
> Matteo
> 
Heiner


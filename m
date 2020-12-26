Return-Path: <SRS0=+96s=F6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4082C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Dec 2020 03:44:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889182074D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Dec 2020 03:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889182074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D2qSg4hqbzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Dec 2020 14:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::329;
 helo=mail-ot1-x329.google.com; envelope-from=larry.finger@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MohuC2Kz; dkim-atps=neutral
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D2qQg404RzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Dec 2020 14:43:03 +1100 (AEDT)
Received: by mail-ot1-x329.google.com with SMTP id q25so4858909otn.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Dec 2020 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=hYDSn/BmnoHjlOoyQQjrhYrg2CbWsy7MQQlvU0F6CDE=;
 b=MohuC2KzYGO9DTHLgJ+5CP/gAo2/9Lqe6r5f2VfbMPlzQMkw6adnyeH/R+66BuR3Id
 dyc6q3ijR3qPeUJ3c7UVzSMcKVF5k6TWWGBjyZFeeycnWLQIQZcdiLJXtWjDt9PlfK1o
 J/n1a9HxTaIjnDId95JfFPN73Kjgf+xwbPR8+iI9N+LJxjfmugHpURo+ub3UtPm/nLm9
 2xdKonI+sDUPcJY+GUguB8iibvzzB4J10t18t8Dkh0dY78InGTwjZfPpDm2jQxygB+vZ
 Agzw2z+UqKAQvElcNdM6UkESK/PNuL0BsgT+8a1fd0+S784EwH++hCaJTxpGQA+VMjIt
 Qutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=hYDSn/BmnoHjlOoyQQjrhYrg2CbWsy7MQQlvU0F6CDE=;
 b=DB+ZCefHacHqY8FULPiKiMjKQd7+OWuWAmi6225YIs4htEfaldJ747aXmKdvDKFINJ
 dSLhTX53jpQBrWFs2wJ6+LI5+exnzVxi0y0jVo6TJIDZqFprsW6T5kJNZ8npiPawd6ef
 Hd7fAStIN+jdhLmgyHMJa7fDONV1okTIXQXiWF/cYoZk3yNehJoEDSQH+9NDaFR/J84z
 1taHvgIpgl4F7gn87ykFfnvjCXFy+KQrpyW9J8MOo7giEccSam30Lm/HunDwrKS3ZMec
 F61RlWoUHobJ2N9MUpD4ulRxuiiLn72il4CBa4FNw+s3TmcI0g4IPrqES8btH5aEhrHF
 VelQ==
X-Gm-Message-State: AOAM5321Y8+li2hQtPoJNmJXlHde798OIXx7OUN18R0mfYNo1LwdHncw
 AQcZhy+AR4xqxmqbQLZDmUXgRzGwvO4=
X-Google-Smtp-Source: ABdhPJymcqvdrz1MBVVjbZevdxflnUtxj3S4/EQcdeHUN3ALjvBU4b0AsxLks0SLD950+pZ/myNBqQ==
X-Received: by 2002:a9d:6185:: with SMTP id g5mr26643958otk.273.1608954180371; 
 Fri, 25 Dec 2020 19:43:00 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com.
 [24.31.245.230])
 by smtp.gmail.com with ESMTPSA id a15sm7653407oii.50.2020.12.25.19.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Dec 2020 19:42:59 -0800 (PST)
To: Christophe LEROY <christophe.leroy@c-s.fr>
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Regression for 32-bit ppc on PowerBook G4 Aluminum (bisected to
 commit d0e3fc69d00d)
Message-ID: <2c70bdb1-7c1c-d353-3c42-55c1bdf867bb@lwfinger.net>
Date: Fri, 25 Dec 2020 21:42:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Beginning with commit d0e3fc69d00d ("powerpc/vdso: Provide 
__kernel_clock_gettime64() on vdso32"), my PowerBook G4 Aluminum fails to boot. 
It stops pretty early in the boot.

I will be happy to test any patches, or provide any additional information.

Larry

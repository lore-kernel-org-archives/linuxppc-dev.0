Return-Path: <SRS0=KFH9=24=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E1C33C8C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 17:55:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555002087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osRGEF1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555002087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sg5V16zqzDqM3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2020 04:55:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=bertrand.dekoninck@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="osRGEF1y"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sg0y0LbxzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2020 04:51:29 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id z3so434358wru.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2020 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hAgG5zMPb8eNhkCxqIfSP/yA2BoiKq2IF1vf4aEoa+k=;
 b=osRGEF1ylR/S8t2jNuNLDRDWLPUFwzxbQlch4pOb0zTw4yjgVNneUDHn8yXg/zKggj
 Gr8w+P57Mpish2oZhfGngJspw9cOd2H+ViLsEjw8TZCAo2njp1AmpkGievqfXI6ClnO1
 80wYTIaD3ZHX7HrJkhQd7BuBO7ZREwVAY+sLZd5eiDvWOPKpjvYtXd4KLGykcdOHrM/Z
 Z7wZNhiygyHwUuwZIDg/+L8cVG4PI26sfJmLg0CY4Elg3P8K+Sc/YhMUOkWBA8S2IS2g
 7W5/wm4nH7Q0xGHU7UJOIQX2MVkh7tvbl/GmLe5/w7nRte72FviGeFBOj7QvIjLUXBFw
 HyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hAgG5zMPb8eNhkCxqIfSP/yA2BoiKq2IF1vf4aEoa+k=;
 b=S1PvOegEBBlZfxPCdG4nZGibo3lyPV6/lxYr/FGUBgi8QFSKnDm5f8JPSJ1Jl+CMGe
 9pZTuvLJ5xh5q0dlKvwwtMH1C83AJ2GMjUZYG6EKAkGJMwr4e82yCkJ8cNxpO5/DyGVJ
 IW5nl7phoxzmhpRwBwWYmvaRDef3MUu+j/QiQ3IbwhxUKw406c1iNiKDkl8j0pfrPT5K
 41bQdMpioil0kGNghNF+ZU7FMLU/HRhDkOBN+x6SzxuxPnNm/gND3TUDR+t4i+B8gENT
 n7tdok1j1e+1+k7jui5Xk2l3tXkiwq9sFDHKou+DxZ6b22uwOz3Lj/ufsL+PwGG147Pw
 mp3Q==
X-Gm-Message-State: APjAAAXc19GSUjY6sQIfO82Kc1EdiswesmWRZlNRo1Z/o72sR/b8UMur
 rRO4JLnyhU3D7sHODG//DrI=
X-Google-Smtp-Source: APXvYqwKNHCfvUXYmgoNIiSLwNvbHnHcpnhzH0BfpqWcBhUvWmdLweM3AEfeFeQsiJXrDaoZo/nILw==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr250451wru.119.1578419481731;
 Tue, 07 Jan 2020 09:51:21 -0800 (PST)
Received: from ?IPv6:2a01:e35:2428:560:44f3:4b8f:b355:41c0?
 ([2a01:e35:2428:560:44f3:4b8f:b355:41c0])
 by smtp.gmail.com with ESMTPSA id z4sm460579wma.2.2020.01.07.09.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 09:51:21 -0800 (PST)
Subject: Re: PPC64: G5 & 4k/64k page size
To: Romain Dolbeau <romain@dolbeau.org>
References: <CADuzgbqYpv40NvAMGjo1cU2cNnij-2p4SYpWgM-Xn0v-8Qapsg@mail.gmail.com>
 <CA+7wUsxBkmG-jW_UVBUuMriZbDkJko3kg0hzmMrVMoJLu2+rPw@mail.gmail.com>
 <CADuzgbqoX3DQ6OVqdR6dw1oqnNn-Q0zLPshDi23DwDtYukDYdg@mail.gmail.com>
 <CADuzgboWQtVqp7-Ru4uQQaPerkhLnaS9=WiwX2dD4-5VypT2MA@mail.gmail.com>
 <CADuzgboYv69FQxQRvJ_Bd563OPO0e=USd+cTChfDK60D5x75hw@mail.gmail.com>
 <b2256437-efe1-909d-1488-174b6522f9e0@physik.fu-berlin.de>
 <87eexbk3gw.fsf@linux.ibm.com>
 <CADuzgbq-P8mgf9zLaxhdqUfQcqfRpSzjgRoofF84rp+-S064xg@mail.gmail.com>
 <87mubxl82x.fsf@igel.home>
 <CADuzgbqU-SVy5U_4Pkv2G8SJcT9JhyirhFGamnQusZBSRSgcPw@mail.gmail.com>
 <87immlkytp.fsf@igel.home>
 <CADuzgbo=Yr09hxrkbkwj7Crg0aUfx+RQZOt0sCSNOeYUfR0SmA@mail.gmail.com>
 <20191214103213.309bfbbb1f9c50fe47e733d9@zonnet.nl>
 <B661D5F4-575C-4E64-BC68-537223FFB5B6@gmail.com>
 <CADuzgbpiN-=VgmZCHOyXFDEuj2L+aVzJGfibkvgfnPD_atNZMw@mail.gmail.com>
 <709f10b0-6b7f-8de2-3fac-1f4f6350afaf@gmail.com>
 <CADuzgboKYD2CeXODpEH5Vboov4gr0fPG8ZmCTaqWw-3ve53MiQ@mail.gmail.com>
From: Bertrand <bertrand.dekoninck@gmail.com>
Message-ID: <113ee36c-684f-9201-aea8-8cd437b6d009@gmail.com>
Date: Tue, 7 Jan 2020 18:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADuzgboKYD2CeXODpEH5Vboov4gr0fPG8ZmCTaqWw-3ve53MiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Jeroen Diederen <jjhdiederen@zonnet.nl>,
 PowerPC List Debian <debian-powerpc@lists.debian.org>,
 Andreas Schwab <schwab@linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 07/01/2020 18:13, Romain Dolbeau wrote:
> Le mar. 7 janv. 2020 à 16:27, Bertrand <bertrand.dekoninck@gmail.com> a écrit :
>> I've tested the 5.5-rc package with the link you gave hereafter. When
>> you said "working kernel", did you mean it would not crash ? It doesn't
>> for me. I can boot successfully.

> As your machine is booting regular 5.3 as well and seems not affected by
> the bug, can you share some details about it? (exact model, number
> of cores, ...).


It's this one : 
https://everymac.com/systems/apple/powermac_g5/specs/powermac_g5_2.0_dp_pci.html

powermac G5 PCI, two 2 Ghz cpu, radeon 9600, with 2GB of ram. I can send 
dmesg or something if you want.

Bertrand


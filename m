Return-Path: <SRS0=JrXR=RT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 22:49:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DA8218AC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 22:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNHMhyXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DA8218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MHgG4SMSzDqRr
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 09:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNHMhyXv"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MHdW4nWCzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 09:47:27 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id 8so5324934pfr.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vh9QpzVJ1GnogVWkgaXISddHjcJKCi1xFYlnKtK9wOE=;
 b=MNHMhyXvftpQW8gv5WoQbgRbKVm1TayLyZziA2ArrhZflHNcY438MGg/vRNDuJQ7Dq
 STfudT7sgRJZZlV03hoDE2m6MaLL1E3VTXDd1ha2OPmfWGESbSmPuhQ6ONZcGVptwkVm
 Krnv1y8DRl4aCSgHlCvTmZEcQN95GTiPRZ7lglJlVw+McD5q0XEx6CG4DG2C0fH0Yz/3
 EafB1GR41nAeUs5HLH9d8qrX9j90MuPJxXuTDIT62I0+jRtoe5p7qHgPnpYlS7eQlmIu
 sS40RVIb9IVlz0MtQFOltLgOwO6VlMpDoWV5Ll9RuJXPoS5x/+v6Qih+0ySfqigsQcj9
 Ph7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vh9QpzVJ1GnogVWkgaXISddHjcJKCi1xFYlnKtK9wOE=;
 b=JKh8zg/2fWZiogJYBLUW+OZ4u5BU+WXuwY2UOEz7Tsd+jGQAGxcPCgI10VOZ64fY20
 t3wO3HuOW8C3d+sxnBnnEm8zVNksKIEEabuA3/dLz4GfcmOwggC+OdMiOcmswoqnjGc6
 Q+qVFZ+VtVX8e9NsIsS+EMPT5qviU1cMQ0+R0PflJc0v80FDciIrHNYpWpAP2GcazsQf
 Q9DprLE/1gCOhgIeKesroFehsfM3q4FcHrMKadYzLR77LXiACIC1YgcAYbj/KOuRtOEz
 n5+PbuVcCHfJACdiwaCaOE7mUb2lU4p55RPEgHDY2IzNei0RiWTqS0M8cCC5bRViGUOD
 2irw==
X-Gm-Message-State: APjAAAUe/GVRi4bCFr3TsdixLqAQEwlaBBh6m3GFVENFT+8MzFQpmWOM
 vp3YdRurXfvtURw/jYVY1ys=
X-Google-Smtp-Source: APXvYqzQUedoP/ERtt4XvHLELuGClnVTPF0/WGUV+n9Zl63CLpk/PLpneR5GudEPKKfUx+ELXPRcjg==
X-Received: by 2002:a17:902:6b48:: with SMTP id
 g8mr11929887plt.21.1552776444362; 
 Sat, 16 Mar 2019 15:47:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g2sm15479420pfm.144.2019.03.16.15.47.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Mar 2019 15:47:23 -0700 (PDT)
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
 <20190308160334.GZ3969@gate.crashing.org>
 <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
 <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
Date: Sat, 16 Mar 2019 15:47:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/15/19 6:20 AM, Christophe Leroy wrote:
> Michael,
> 
> Are you able to get this merged before 5.1-rc1 comes out ?
> 

Looks like this patch got lost. I don't see it in Michael's most recent
pull request, the one that got merged today.

Guenter

> Thanks
> Christophe
> 
> Le 08/03/2019 à 17:06, Christophe Leroy a écrit :
>>
>>
>> Le 08/03/2019 à 17:03, Segher Boessenkool a écrit :
>>> On Fri, Mar 08, 2019 at 07:05:22AM +0000, Christophe Leroy wrote:
>>>> Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
>>>> startup. This patch move it from __setup_cpu_603() to start_here()
>>>> and __secondary_start(), close to the initialisation of SPRN_THREAD.
>>>
>>> I thought you meant an SPR I did not know about.  But you just misspelled
>>> SPRN_SPRG_PGDIR :-)
>>>
>>
>> Oops.
>>
>> Michael, can you fix the commit text (and subject) when applying ?
>>
> 
> 
> 


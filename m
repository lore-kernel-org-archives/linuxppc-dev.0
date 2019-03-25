Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DCBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:22:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEFA20828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwEvBQ+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEFA20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SfgS6hVfzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 03:22:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=larry.finger@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwEvBQ+i"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SfbV2rLNzDqD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 03:19:18 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id c18so8521623otl.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kNhjFyAJj2F2IJvSUMRthN84gt9w56CKqbJ/olM8L5c=;
 b=mwEvBQ+ipRV1kh+mAX4sg5T8MvtOw5lQLKAyDP5KtmkAwpb/YJeM70ld9m7o3fvbAp
 Jp0m9I1TqBMiAUvn0qWEKxfTi1HJU3s/C4KC7PFa3bUH0q7uXo52Ob+5h5rySV9gtzpq
 yY6pfmedYOVX5w77uC0WNodR7KU4F9Z228xCQin880bDGeqYrfsxBcpcodkU+r5qNCkZ
 fJyBXzfSAsyL47eA7d0IIonfarhs2sOu/Jix0Hb06w9cA2G7bJGjhQu/S9jJOX30fdmU
 QdXnwvs3wc+4DMIKDCkEQANbYSO9j/s5qgat5yS9B7tNqM+DmSGx72Nw8Tb2nVaDzTxa
 /01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kNhjFyAJj2F2IJvSUMRthN84gt9w56CKqbJ/olM8L5c=;
 b=j4vNvK6WbKHj5gxpODWF+95QB+xfmOskqyyKBCrcLNKWAMbxTLW2PGKCUooLYHieB6
 tGOGlEVZWl0Qkk6hNH6eWP37FbWDyIU69AAuDLLdi24+bgr1mM4LwJtI65Cm9bxyucc1
 yqb3AZ5D+1hKc07c5Ej2sBxGKkhk49JY0CNQnokIqI+2EUDO8+yGqlM0oLItgjsDjj0c
 4BBy3tWcJFNUzyZkvo4olcSBhWIQ5RoeR1CpZJEbLsotMjG4jrDJg9yPySQv1YVEJZTO
 APB+40ZVcE59xsRQ2XDbuD3jzFwYRi3k9hfPItKbbte2gQfjpLml+vRMkOAsfsHY6y7U
 +2DA==
X-Gm-Message-State: APjAAAVyD2aLJPmWA3d7kjaWluNP+C6JAWGwqAgkEZVybfDgb53hSnuN
 vHI2pghpqxeCFk8M20Y0+Vs=
X-Google-Smtp-Source: APXvYqxwCD7u/nsuaz8zjuQ8HPzJ+ui04FJJBhLrRpeCfsUxtcLoyPMe+47GItlEnnVdu5AZuvnE3w==
X-Received: by 2002:a05:6830:20cc:: with SMTP id
 z12mr18834817otq.334.1553530756491; 
 Mon, 25 Mar 2019 09:19:16 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com.
 [24.31.245.230])
 by smtp.gmail.com with ESMTPSA id c131sm6457965oif.3.2019.03.25.09.19.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Mar 2019 09:19:15 -0700 (PDT)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
 <1c1f7eae-0c49-dcb2-f27b-96a83d811df7@c-s.fr>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4d7e3fc5-82d8-5bcf-0891-97445e284c36@lwfinger.net>
Date: Mon, 25 Mar 2019 11:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1c1f7eae-0c49-dcb2-f27b-96a83d811df7@c-s.fr>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/25/19 3:46 AM, Christophe Leroy wrote:
> 
> 
> Le 25/03/2019 à 01:49, Larry Finger a écrit :
>> A build of kernel 5.1.0-rc2 resulted in a failure to boot on my PowerBook G4 
>> Aluminum. The bootstrap loads the initial kernel and issues the appropriate 
>> start, but the machine hangs at that point.
>>
>> The problem does not depend on the choice of PPC32 processor type. This 
>> machine has a 7447A according to /proc/cpuinfo.
>>
>> The problem was bisected to the following:
>>
>> commit 0df977eafc792a5365a7f81d8d5920132e03afad
>> Author: Christophe Leroy <christophe.leroy@c-s.fr>
>> Date:   Thu Feb 21 10:37:54 2019 +0000
>>
>>      powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
>>
>>      When calling RTAS, the stack pointer is stored in SPRN_SPRG2
>>      in order to be able to restore it in case of machine check in RTAS.
>>
>>      As machine check is not a perfomance critical path, this patch
>>      frees SPRN_SPRG2 by using a field in thread struct instead.
>>
>>      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> I reverted this patch and found that the system began execution, and then 
>> failed, likely due to the reassignment of SPRN_SPRG2.
>>
>> I had found this problem with 5.1.0-rc1, but -rc2 was out by the time I 
>> finished the bisection. Unfortunately, none of the changes in -rc2 fixed the 
>> problem.
> 
> I think I identified the issue, see https://patchwork.ozlabs.org/patch/1063962/
> 
> It is now booting properly under QEMU with your .config
> 
> Could you please test it on your target ?

Thanks. That patch fixes the issue.

Larry




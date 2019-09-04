Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030BCC3A5A8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 16:15:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863D621670
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 16:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863D621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Npnw6SVRzDqLR
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 02:15:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.177; helo=mail-pf1-f177.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=acm.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Npfk4nb8zDqtt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 02:09:17 +1000 (AEST)
Received: by mail-pf1-f177.google.com with SMTP id y72so5954621pfb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Sep 2019 09:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XErXDQUXB06HtDTOiYRG9XmArU9bvhEptkEPoC0URcA=;
 b=L+YdkH0YZp004mbh0gJWknSO5ZaUswKpUtHRCxDPwPaBTVmI5CJYVfSns3t54pIOir
 8rPLTtqf+VlUZxRFXJpu110EApkCTPhhZ+3AK9lYLDc+x/JiqbwE3sCDyBio6LYCWM6w
 xK1+5BhszYt35TAQ8haJqD0DWliDH52/Csu6tJccSX+0R62Rs1bitUNfHP402G7MEsx0
 G7bU82U1T+gEjIGEmJZQkewUsSDYeoyDHF2c+iPTxCR+RAEVh3xqZ1FVefj5wJbeeRAI
 poMIxciMjREGwyTHTu4t7L820VGa4TuNMirNLSfP1C33+qaCcaw3qj2UNGYzm3EPjbPf
 ZV8g==
X-Gm-Message-State: APjAAAWozcn6B99KYALVlDAiR7BFV4I68wGkRiYVnpT8vJyTwB7Jy/Pj
 S0/Y9doBvb2ly7BtHGzsn18=
X-Google-Smtp-Source: APXvYqw0Ks9MUXGu/5Cf6iBSADywOoWtDQLLDbxBDQ8d9toYPzgTjAcQLLN0ef2hdNAfHtQzc/Ct/A==
X-Received: by 2002:a65:4546:: with SMTP id x6mr35120577pgr.266.1567613351999; 
 Wed, 04 Sep 2019 09:09:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id v12sm19059248pgr.86.2019.09.04.09.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 09:09:10 -0700 (PDT)
Subject: Re: lockdep warning while booting POWER9 PowerNV
To: Qian Cai <cai@lca.pw>
References: <1567199630.5576.39.camel@lca.pw>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org>
Date: Wed, 4 Sep 2019 09:09:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567199630.5576.39.camel@lca.pw>
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
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/30/19 2:13 PM, Qian Cai wrote:
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would generate
> a warning in lockdep_register_key() at,
> 
> if (WARN_ON_ONCE(static_obj(key)))
> 
> because
> 
> key = 0xc0000000019ad118
> &_stext = 0xc000000000000000
> &_end = 0xc0000000049d0000
> 
> i.e., it will cause static_obj() returns 1.

(back from a trip)

Hi Qian,

Does this mean that on POWER9 it can happen that a dynamically allocated 
object has an address that falls between &_stext and &_end? Since I am 
not familiar with POWER9 nor have access to such a system, can you 
propose a patch?

Thanks,

Bart.

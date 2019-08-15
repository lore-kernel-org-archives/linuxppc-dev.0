Return-Path: <SRS0=to3W=WL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DFC31E40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 03:44:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6AA20656
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 03:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6AA20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468C413wcHzDr15
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 13:44:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.214.194; helo=mail-pl1-f194.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=acm.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468C2724KPzDqVR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 13:42:22 +1000 (AEST)
Received: by mail-pl1-f194.google.com with SMTP id go14so276662plb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 20:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JANJxBWQQ/lmx3e6gQBBNY3HZrSKplwd+VTRdmaTTlA=;
 b=VzUUfxsU75YOgu6iwYfJtb9FIUiTRej8gQ4duih/3iljsQpoqW68vQr+ke0PsI7gs8
 0B9zaWcRH2CO5zIvklBRhkfqCdGmwht1Q80mVlyYnswEK438G14afvqe/NTKxHI63y0M
 ifO4mZuaX+bynjdELIf+OjBuCE5wB/K9VDt5fnXcUCD8npBt5XNzo5gmic+egME9MslS
 MDSCYwFtY/xV8jj/oQqL8kBz+/An4AjMNILHPeVt3pqPmF2+hL9wkBy253bZRts7jvzD
 N+Clf88Zi31NwkH1g6mFlcNgjrQpZjc6Iy/KC2Ps1cXyzx3q2pIMPZKV6waPWhOhEcdu
 mNOA==
X-Gm-Message-State: APjAAAWebP8GjFqrW1mAxyVS/TRx8OjhQrWAFm93pZ+c5KdZxTvJCUAX
 RnLbSkmENbr8N9Z2gsqq9zw=
X-Google-Smtp-Source: APXvYqx81wrPhXH/lYFj4J2/x/boo2UlT8ODFpdBydweGYIHtn18VNQq90jQEYeDTlyS2mxJb39Ung==
X-Received: by 2002:a17:902:8302:: with SMTP id
 bd2mr2539863plb.9.1565840539761; 
 Wed, 14 Aug 2019 20:42:19 -0700 (PDT)
Received: from asus.site ([2601:647:4000:7f38:138a:21ca:d24:734b])
 by smtp.gmail.com with ESMTPSA id y188sm1376690pfy.57.2019.08.14.20.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2019 20:42:18 -0700 (PDT)
Subject: Re: [5.3.0-rc4-next][bisected 882632][qla2xxx] WARNING: CPU: 10 PID:
 425 at drivers/scsi/qla2xxx/qla_isr.c:2784 qla2x00_status_entry.isra
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
References: <1565801523.6908.6.camel@abdul>
 <cafb1d40-a11e-c137-db06-4564e5f5caf5@acm.org>
 <1565803123.6908.10.camel@abdul>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <7fc59d4c-b3d5-5ec8-cb7c-51cb863f2a77@acm.org>
Date: Wed, 14 Aug 2019 20:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565803123.6908.10.camel@abdul>
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-scsi <linux-scsi@vger.kernel.org>, martin.petersen@oracle.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, hmadhani@marvell.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/14/19 10:18 AM, Abdul Haleem wrote:
> On Wed, 2019-08-14 at 10:05 -0700, Bart Van Assche wrote:
>> On 8/14/19 9:52 AM, Abdul Haleem wrote:
>>> Greeting's
>>>
>>> Today's linux-next kernel (5.3.0-rc4-next-20190813)  booted with warning on my powerpc power 8 lpar
>>>
>>> The WARN_ON_ONCE() was introduced by commit 88263208 (scsi: qla2xxx: Complain if sp->done() is not...)
>>>
>>> boot logs:
>>>
>>> WARNING: CPU: 10 PID: 425 at drivers/scsi/qla2xxx/qla_isr.c:2784
>>
>> Hi Abdul,
>>
>> Thank you for having reported this. Is that the only warning reported on your setup by the qla2xxx
>> driver? If that warning is commented out, does the qla2xxx driver work as expected?
> 
> boot warning did not show up when the commit is reverted.
> 
> should I comment out only the WARN_ON_ONCE() which is causing the issue,
> and not the other one ?

Yes please. Commit 88263208 introduced five kernel warnings but I think 
only one of these should be removed again, e.g. as follows:

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index cd39ac18c5fd..d81b5ecce24b 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2780,8 +2780,6 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct 
rsp_que *rsp, void *pkt)

  	if (rsp->status_srb == NULL)
  		sp->done(sp, res);
-	else
-		WARN_ON_ONCE(true);
  }

  /**

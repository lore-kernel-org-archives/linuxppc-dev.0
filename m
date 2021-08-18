Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5934AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:05:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E0460ED5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99E0460ED5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqCSK3lmKz3bT7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:05:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.216.50; helo=mail-pj1-f50.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=<UNKNOWN>)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqCRr4dm8z302V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 13:04:38 +1000 (AEST)
Received: by mail-pj1-f50.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so7937993pjn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 20:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kFS3Uq6ZsmHwK49T3dK2XWC9mQnUHrZ+V1QDcN5t0xw=;
 b=gVsgvHH2dLthwU2y2tKM2V3QEobOYcahFDHVRkX2M7ARD7108EeMaNKsy2QFMGTmGy
 ZdYY4wblpJw1xbdgPrVzSrDRoKTwQW5NxR2xAKlvcb4qlt+/s3Ly5YP/0Kri0QLbczAJ
 pMyEq/kja13qHnn7gx5VKAcJE656EdcccDi363ZhvqX5CufNQJNS1BquLS0+SilaHsxh
 XtigjPt4UbCHuSjvNBY2skYEXElMtdzilVwHX08whGnN6r6QRwyWbkkmgVmFVUoITuk7
 IVbYEZV+sp5TmkQBKmIwpqvLHf1L8XIdXtkNeU7yRb/t9lgibzWo+3eDY3H/rQnypPYI
 LgLA==
X-Gm-Message-State: AOAM532c5uv/4NTIqkfYjTvEYr0gT4IrbKCauSD3VzubDjEIfhCa2Jrt
 p6Z29JV4NrTQctz3sjQLGeY=
X-Google-Smtp-Source: ABdhPJwiosH7FRNM+MeGt6bzDDz27hcq7NauAuf6SA6Kd4OUf3t5QxW8j9tarrxTkYERVxYBJNYY4Q==
X-Received: by 2002:a17:902:e850:b0:12d:91c6:1cd with SMTP id
 t16-20020a170902e85000b0012d91c601cdmr5415481plg.16.1629255875931; 
 Tue, 17 Aug 2021 20:04:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a2e:bdc6:d31c:3f87?
 ([2601:647:4000:d7:a2e:bdc6:d31c:3f87])
 by smtp.gmail.com with ESMTPSA id y12sm4995991pgk.7.2021.08.17.20.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Aug 2021 20:04:35 -0700 (PDT)
Subject: Re: [PATCH] scsi: ibmvfc: Stop using scsi_cmnd.tag
To: John Garry <john.garry@huawei.com>, tyreld@linux.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
References: <1629207817-211936-1-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <7c43a1e8-d10d-901c-a3a2-de36bb238ae5@acm.org>
Date: Tue, 17 Aug 2021 20:04:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1629207817-211936-1-git-send-email-john.garry@huawei.com>
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
Cc: sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, hare@suse.de,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/17/21 6:43 AM, John Garry wrote:
> Use scsi_cmd_to_rq(scsi_cmnd)->tag in preference to scsi_cmnd.tag.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

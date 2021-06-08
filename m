Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA04C47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 16:24:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3365961059
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 16:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3365961059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzwXw353Tz3c8B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 02:24:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.215.179;
 helo=mail-pg1-f179.google.com; envelope-from=bart.vanassche@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzwXX4LCnz302G
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 02:23:39 +1000 (AEST)
Received: by mail-pg1-f179.google.com with SMTP id y11so8784897pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 09:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qCqEbRr/ZPdmz8AchOJtyzKCBs+O43d8wPQ5fZZFjhk=;
 b=YKm/b3LQxwFDIzLhmU0Aef4GcJWJUjuuBu3xPtGzmSfYc4HMxvm4z0KCO7059OPx7x
 V9aqMI7EHKheyMxFTcxrHBu+cBMR23js3XCS/PZQR6/YFvVUKhdvZvY1aQ8vG+qTvIrP
 UzfuljdAB3uZfG6sAu+6WCiZtv9I9vdPePei0UKbjoLhZ4tMmdBPf4+RPVasth3dQut4
 +SV4on6fXDQKQH3WQ2hTn0b/bXAq330Je5pp5Jg0e1g+z6VxksMHS5+1ftgDhR3+AdUd
 L038SmNEpvejj5WDSAAya74JvZFkPpwyPIgCkEos10POo5FHrdqgVacqutub5L420dfM
 vg9w==
X-Gm-Message-State: AOAM5320AwIcZSZ9RpcKMLnR1fVUbj7jjRb2BAjW7j9rnEiTJpp0HuS4
 DuqDs+LfzIxHt5njgMjnQMQ=
X-Google-Smtp-Source: ABdhPJw4bmfvWGcz16m0nccIT5A1wyVoaTqb2ljpnWRWjedCwkO8zIDp8El5QdjOUdkYia3UO1TSlw==
X-Received: by 2002:a65:5684:: with SMTP id v4mr22680238pgs.218.1623169415549; 
 Tue, 08 Jun 2021 09:23:35 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id p40sm4440358pfw.142.2021.06.08.09.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 09:23:34 -0700 (PDT)
Subject: Re: [PATCH 02/16] MIPS: don't include <linux/genhd.h> in
 <asm/mach-rc32434/rb.h>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-3-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <9a073f63-65f6-6f3d-600d-e3900707fd06@acm.org>
Date: Tue, 8 Jun 2021 09:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608160603.1535935-3-hch@lst.de>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
 ceph-devel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 6/8/21 9:05 AM, Christoph Hellwig wrote:
> There is no need to include genhd.h from a random arch header, and not
> doing so prevents the possibility for nasty include loops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/include/asm/mach-rc32434/rb.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-rc32434/rb.h b/arch/mips/include/asm/mach-rc32434/rb.h
> index d502673a4f6c..34d179ca020b 100644
> --- a/arch/mips/include/asm/mach-rc32434/rb.h
> +++ b/arch/mips/include/asm/mach-rc32434/rb.h
> @@ -7,8 +7,6 @@
>  #ifndef __ASM_RC32434_RB_H
>  #define __ASM_RC32434_RB_H
>  
> -#include <linux/genhd.h>
> -
>  #define REGBASE		0x18000000
>  #define IDT434_REG_BASE ((volatile void *) KSEG1ADDR(REGBASE))
>  #define UART0BASE	0x58000

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

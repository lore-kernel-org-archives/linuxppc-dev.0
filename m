Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31534C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 08:58:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC47760EBD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 08:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC47760EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdX3k5Y9Wz30Gg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 18:58:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.46; helo=mail-wr1-f46.google.com;
 envelope-from=moritz.fischer.private@gmail.com; receiver=<UNKNOWN>)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GdX3M22n6z2xv2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 18:58:22 +1000 (AEST)
Received: by mail-wr1-f46.google.com with SMTP id z4so20580571wrv.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Aug 2021 01:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3w/K1BHHPdxnw4BgvCO49QjL9Du7QDixwLU5epoJCOs=;
 b=YSN4i65yaKWymLTLYCjT2zHIS8gonPQwOC5ZNK76Q0uWocBdtKTx1bp/wx2VmUzfjU
 QsdbvnNlz4DT8iT5329LSyja6Gpu82zcAAfOW1myWgDUJxnrX38WT8NQo+EOfpXEuTaX
 KkjuQ1cXFap8MYXy6kj3wpbhQIaEeJndCc1T4iklIypC6AYWJWm3knBhB1huwTrhYYqh
 V4vGHUuZ9U+pXltV94zRj0TNYpYzWlTKPOXOdji87rBzvyR8r0WhF1OqxdOh2JJoXU4f
 MePmRvQhU7qMizEeKSrPwcEswiHjEt+RokI3KMdhNB2ZkMZFGuh84KgkLEWWV/LOdUde
 vkWA==
X-Gm-Message-State: AOAM533HzKyNjpaThYCyscJNFV745PLfDl5+ssE/boRBY/1CqXpHmvov
 fdieI9YQdDUeE7I7HOdBPf8=
X-Google-Smtp-Source: ABdhPJx0/tMXH15yaWP4fTnBDctEXhuDmohjGavsyW1cAWu4hdthkDNgpjt8Fdob5jAXYMN8mboFgA==
X-Received: by 2002:adf:d194:: with SMTP id v20mr16017994wrc.126.1627894698889; 
 Mon, 02 Aug 2021 01:58:18 -0700 (PDT)
Received: from localhost ([149.172.45.165])
 by smtp.gmail.com with ESMTPSA id l4sm3773280wrw.32.2021.08.02.01.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 01:58:18 -0700 (PDT)
Date: Mon, 2 Aug 2021 01:58:17 -0700
From: Moritz Fischer <mdf@kernel.org>
To: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3] fpga: dfl: fme: Fix cpu hotplug issue in performance
 reporting
Message-ID: <YQezqZcOrePV/FnW@archbook>
References: <20210713074216.208391-1-kjain@linux.ibm.com>
 <61495dc0-f496-992c-1d2a-9229a04e6e44@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61495dc0-f496-992c-1d2a-9229a04e6e44@linux.ibm.com>
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
Cc: mark.rutland@arm.com, maddy@linux.ibm.com, rnsastry@linux.ibm.com,
 trix@redhat.com, linux-fpga@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com, mdf@kernel.org,
 will@kernel.org, yilun.xu@intel.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 02, 2021 at 01:15:00PM +0530, kajoljain wrote:
> 
> 
> On 7/13/21 1:12 PM, Kajol Jain wrote:
> > The performance reporting driver added cpu hotplug
> > feature but it didn't add pmu migration call in cpu
> > offline function.
> > This can create an issue incase the current designated
> > cpu being used to collect fme pmu data got offline,
> > as based on current code we are not migrating fme pmu to
> > new target cpu. Because of that perf will still try to
> > fetch data from that offline cpu and hence we will not
> > get counter data.
> > 
> > Patch fixed this issue by adding pmu_migrate_context call
> > in fme_perf_offline_cpu function.
> > 
> > Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
> > Tested-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > Cc: stable@vger.kernel.org
> > ---
> 
> Any update on this patch? Please let me know if any changes required.
> 
> Thanks,
> Kajol Jain

It's in my 'fixes' branch.

- Moritz

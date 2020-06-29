Return-Path: <SRS0=PIrw=AK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6452C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:29:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1556223D98
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBzWW384"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1556223D98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wSyT4MwhzDqRt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 23:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=htejun@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QBzWW384; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wSvD2QdPzDqQr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 23:26:45 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id b4so15151071qkn.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Fv6NdtXx3UPrY1o8G//J65B2AQrLdpFXjYCPaB28XJ4=;
 b=QBzWW384u9OvX1+fUOwtaycCV0CJ52SJrLmeisPsJZT2MkXib64D2XgXjqcZCQ1gHl
 VVu6OQvl/n/P/cFGz+Y239ImO9US3hFSEeQQSI5WIhYOPb1nHd81Jq7x2ACxzYcZqO3f
 rLJ28xCiUZOXEYFrnGDxxGpJOfRtblGiZqRXRShP77fsVblavOYIR7oY6VRiui1qJcA+
 OZtZ5c+W9enbTMpXOzJxOU0ZujiE4c1Z4fh/bM2ZhQLI9HKB26PM8zSfNddnnqsR4UB1
 Zl71fUJVG3JgmZqfzmK8dCNaJmRQwy1Gd+9Zgogqc+w0moLNTMSkoa4ZjhTPzhat8xqh
 bruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=Fv6NdtXx3UPrY1o8G//J65B2AQrLdpFXjYCPaB28XJ4=;
 b=IucT1zkCU2Xw1xJ2M5pvVZGXoTPaXPUlGPdFnHP4d3liwLjVzPWm+j2zarcJKNVxmY
 SbXzZ0AGZJWrUFrF0mskwGBjbs+KzoZuyl9Xp9sDI5r/SVoJmKrCSj9r6Fy/qi2sS/1+
 AGWjqplQyFv1gBUlEVR3mZemGG09Q5jguYT2GLCtyb5WO7EIO6T+UD7ZgEBWkzcc0lbD
 sHo2HxWGKD1Gm5I79FHPy6swPgwtqzCVL1zIaqokhZ9G+F4u1C5GE2IqVcavJbDrTdhj
 aggylo+sRkl3KpNbvIiRdjBSG8xs85wiWlULQ5TiW/Dy3QrQloikr11ekoRA1Ii2vcRB
 6Wnw==
X-Gm-Message-State: AOAM533i7G1cx830VUHdyGRrC1g6V3nBsu73/6k01V9iH0u3+SgM5dUz
 t6ggU9JrvaxE9VsHROC2zSM=
X-Google-Smtp-Source: ABdhPJyJSE7L2+zg2wyGl3Bgq/O+Nn9UDXROVlpMVeIyC6cjvIPEgQ+STEsV8Ezdk9o2oieugBEbSQ==
X-Received: by 2002:a37:47d1:: with SMTP id
 u200mr15401369qka.142.1593437200182; 
 Mon, 29 Jun 2020 06:26:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:26be])
 by smtp.gmail.com with ESMTPSA id o15sm16871725qko.67.2020.06.29.06.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:26:39 -0700 (PDT)
Date: Mon, 29 Jun 2020 09:26:38 -0400
From: Tejun Heo <tj@kernel.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/cacheinfo: Use cpumap_print to print cpumap
Message-ID: <20200629132638.GF13061@mtj.duckdns.org>
References: <20200629103703.4538-1-srikar@linux.vnet.ibm.com>
 <20200629103703.4538-2-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629103703.4538-2-srikar@linux.vnet.ibm.com>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 29, 2020 at 04:07:01PM +0530, Srikar Dronamraju wrote:
> Tejun Heo had modified shared_cpu_map_show to use scnprintf instead of
> cpumap_print during support for *pb[l] format.
> Refer commit 0c118b7bd09a ("powerpc: use %*pb[l] to print bitmaps including
> cpumasks and nodemasks")
> 
> cpumap_print_to_pagebuf is a standard function to print cpumap.  With
> commit 9cf79d115f0d ("bitmap: remove explicit newline handling using
> scnprintf format string"), there is no need to print explicit newline and
> trailing null character. cpumap_print_to_pagebuf internally uses
> scnprintf. Hence replace scnprintf with cpumap_print_to_pagebuf.
> 
> Note: shared_cpu_map_show in drivers/base/cacheinfo.c already uses
> cpumap_print_to_pagebuf.
> 
> Before this patch
> # cat /sys/devices/system/cpu0/cache/index1/shared_cpu_map
> 00ff
> 
> #
> 		(Notice the extra blank line).
> 
> After this patch
> # cat /sys/devices/system/cpu0/cache/index1/shared_cpu_map
> 00ff
> #
> 
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

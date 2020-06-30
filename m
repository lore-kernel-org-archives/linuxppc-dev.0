Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C22C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 19:47:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E53206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="t0+UuWJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E53206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xFJ03kXfzDqnf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 05:47:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2a00:1450:4864:20::643;
 helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=t0+UuWJ3; dkim-atps=neutral
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xFGD3ThGzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 05:45:47 +1000 (AEST)
Received: by mail-ej1-x643.google.com with SMTP id dp18so21834403ejc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qgx3IljQ5BIRlO4yBxZfoSES89T9T1+0rBYxa3AAvLM=;
 b=t0+UuWJ3hcB+YWsKOOBhSVmTSNzUldxsOxO8O0AnhZdpKk17xSwTbMukThuqybSmoS
 wPM9nDtRNNdaJZ9seKmg9WnnQIiG7+fm1ayOY/be0nmyli1ZCQpZBccV92DQjl+8S8x2
 CUQr0bxWU2o3O8hdNe/koalYIo4rtFz3bbftAS9vVB01TtpP+/Wmnd7/iTYdy8px6HBx
 GtZkEPaWLfRlFTzTh9gPxl6TdwuhmcukLic6t3NYXM1dX81E7IUk5cHkuExmv+CQjLgV
 ts5n/JMcHe/o+W339xE0TAxWtC/nWceBfqa7uQRoWYD2Vueouei+JJWjRbVCXLC7scDr
 fUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qgx3IljQ5BIRlO4yBxZfoSES89T9T1+0rBYxa3AAvLM=;
 b=Jl67zko7rM3itIjeOpoykF9DltsHXYkIREv2Cnw3zc6xCsHPJhFEEZXNQmKXk4FTB2
 kVzZSv9WUxFdWHhylZKca8h1ARVZVCGjNQVgJ8IZlEngLK7mX/rj7Ah1Yo+hCSaEjqum
 3cvluyNOpyEgiUQzm5zzyqZznjRcTEuSKcQBC5yME+4tBDGio8xzs4Ys5OYW/HKZup8h
 2wwXCnIrOrt536xD1wuJyCMUBmeJ3LSbaURkWMO0Cb5Ngg+eX2sbgtrVjubQrq7QKPBf
 zL4AHGWOBs1R+v4iZwcjFhz/Vjx4coV4an3FVF8XMQ+XeEDy1Zgve4PMfjwUO7WW5EiC
 jM/w==
X-Gm-Message-State: AOAM530bOdWsJVeIhEBhzzoSyxr5lBWBI9ynpoZciLaVCikdwSqhrWMp
 6L3afvtourIy1MHHfdGRRpF8xZ43F0QRuox+kZfoTw==
X-Google-Smtp-Source: ABdhPJyKl5EaEcTsTZ/D0hFYWRXDjmf8oBZd9cVwaYLp8hZe/lL/LJhRswILklwWIM5NrBKglrfm4H83B027mbEdiDg=
X-Received: by 2002:a17:906:da0f:: with SMTP id
 fi15mr19190809ejb.237.1593546341192; 
 Tue, 30 Jun 2020 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
 <20200629160940.GU21462@kitsune.suse.cz>
 <87lfk5hahc.fsf@linux.ibm.com>
 <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
 <20200630085413.GW21462@kitsune.suse.cz>
 <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
In-Reply-To: <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jun 2020 12:45:30 -0700
Message-ID: <CAPcyv4gHHjifQcLMdVgo9CyixHxe6OkCYdQ7Jfu2YB7tBqpDNg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Jeff Moyer <jmoyer@redhat.com>, Oliver O'Halloran <oohall@gmail.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 30, 2020 at 2:21 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
[..]
> >> The bio argument isn't for range based flushing, it is for flush
> >> operations that need to complete asynchronously.
> > How does the block layer determine that the pmem device needs
> > asynchronous fushing?
> >
>
>         set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>
> and dax_synchronous(dev)

Yes, but I think it is overkill to have an indirect function call just
for a single instruction.

How about something like this instead, to share a common pmem_wmb()
across x86 and powerpc.

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 20ff30c2ab93..b14009060c83 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1180,6 +1180,13 @@ int nvdimm_flush(struct nd_region *nd_region,
struct bio *bio)
 {
        int rc = 0;

+       /*
+        * pmem_wmb() is needed to 'sfence' all previous writes such
+        * that they are architecturally visible for the platform buffer
+        * flush.
+        */
+       pmem_wmb();
+
        if (!nd_region->flush)
                rc = generic_nvdimm_flush(nd_region);
        else {
@@ -1206,17 +1213,14 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
        idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));

        /*
-        * The first wmb() is needed to 'sfence' all previous writes
-        * such that they are architecturally visible for the platform
-        * buffer flush.  Note that we've already arranged for pmem
-        * writes to avoid the cache via memcpy_flushcache().  The final
-        * wmb() ensures ordering for the NVDIMM flush write.
+        * Note that we've already arranged for pmem writes to avoid the
+        * cache via memcpy_flushcache().  The final wmb() ensures
+        * ordering for the NVDIMM flush write.
         */
-       wmb();
        for (i = 0; i < nd_region->ndr_mappings; i++)
                if (ndrd_get_flush_wpq(ndrd, i, 0))
                        writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
-       wmb();
+       pmem_wmb();

        return 0;
 }

Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1EC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:24:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1929E2089D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIagEI/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YtKL1FcHzF3SN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 09:24:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIagEI/a";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIagEI/a"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YtGd17yzzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:22:16 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id l81-v6so10380919pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=idVPqMTWnPvxBijvXlg2fqOnfCoxVCmgtyviF8N53kc=;
 b=GIagEI/aodGYY6t77UWsjU2UaAG1VTxCuI8qwS/eHVxYuCoMAb//s9Md3Hbgd4sMzQ
 FpKT0vnIeNu8crTTRYeu6aV0Ek4vFTP3GO3yNTZQqGHkbJFGGMzSupnq2sT+iVZC4hzq
 xtw0yPfdKFRCyjLtv6M4NvVQFFWmnqIEUXqz7Uw2msmX2EYAuZ9U1gqVSwy9oAlzZbHa
 6xhBEMpjPN3qybaWfbmCqmsGNmiV/HWmHTRQG/IrKCw0aHvAsPtrCrLsC7flxfanwSrc
 dNRQYtLYeksP0j5PGCMuEyV5irdZhYV4kfyuS3Dm+au3ZJEwPX3RiGy7FO3/4IsbqwT/
 5QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=idVPqMTWnPvxBijvXlg2fqOnfCoxVCmgtyviF8N53kc=;
 b=RoyuL/zrszok0RtIoEumzCj2vBdCaPuhTQTtlLqS+AjptKE4s1uMqOjHVxLPkoWHgs
 +YkyVRNY1h3yMuG5+c8eVdw1PWW2O13zJOh8AA9+4dn5A/Q2CvypXsuw64GfMUEueOf0
 WALxDbFYrJG7u9AFpFAkE6tfdGqPERCmrylQV7oQtmZzjjWRSC2+JBsvfjgkLU2iwBce
 wEJa8zXh6OkSosTrkp90pn7dUf0KCNJTr8zYLxGz+MIJxWvphFmr1uXVgTRPut54+LCg
 5F0oy9NlyPTlY4SZpVtMH/P1xDW15CPjZtSyicL5+p9HZrUZpLK9TrbQ7t4nv+GAi1gK
 hD/A==
X-Gm-Message-State: ABuFfogVvSpWmdOb48OGpqQ3vYArUK6UM6R2LqUY+HSYyBcmDxz/1Je7
 tW3qkvNZ6cxMf3RiVaB29PY=
X-Google-Smtp-Source: ACcGV608YX+dmEzvd4xuzRBip+CAKD7WG91TZg7l8Jf/VKkyb5tfoM8qmqyInCnctvpNb+JO/iHI4A==
X-Received: by 2002:a63:bd41:: with SMTP id
 d1-v6mr16819671pgp.367.1539642135083; 
 Mon, 15 Oct 2018 15:22:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net.
 [108.223.40.66])
 by smtp.gmail.com with ESMTPSA id r65-v6sm15768554pfj.5.2018.10.15.15.22.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 15:22:14 -0700 (PDT)
Date: Mon, 15 Oct 2018 15:22:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015222213.GA31415@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015193914.GA9881@roeck-us.net>
 <20181016073359.3fa7bb32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016073359.3fa7bb32@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 16, 2018 at 07:33:59AM +1100, Stephen Rothwell wrote:
> Hi Guenter,
> 
> [Again, just cc'ing the PPC folks]
> 
> On Mon, 15 Oct 2018 12:39:14 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20181012:
> > > 
> > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > >   
> > 
> > Bisect log:
> > 

Trying again. Not very useful since some of the steps fail with compile errors.
The problem does seem to be related to the bootmem changes, though.

I might try again tonight if I find the time.

Guenter

# bad: [ca0591d03a2d373e0019ad357fbbee69c8272381] Add linux-next specific files for 20181015
# good: [0238df646e6224016a45505d2c111a24669ebe21] Linux 4.19-rc7
git bisect start 'HEAD' 'v4.19-rc7'
# good: [2fc8fb4c02a0f7b9d5e5b4de80cbcef7c808068b] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good 2fc8fb4c02a0f7b9d5e5b4de80cbcef7c808068b
# good: [a54eefdf4d208f6904da9e836ff32d7dde0c9516] Merge remote-tracking branch 'tip/auto-latest'
git bisect good a54eefdf4d208f6904da9e836ff32d7dde0c9516
# good: [d71e0d25be750d02a3d04500aeb151bb94465811] Merge remote-tracking branch 'staging/staging-next'
git bisect good d71e0d25be750d02a3d04500aeb151bb94465811
# good: [7961c8ea9d81f927a78e30bb7c194310ed6b7c1d] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good 7961c8ea9d81f927a78e30bb7c194310ed6b7c1d
# good: [c3d392e6aae57d54fdc683f7432c3e248602bebb] Merge remote-tracking branch 'xarray/xarray'
git bisect good c3d392e6aae57d54fdc683f7432c3e248602bebb
# good: [880c1034475c873963d6250eb95ebbbf5604a281] userfaultfd: selftest: cleanup help messages
git bisect good 880c1034475c873963d6250eb95ebbbf5604a281
# good: [9f1fa0ab60f7b09d335bbaf33db9116241059708] reiserfs: propagate errors from fill_with_dentries() properly
git bisect good 9f1fa0ab60f7b09d335bbaf33db9116241059708
# good: [596046ffd571f32fa3d3e7ffdf7861b71a258552] memblock: replace alloc_bootmem_low with memblock_alloc_low (2)
git bisect good 596046ffd571f32fa3d3e7ffdf7861b71a258552
# bad: [ef07e25e5bb02b420cb66004420cea3e0d65d107] dma-direct: fix up for the removal of linux/bootmem.h
git bisect bad ef07e25e5bb02b420cb66004420cea3e0d65d107
# good: [ddaa897c9ab76969a74d67a65b6616895f349644] memblock: replace alloc_bootmem with memblock_alloc
git bisect good ddaa897c9ab76969a74d67a65b6616895f349644
# good: [3b79243c2ef23d829a2f01f8c9526f17b80a7a32] memblock: rename free_all_bootmem to memblock_free_all
git bisect good 3b79243c2ef23d829a2f01f8c9526f17b80a7a32
# good: [d5fa9634892df2bc6bab6101f18df6ba5a2490c5] mm: remove nobootmem
git bisect good d5fa9634892df2bc6bab6101f18df6ba5a2490c5
# bad: [75fd637c22bc9bb5c959b7f93c2c5e5f0495992c] mm: remove include/linux/bootmem.h
git bisect bad 75fd637c22bc9bb5c959b7f93c2c5e5f0495992c
# good: [979961b3058df1a6d24ab423dd6fa6f20982f591] memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
git bisect good 979961b3058df1a6d24ab423dd6fa6f20982f591
# first bad commit: [75fd637c22bc9bb5c959b7f93c2c5e5f0495992c] mm: remove include/linux/bootmem.h

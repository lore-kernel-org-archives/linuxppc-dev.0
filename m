Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53424ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:02:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CC72145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s45Wc0k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CC72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bv1D4YNJzF3Zb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 16:02:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s45Wc0k0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s45Wc0k0"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42btyM3RWKzF3HP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:00:11 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id r190-v6so3613633pgr.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sLS02Ys+OMIWhw+yNf5/06qzYeiO5cQY5DdT8X34mjU=;
 b=s45Wc0k0Byoj2VVd+itXhQaAdS3xZwW8qY/k1ZDe6vyOX/GVyITR+P/1um4jMHzIx7
 ZD7XgV4FBRkcelP4ABKxfzU3JsbZQ/kZuFOYW8hwmPrryZ/GiO1HkTG6F2xQCO9ACe89
 r/xXsuY6BdeHqvfOhqjulMhvQRiib88P2vyT1iL2Krbd9e9Tv85z/ATHjHiutA4gbx3X
 zgS0eeLBpbQl3eoZSui0nUSvE1o1cfyAz8kMV+x1RzM9/mQUc6HLBd0XSJuskw7AwJlE
 nAjmIwUrJlpSV4d+tQj6X07fR/MohCPAHp2d4qcj+ggiCFZwJVLol4KSEN9c+o1yrayH
 Ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sLS02Ys+OMIWhw+yNf5/06qzYeiO5cQY5DdT8X34mjU=;
 b=EoPWidGtVthLYo0+7EeEThe4X5k5mODFXq0jMgF77EaEz+S3PDc0nOlFANeE41zwEE
 Q2gOv2KAL6hM91Sc2HK8wgOYxbrMJNvFkg6x7Atyfh/5jdxNEEMrcb4uPwxDlgFTWK/L
 UrfUeBl0vg7rSXOvCWx+3mWADeGrcAo2TEsDYrrzcCWuNjTg1WHFtaDqZPxXkFicnL9a
 vjUImf+aBDxYO83yrExkSILPRtIMvceDe+I/A2Ux0nVG6cgL4jMLV4QbyRgUZ6+8jvgL
 kRQuWF/IdgG+HsqVW3DinJhRNC68R0kKPTpwfQAWek1x7CF6YW1f+t1Lkw9M6dHrJ7uc
 ASnQ==
X-Gm-Message-State: ABuFfojaktu81EpBtFn661L2zdcrGDSQD1oE6pC8wdaR5uSQHaXjKz38
 odBLd8FZDEsg2GBgsm5cvRI=
X-Google-Smtp-Source: ACcGV61CCl6CBmfAeR+uXrxnDlA6la1edxKuEVcTLg4w63AJov7qKKF8wfFoOYf5d7b+71J6qUiQZg==
X-Received: by 2002:a65:4882:: with SMTP id
 n2-v6mr29726099pgs.225.1539925209479; 
 Thu, 18 Oct 2018 22:00:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id b81-v6sm40921622pfm.96.2018.10.18.22.00.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 22:00:08 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Message-ID: <5d8a5e46-b186-9c15-890a-ae6481652eaa@gmail.com>
Date: Thu, 18 Oct 2018 22:00:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/18/18 15:46, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
> 
> The checks revealed bugs in existing code.  Fixed the bugs.
> 
> While fixing bugs, noted other issues, which are fixed in
> separate patches.


git version of the series:


git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git

$ git checkout v4.19-rc1--kfree_validate--v5

$ git log --oneline v4.19-rc1..
62e8f28bb14b of: unittest: initialize args before calling of_*parse_*()
cc8b630f0c7f of: unittest: find overlays[] entry by name instead of index
b80a8e974e0f of: unittest: allow base devicetree to have symbol metadata
bbcd6ead8e36 of: overlay: set node fields from properties when add new overlay node
e02d06f99646 of: unittest: remove unused of_unittest_apply_overlay() argument
484ba7f7eb4a of: overlay: check prevents multiple fragments touching same property
4640b81a605b of: overlay: check prevents multiple fragments add or delete same node
698f942ee230 of: overlay: test case of two fragments adding same node
5fe758e00f1f of: overlay: make all pr_debug() and pr_err() messages unique
868c6f70eed5 of: overlay: validate overlay properties #address-cells and #size-cells
06bc44ce477f of: overlay: reorder fields in struct fragment
584f4537377c of: dynamic: change type of of_{at,de}tach_node() to void
54f30ea3bf65 of: overlay: do not duplicate properties from overlay for new nodes
ad4180c300fc of: overlay: use prop add changeset entry for property in new nodes
b1bdca739700 powerpc/pseries: add of_node_put() in dlpar_detach_node()
8e0290d5cb62 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
93e221495a9f of: overlay: add missing of_node_put() after add new node to changeset
86043f08e539 of: overlay: add tests to validate kfrees from overlay removal

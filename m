Return-Path: <SRS0=DwJy=ZQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28369C432C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Nov 2019 01:52:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39AA20679
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Nov 2019 01:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="i8e+poug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39AA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47LCpS47c2zDqwg
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Nov 2019 12:52:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47LClK51pYzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2019 12:49:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=netronome-com.20150623.gappssmtp.com
 header.i=@netronome-com.20150623.gappssmtp.com header.b="i8e+poug"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47LClK25tXz8t3K
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2019 12:49:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47LClK0qcBz9sQw; Sun, 24 Nov 2019 12:49:33 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=netronome.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=jakub.kicinski@netronome.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=netronome-com.20150623.gappssmtp.com
 header.i=@netronome-com.20150623.gappssmtp.com header.b="i8e+poug"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47LClJ5zgsz9sPZ
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Nov 2019 12:49:32 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id d199so870001pfd.11
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2019 17:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=f3cnDtSWrzhlJ/f7hX50pKYLqzfFggDpwt4E1h2xgOA=;
 b=i8e+pougR0WRoeZVP+6L6k6bEB115JqgEECWEo44LDAHBrc9IOkk6hk729t+vvNx6/
 Qi7h9JmYONdyCSYDQ4sa8zq+iz7s9yVRXKv5bvExlkCsY1IR0Mxcg71AcVfyn2WJFk2r
 mnA2dyjf5wXhhnKvjSXn0g0zPEJH7fnzSU2cuF4YZHcLxX/41oTxa44jEcyM67pforLe
 MnKkArTNHl74pUOOeTOZulSzL4sqw+QBIjpqShtw+wdL44U+r3L3aDMLSnoq2uLtvfqz
 IVuFt+GI+NzCH6hofjM6i47gC9SUUgUmiNW1XPZ4ldMWlcbLnKeCibAtBjidHWG/rWIk
 wM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=f3cnDtSWrzhlJ/f7hX50pKYLqzfFggDpwt4E1h2xgOA=;
 b=Ch4WSgQgPvmcZHyqR1jkYeuFql5w8dUtDtI1Kg7xFPRxhc8AQLaiThmbFwlYmbcnZ3
 IwuPdl2xCfYSmYa8IAKBPXaRnHND55UQIMXoaamV/bbRaRltiwqYKQjLsrPHnAPFc0aF
 T45xFtrWvauJ3fQcYCDUZZSoSAvmgr2yerQinA9EdbKQyrPTa1QJXRgeSa1277VK1IHK
 DKK9qnqQMzyGzweKu6PmULmMf1ekfRZzkBgOXabcqvGcWFOjI96CqLUatVOj7w3LWWE5
 NIwSHfR6I7oFZ7Ul5bf7plKx7/mr7YmBJ/EruOjDBn7GZCn7jxy5UwMoclj91/5L0NVJ
 UXZA==
X-Gm-Message-State: APjAAAXyfp8UtAan+x6/v3k6vM5yIxwyY3hqSggl+Cg+heZIqE46626y
 7OsKkH0H7GT7WvkxSPfV9l09+A==
X-Google-Smtp-Source: APXvYqwRL0J+gKnbkZ67+z3jCjqc9eVJjiIXaUqWYjR3VGNBBClttqrqhls1DcUga2UuguosnC+TBQ==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr24303855pgm.69.1574560169449; 
 Sat, 23 Nov 2019 17:49:29 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net.
 [73.202.202.92])
 by smtp.gmail.com with ESMTPSA id x190sm2926638pfc.89.2019.11.23.17.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2019 17:49:29 -0800 (PST)
Date: Sat, 23 Nov 2019 17:49:25 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net 0/4] ibmvnic: Harden device commands and queries
Message-ID: <20191123174925.30b73917@cakuba.netronome.com>
In-Reply-To: <1574451706-19058-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1574451706-19058-1-git-send-email-tlfalcon@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 julietk@linux.vnet.ibm.com, dnbanerg@us.ibm.com, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 22 Nov 2019 13:41:42 -0600, Thomas Falcon wrote:
> This patch series fixes some shortcomings with the current
> VNIC device command implementation. The first patch fixes
> the initialization of driver completion structures used
> for device commands. Additionally, all waits for device
> commands are bounded with a timeout in the event that the
> device does not respond or becomes inoperable. Finally,
> serialize queries to retain the integrity of device return
> codes.

I have minor comments on two patches, but also I think it's
a little late in the release cycle for putting this in net.

Could you target net-next and repost ASAP so it still makes 
it into 5.5?

Thanks.

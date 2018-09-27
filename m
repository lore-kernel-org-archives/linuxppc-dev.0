Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1EC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 22:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4B52170E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 22:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4B52170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LqFG0GbPzF39P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:27:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.173; helo=mail-oi1-f173.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LqC92n4mzF38P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 08:25:56 +1000 (AEST)
Received: by mail-oi1-f173.google.com with SMTP id u197-v6so3640656oif.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 15:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ShoJtjcjQb0gjp7YdjvKzVSuec6myPwgPyE/EvL7OBk=;
 b=Wn2dufLbpAbJgdXxtF5b2cE24nHe8rz4aOgFDRyZgkUd9n+/cPere1KcfmG4U9TOIb
 B8+01yTq1up08Hf358dx/HgTk5msaRmM/1gbHYbJ5ERs2tpMNwmn3oTQNP3nF4CNGD+X
 fE0bFtbY53NzZdo9bVN3JzqqWZ4B3BRV1aFmtkGVxfCvxP12JaMZ3KsXDc6NPV8sTdFn
 BoS57Jjxlx2Xpc3uVHKcTBdLI8UnhrUhPab/lRPo4ovGU82SbXUE9aqRzzMmJ/ggBR8r
 XzSgOlNyJ/FHF1vdCGUKQ/rn4IX0RHnbT2xyOIslAlsMjRMeLDtBA1WwKq0hJTSRqndO
 9Z5Q==
X-Gm-Message-State: ABuFfoibynOCCLgsxVsg3a+PUqI+Cs/lqrjE4IFccz2gWIvUt+Mxc72u
 XusOivYbqySgaT02j3hJjZVrpcI4bx4=
X-Google-Smtp-Source: ACcGV60++nOx9vnSu6kXjqX0cYJGUBNunv06th0HYbr66lJ/3Pxu0gX8iddRiSmA8OB6bH42TPtJdQ==
X-Received: by 2002:aca:e1d4:: with SMTP id
 y203-v6mr1119728oig.313.1538087154710; 
 Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com.
 [209.85.167.180])
 by smtp.gmail.com with ESMTPSA id v34-v6sm1282364ota.30.2018.09.27.15.25.54
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e17-v6so2752494oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
X-Received: by 2002:aca:fd89:: with SMTP id
 b131-v6mr4395787oii.30.1538087154014; 
 Thu, 27 Sep 2018 15:25:54 -0700 (PDT)
MIME-Version: 1.0
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 27 Sep 2018 17:25:42 -0500
X-Gmail-Original-Message-ID: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Message-ID: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Subject: drivers binding to device node with multiple compatible strings
To: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@secretlab.ca>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob and Grant,

Various device tree specs are recommending to include all the
potential compatible strings in the device node, with the order from
most specific to most general.  But it looks like Linux kernel doesn't
provide a way to bind the device to the most specific driver, however,
the first registered compatible driver will be bound.

As more and more generic drivers are added to the Linux kernel, they
are competing with the more specific vendor drivers and causes problem
when both are built into the kernel.  I'm wondering if there is a
generic solution (or in plan) to make the most specific driver bound
to the device.   Or we have to disable the more general driver or
remove the more general compatible string from the device tree?

Regards,
Leo

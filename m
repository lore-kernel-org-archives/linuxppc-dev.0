Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BFC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:33:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BA020833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BA020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dhtj1kXpzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 19:33:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dhqQ6LfwzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 19:30:58 +1000 (AEST)
Received: by mail-ot1-f65.google.com with SMTP id k21so14956986otf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 02:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xF0MHbJVnFRkXMVSY0Sz0OcFAfptosSeLujRNokzuKU=;
 b=V67Bj9V3gdFPLK8fxu5X0g37ccPxe+HrAK56ZbaHu5Ocu/2XzTwhbzDht6GjzwWFLV
 g+sE7vOZGMUVFKQ13yf+fRPxB/XJkGck+F3EfZVqbE8PJd1Z9n96Rba62ZxtzfwhQCHl
 tzJURu/7NE0G4YYKNN63mn0Zk0267HD6hHlVn2RjjwWnJrz9y2bWPxMKFloIbPgS6Pbi
 9SlxixNpNAJs9vSiaKyBNyTrFUxb26s1ECk01oddesFcacePcxu4M6tFegYyUWpgd+F+
 z8RWxv2vC4K4/d79yngVedohtK5IelfM9v26UPaURgwYISasP256NniBegH2Dbn9GYn5
 W59Q==
X-Gm-Message-State: APjAAAW1o5ee4VbngZJrm03su0mcDSv7wddzTY0z9T2gO14ZjXmUYE99
 6+jIWd22aTEGzpB05iv5RI2AspWZBMe2bKF4JqU=
X-Google-Smtp-Source: APXvYqy2whJeRDYFhQ1WR8epZJWXwBAbpl0SMfSDW3+AyfZoBtTVvs/WROgMZn7JgUsV/JmPbpgj6GGcqBKPhykhhEs=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr3637022otb.20.1554802255792; 
 Tue, 09 Apr 2019 02:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
 <87r2acwpp2.fsf@dja-thinkpad.axtens.net>
 <a8368cfa-9667-5f5b-cafe-f4830ece0f26@linux.vnet.ibm.com>
In-Reply-To: <a8368cfa-9667-5f5b-cafe-f4830ece0f26@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Apr 2019 11:30:44 +0200
Message-ID: <CAJZ5v0jS7HX3ka59OhYzbdgdAYDO_DTwp44gxar_xQV_AsscSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
To: Abhishek <huntbag@linux.vnet.ibm.com>
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 9, 2019 at 11:29 AM Abhishek <huntbag@linux.vnet.ibm.com> wrote:
>
> Hi Daniel,
>
> Thanks for such a descriptive review. I will include all the suggestions
> made in my next iteration.

Please give me some time to send comments before that.

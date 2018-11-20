Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C542C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 15:28:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A37F206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 15:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A37F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zqNG0xkwzF3Q3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 02:28:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.180; helo=mail-oi1-f180.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zqLC2h2DzF3Pc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 02:26:24 +1100 (AEDT)
Received: by mail-oi1-f180.google.com with SMTP id c206so1816889oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 07:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7RV4jpejzcCqpczwJOehT7Z4PvwgjLeWGEDEIYNZuxs=;
 b=fWKtTBgpA/tD7Nk/5bH8XmOqPSfEyqfhKKmeL2TsiaH+C/ccwHY809vNjD4ETUB4j3
 /asphUm+XIFF5TeaM3/1sSL2KZGYA4gZUqeKvXuIQOzG0J1ozbN7ShG+Ijov2xZQCO32
 HgBPpLX5vFkVzLxl9EIWiCVT8Diq/uOt5KP5O/cNHxOlHoxaYKMBi7/sRvIUxCKTrIad
 kvp7pAHgKNlkmQODKCvwE+bBkOOPyFcELWduBT/dvwxI+Vhs9HSABf64rzMW5Pn6HiIe
 3FXT4YzHGMrrAMEIeHqVNcZuXvxcAcSq3iYxAbV2jPOqLyYgHLoVoKEl/b0SmJuE79cI
 Yhrw==
X-Gm-Message-State: AGRZ1gKn5c51DtVZMG/1C/iRB7mXU9dUQTRNpQDr3EtXn5tpt0y/Cj8/
 Mx1zEi7C0Xacf3WOsPmVp8iLrh2dRKqWkIE9bBo=
X-Google-Smtp-Source: AJdET5ejeza/oNT/McC597SElVwDwwxHaPJoDmw05WLgs6PCmjZd5FPWe3O4k3z4zX2SxAawmseejBAx/CPK8dQdUo0=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr1360967oia.95.1542727582020; 
 Tue, 20 Nov 2018 07:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20181120125731.19368-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120125731.19368-1-tiny.windzz@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Nov 2018 16:26:09 +0100
Message-ID: <CAJZ5v0gY7kO-iZBLFSYHi57hsRUbsetJa0evjfmh2KCgkHLSRA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: add of_node_put()
To: tiny.windzz@gmail.com
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
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 1:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> use of_node_put() to release the refcount.

Again, this changelog is as good as no changelog at all.

If you are adding a missing of_node_put(), please say that and explain
why it is necessary.

Thanks,
Rafael

Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F6DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EB520838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDtcr3wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EB520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yjRL594mzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 21:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDtcr3wy"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yjPW3ZqhzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 21:55:43 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id x10so11078152wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
 b=QDtcr3wyAWwC1Feiwyp3X/8YTfaIdNpEWSGZejYjQTG/rj0trYk0vC6rQn4y2cNbXv
 il1Avd23/d1Hd8k+uTbZBtAoIRuLEkjW3uPerX4NcbTux104Th18LvFAtlUMw0zOO1LL
 tLmqEa0y4zRbQ5L3wXHA0BYGnh9on2hBdn58O1L8DaUmAwdWpiMdKB6WiTyS7C6wf6Bh
 MC78xcq2N19Sr8d1ee6X2SFh4BhB3mZOszFFAIe2XAVy/T1Xcb8vx1blQzxEH3d3ygOa
 1lUqargunUNH4IWUAEw1tmMjRZ4VOjSK4lFppReznME5P372JKKIbFQpvePfCELqMthw
 iSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
 b=MqqdLWnSCDOGkSYEfbLY5LjSee5VU/tuzTYoZDc3Xr2FEYFw+VwpCXhQuaYh/caz+n
 8ViwkYJ3gAjC0YW4Eb9pYoXGqY73KEFUA/DTLe3KabSxWvcnwNlN6qqHi7QoUMvRmrFj
 m1X2ySDiOkBF6Hp69AzyPO5YdFjAFtkMB/eEeP1zJg4CBfZ6rkXOfVRmGAsce/K24wwo
 tkY2mC724lUg4X9QXdbpeCftUGPvmdiOerHOD6f+CC1/qY0qb1FfN/fKT164jPI7vqO5
 Ti2GthHi4pnevC4PrRiklCb5kH4hwLgpy/Ov1Xv+ezuvM9nxrBc1/egR5tK4gC/Ox6He
 psCA==
X-Gm-Message-State: AHQUAuacwHXINcWnEx8DlvOZMhV0QSEMIc56GPAn3Y0KrgeeZjUCfn8a
 CZBvH5tS/vLbb6J5MK2rdZQ=
X-Google-Smtp-Source: AHgI3IYfCwXm72SvHpZjHfYZL/JOp3IzO2HnfloWBghOcIo+EQ24FCA5PhxAIN+bIRKZbXHjD7QYjw==
X-Received: by 2002:a1c:a6c9:: with SMTP id p192mr2919879wme.58.1549882540793; 
 Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id s8sm22757121wrn.44.2019.02.11.02.55.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Date: Mon, 11 Feb 2019 11:55:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105537.GA59133@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
 <20190211103927.GA118071@gmail.com>
 <20190211105214.GA30880@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211105214.GA30880@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Feb 11, 2019 at 11:39:27AM +0100, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > Sounds good to me - I've merged this patch, will push it out after 
> > > testing.
> > 
> > Based on Peter's feedback I'm delaying this - performance testing on at 
> > least one key ll/sc arch would be nice indeed.
> 
> Once Waiman has posted a new version, I can take it for a spin on some
> arm64 boxen if he shares his workload.

Cool, thanks!

	Ingo

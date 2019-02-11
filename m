Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C95EC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:42:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8739320811
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QugwUPgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8739320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yd6C4FsjzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 18:42:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QugwUPgc"; 
 dkim-atps=neutral
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yd223bFQzDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 18:38:34 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id x10so9605535wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
 b=QugwUPgcpfU3+Tm9+uRiY+VeoOW1hrVgrzjfbonMin4cw7g0zWY7xW+3Mit8PQfprX
 QPeCFmub2fnVz6mKV4rLOkZE0BJ3RX4AxWW5dSA6I9alAM9EnEpQiM5EEJg/Q3NN25w9
 Sksw1pfELw9mSjghnPIG5gPaKrMz49anPYySUg6RzUppp3MHsd4BR4WQQvy0BL7EGBb7
 5u2uvV7tKrN/HdTBi8u8Dg7tWUi+LHlqKfAZr49t/fMVgzjMfVmRex+57Sckpoalu05B
 LM6RFLVkUPg8iY5FadJ7YAkqHe/N9pHEV2ZD69QaiIh0ha2DBdykzx8mHYbwRQfeh8E0
 OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=j1zWKIlZsVjo0SP2EC7fZlyHxeWBFLCgtgW8EIbDbOE=;
 b=Ee2oaWNfA+dFZsUdK51niDBC0xVHIO5eS4cjglNqy3A3aYzbGDGXp15fGLxIo6ffe/
 t3MyrYGYq9OEdu9xTl5vvPPhqAPG5HkrSpbZ2+0EMtlpqDQrbhHn4chiEz45dvwDYUwX
 HNVkkb6xyPUFFPVZv+xSpjlQRAY2aegPRkl4TINqCP3krEe5C0Tw6bVANCe48K06lTjM
 qT/RMt0CDl9AQ+DFnLpslxxVVT0E+fA8mnQitkKF6jGF7lPPI2j5n87JLVSA7WUIuKj7
 LpDwnLGZ8dDGJSffmjuC47wUywQI77KDG3vE0KeO61xoKaOVjIGt2t6Ai29GJ8oJxFpY
 7RbQ==
X-Gm-Message-State: AHQUAuZL65QWfj2kKbZm2XuiawR5lL/yoQPDPprile+mYhfAcE7mZooQ
 eeuGrve2hxJrp09wsMdEUo4=
X-Google-Smtp-Source: AHgI3IabznfRCQX4qyQonoc9mGE4Iu1ZLqbFlbxiVnApqa0fDXIc+az+/yufddL5FoyENYBy8lVfbg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr12077501wri.100.1549870711601; 
 Sun, 10 Feb 2019 23:38:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id x3sm12933033wrd.19.2019.02.10.23.38.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 23:38:30 -0800 (PST)
Date: Mon, 11 Feb 2019 08:38:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Message-ID: <20190211073828.GB106308@gmail.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
 <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
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
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Waiman Long <longman@redhat.com> wrote:

> On 02/07/2019 02:51 PM, Davidlohr Bueso wrote:
> > On Thu, 07 Feb 2019, Waiman Long wrote:
> >> 30 files changed, 1197 insertions(+), 1594 deletions(-)
> >
> > Performance numbers on numerous workloads, pretty please.
> >
> > I'll go and throw this at my mmap_sem intensive workloads
> > I've collected.
> >
> > Thanks,
> > Davidlohr
> 
> Thanks for getting some of the performance numbers. This is the initial
> draft after more than 1 years of hibernation. I will also get other
> performance numbers in subsequent revision of the patch.

If you could sort all the invariant preparatory patches to the head of 
the series I can merge them to reduce overall complexity and simplify 
performance testing and review of the rest.

Thanks,

	Ingo

Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B6C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABBF222BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0Uu+1sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABBF222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsc84N73zDqXR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:08:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="n0Uu+1sp"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zs5W2W6kzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:45:51 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id j125so1274606wmj.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
 b=n0Uu+1spwh6BP8F080TtY1cvdPiS5MomeYgaSXLX0ODIFfwbvTDCFCySsQcLxVKGmM
 dw/96VmrPhtvCuR7/3aha/Y+YTXZYmokABimDEcEnAeR0hD3UDlcQCUCKdmikIZpJm7D
 V81pl3f8hRpJxAFdazAHEXOg7tIHMAM9CYE2zVy7dMTLwKTYDzwRNPhxrhdAIO52PsDj
 w/7l9Pu0cYzoafONIE5xszt/iaFRaoZh+SEBV/1dLccfZHIgA35DSaB0okBf0jyDgwDz
 kUXx6/grQqC0RNDfrI1CRbMCF2x8FbFq5HpRq/FEdLVE5s+21PZZUKFE+EKOUMwCUXXD
 hTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
 b=RAR3wC+Taol99fJlF7IeSsROFskJELc3EeKCG4nzktapiMxhqblx+hdT4CgZVd5sYd
 INnNSrUJ7EQ58wv7W3DJb7kyzm18tZ0hMYSRxGVR04hqnvutn5sMySJVYoZj+1o5MMyT
 HWbcIi20Wf8j0MkuXiDwobXH0O+vCL6QWWtxUxxn0gLsgUeZgFNMth9sB3Ti+0qAtHNR
 Jss0NyWJ19ELed8oXrEBHXDCPnYwKEa8Kh3vcCI3jVE45B6qbr/fo76j2kXM4NmbrXQX
 Lgwefb7zmWFCpvrF3hd8o6WVO8M5WJempodUSH3RYwljaXNY2sdcJXy97zsdzzz2qdVK
 iUkA==
X-Gm-Message-State: AHQUAubE8ZpjSqBnS2jDPu7qpfC7DYx8L28DB79tUXn9YoL5cns9d31H
 VJO10O8pE1Zsyn5cwSiJEnI=
X-Google-Smtp-Source: AHgI3IZUCQNNdjmNfZR03XpdWC0K36paSAMR5JYQTu6XL1rM9r4b6zd01sh6EsJm+bWZZlyeBZ+N7A==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr2238898wmc.116.1550043947629; 
 Tue, 12 Feb 2019 23:45:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id m4sm5399647wmi.3.2019.02.12.23.45.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 23:45:46 -0800 (PST)
Date: Wed, 13 Feb 2019 08:45:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190213074544.GB62549@gmail.com>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
 <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
 <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch <linux-arch@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Waiman Long <longman@redhat.com> wrote:

> I looked at the assembly code in arch/x86/include/asm/rwsem.h. For both
> trylocks (read & write), the count is read first before attempting to
> lock it. We did the same for all trylock functions in other locks.
> Depending on how the trylock is used and how contended the lock is, it
> may help or hurt performance. Changing down_read_trylock to do an
> unconditional cmpxchg will change the performance profile of existing
> code. So I would prefer keeping the current code.
> 
> I do notice now that the generic down_write_trylock() code is doing an
> unconditional compxchg. So I wonder if we should change it to read the
> lock first like other trylocks or just leave it as it is.

No, I think we should instead move the other trylocks to the 
try-for-ownership model as well, like Linus suggested.

That's the general assumption we make in locking primitives, that we 
optimize for the common, expected case - which would be that the trylock 
succeeds, and I don't see why trylock primitives should be different.

In fact I can see more ways for read-for-sharing to perform suboptimally 
on larger systems.

Thanks,

	Ingo

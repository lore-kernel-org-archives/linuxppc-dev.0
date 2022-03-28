Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4040EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Mar 2022 12:00:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRrq45GJHz3c4H
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Mar 2022 23:00:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=InedvJYk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=InedvJYk; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRrpL2hxKz2xSN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2022 22:59:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RyQhY95RNsCK4Pvvmfcn6PT7x9nJFEOteS09X0MJ5gc=; b=InedvJYkxngIeEPtMsu0qc2tRm
 V4VMLB5/wuDOLAUFEvYfK9ZL3hrr6Iw3AFTHeBZZyWZfUx6YSRRIkUfBIYWvUPSuN+6d9+g6WB2D2
 16wOx2KwxVH+F1/NS91y4XziCmgGqsL3eaHou4ZO99Da/UN91P8qfChyu/CfzsaudJoDGF4w2Rp2j
 1dVBWWzIePh394HgRA1XA+fi5rTXrdTiYlVXJ62YW0K4GBQNK9QPHxVmJnghZzgsCQb2LhkxdRIFb
 ryVvHt/QEZGtowPPi+xTKq6c5q68waGzcFZkQ2bnY6KcAVauT2O8njz/z8/inqE6AQFnagRLAGrfj
 BKw/6N0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYo1F-005QtX-1J; Mon, 28 Mar 2022 11:58:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id A36C39861E7; Mon, 28 Mar 2022 13:58:44 +0200 (CEST)
Date: Mon, 28 Mar 2022 13:58:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH] sched: topology: add input parameter for
 sched_domain_flags_f()
Message-ID: <20220328115844.GC8939@worktop.programming.kicks-ass.net>
References: <1648461219-4333-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648461219-4333-1-git-send-email-wangqing@vivo.com>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mel Gorman <mgorman@suse.de>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 28, 2022 at 02:53:37AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> sched_domain_flags_f() are statically set now, but actually, we can get a
> lot of necessary information based on the cpu_map. e.g. we can know whether
> its cache is shared.
> 
> Allows custom extension without affecting current.

This all still makes absolutely no sense. The architecture builds these
masks, the architecture is in charge of which flags function is called
on which mask.

Passing the mask back in means it lost the plot somewhere and doens't
know wth it's doing anymore.

NAK

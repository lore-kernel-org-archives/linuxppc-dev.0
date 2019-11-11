Return-Path: <SRS0=mxpJ=ZD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8EEC43331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 12:49:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2DD21872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2DD21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47BW0H4CQFzF3bd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 23:49:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=ubuntu.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=christian.brauner@ubuntu.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ubuntu.com
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47BVvR3Yt7zF3jR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2019 23:44:51 +1100 (AEDT)
Received: from p54ac5540.dip0.t-ipconnect.de ([84.172.85.64] helo=wittgenstein)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.brauner@ubuntu.com>)
 id 1iU93T-00015J-4X; Mon, 11 Nov 2019 12:44:27 +0000
Date: Mon, 11 Nov 2019 13:44:26 +0100
From: Christian Brauner <christian.brauner@ubuntu.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/23] y2038: syscalls: change remaining timeval to
 __kernel_old_timeval
Message-ID: <20191111124425.bmsdg5e4ikpdh5bu@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-3-arnd@arndb.de>
User-Agent: NeoMutt/20180716
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 y2038@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christian Brauner <christian@brauner.io>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 08, 2019 at 10:12:11PM +0100, Arnd Bergmann wrote:
> All of the remaining syscalls that pass a timeval (gettimeofday, utime,
> futimesat) can trivially be changed to pass a __kernel_old_timeval
> instead, which has a compatible layout, but avoids ambiguity with
> the timeval type in user space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems reasonable.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

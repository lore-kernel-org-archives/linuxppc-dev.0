Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604BC04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 11:04:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B2A2070D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 11:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B2A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CrZt6fGxzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 21:04:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CrYW0k2fzDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 21:03:27 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44A8E307B963;
 Tue, 28 May 2019 11:03:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-154.ams2.redhat.com
 [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1D0A1B479;
 Tue, 28 May 2019 11:03:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] [RFC] Remove bdflush syscall stub
References: <20190528101012.11402-1-chrubis@suse.cz>
 <mvmr28idgfu.fsf@linux-m68k.org> <20190528104017.GA11969@rei>
Date: Tue, 28 May 2019 13:03:20 +0200
In-Reply-To: <20190528104017.GA11969@rei> (Cyril Hrubis's message of "Tue, 28
 May 2019 12:40:18 +0200")
Message-ID: <87ftoyg7t3.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 28 May 2019 11:03:25 +0000 (UTC)
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
Cc: linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-api@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, lkml <linux-kernel@vger.kernel.org>,
 linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Andreas Schwab <schwab@linux-m68k.org>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Cyril Hrubis:

> Hi!
>> > I've tested the patch on i386. Before the patch calling bdflush() with
>> > attempt to tune a variable returned 0 and after the patch the syscall
>> > fails with EINVAL.
>> 
>> Should be ENOSYS, doesn't it?
>
> My bad, the LTP syscall wrapper handles ENOSYS and produces skipped
> results based on that.
>
> EINVAL is what you get for not yet implemented syscalls, i.e. new
> syscall on old kernel.

EINVAL?  Is that a bdflush-specific thing, test-specific, or is itmore
general?

glibc has fallback paths that test for ENOSYS only.  EINVAL will be
passed to the application, skipping fallback.  For missing system calls,
this is not what we want.

Thanks,
Florian

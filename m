Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35774C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 13:12:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FB620856
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 13:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FB620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457bm22f1YzDqPw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 23:12:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457bjr5KmKzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 23:10:56 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A31313086231;
 Tue, 21 May 2019 13:10:24 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52692665F4;
 Tue, 21 May 2019 13:10:13 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 1/2] open: add close_range()
References: <20190521113448.20654-1-christian@brauner.io>
 <87tvdoau12.fsf@oldenburg2.str.redhat.com>
 <20190521130438.q3u4wvve7p6md6cm@brauner.io>
Date: Tue, 21 May 2019 15:10:11 +0200
In-Reply-To: <20190521130438.q3u4wvve7p6md6cm@brauner.io> (Christian Brauner's
 message of "Tue, 21 May 2019 15:04:39 +0200")
Message-ID: <87h89o9cng.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 21 May 2019 13:10:47 +0000 (UTC)
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
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org, shuah@kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, miklos@szeredi.hu,
 x86@kernel.org, torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, tkjos@android.com, arnd@arndb.de,
 jannh@google.com, linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk,
 tglx@linutronix.de, ldv@altlinux.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org, oleg@redhat.com,
 linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Christian Brauner:

>> Solaris has an fdwalk function:
>> 
>>   <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>
>> 
>> So a different way to implement this would expose a nextfd system call
>
> Meh. If nextfd() then I would like it to be able to:
> - get the nextfd(fd) >= fd
> - get highest open fd e.g. nextfd(-1)

The highest open descriptor isn't istering for fdwalk because nextfd
would just fail.

> But then I wonder if nextfd() needs to be a syscall and isn't just
> either:
> fcntl(fd, F_GET_NEXT)?
> or
> prctl(PR_GET_NEXT)?

I think the fcntl route is a bit iffy because you might need it to get
the *first* valid descriptor.

>> to userspace, so that we can use that to implement both fdwalk and
>> closefrom.  But maybe fdwalk is just too obscure, given the existence of
>> /proc.
>
> Yeah we probably don't need fdwalk.

Agreed.  Just wanted to bring it up for completeness.  I certainly don't
want to derail the implementation of close_range.

Thanks,
Florian
